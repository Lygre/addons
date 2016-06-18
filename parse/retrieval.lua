--[[ TO DO

	-- Implement player filtering
	-- Implement temporary mob_filters variable for reporting function

]]

percent_table = {
		intimidate = S{"hit","block","anticipate","parry","evade"},
		evade = S{"hit","block","anticipate","parry"},
		parry = S{"nonparry"},
		anticipate = S{"hit","block"},
		block = S{"nonblock"},
		absorb = S{"hit","block"},
	
		melee = S{"miss","+crit"},
		crit = S{"melee"},
		
		ranged = S{"r_miss","+r_crit"},
		r_crit = S{"ranged"},
		
		ws = S{"ws_miss"},
		ja = S{"ja_miss"},
		
		['1'] = S{'2','3','4','5','6','7','8'},
		['2'] = S{'1','3','4','5','6','7','8'},
		['3'] = S{'1','2','4','5','6','7','8'},
		['4'] = S{'1','2','3','5','6','7','8'},
		['5'] = S{'1','2','3','4','6','7','8'},
		['6'] = S{'1','2','3','4','5','7','8'},
		['7'] = S{'1','2','3','4','5','6','8'},
		['8'] = S{'1','2','3','4','5','6','7'},
	}

-- Returns a table of players	
function get_players()
	local player_table = L{}
	
	for mob,players in pairs(database) do
		for player,__ in pairs(players) do
			if not player_table:contains(player) then
				player_table:append(player)
			end
		end
	end
	
	return player_table
end

-- Returns a table of monsters	
function get_mobs()
	local mob_table = L{}
	
	for mob,players in pairs(database) do
		if not mob_table:contains(mob) then
			mob_table:append(mob)
		end
	end
	
	return mob_table
end

-- Returns a list of players, sorted by a particular stat or stat type, and limited to a number (or to 20, if no number provided)
function get_sorted_players(sort_value,limit)
	local player_table = get_players()
	if not get_players() then
		return nil
	end
	
	if not limit then
		limit = 20
	end
	
	if S{'multi','1','2','3','4','5','6','7','8'}:contains(sort_value) then
		sort_value = 'melee'
	end

	local sorted_player_table = L{}
	
	for i=1,limit,+1 do
		player_name = nil
		top_result = 0
		for __,player in pairs(player_table) do
			if sort_value == 'damage' then -- sort by total damage
				if get_player_damage(player) > top_result and not sorted_player_table:contains(player) then
					top_result = get_player_damage(player)
					player_name = player					
				end						
			elseif sort_value == 'defense' then -- sort by total parry/hit/evades/blocks
				player_hits_received = get_player_stat_tally('parry',player) + get_player_stat_tally('hit',player) + get_player_stat_tally('evade',player) + get_player_stat_tally('block',player)
				if player_hits_received > top_result and not sorted_player_table:contains(player) then
					top_result = player_hits_received
					player_name = player
				end
			elseif S{'ws','ja','spell'}:contains(sort_value) and get_player_stat_avg(sort_value,player) then -- sort by avg
				if get_player_stat_avg(sort_value,player) > top_result and not sorted_player_table:contains(player) then
					top_result = get_player_stat_avg(sort_value,player)
					player_name = player
				end				
			elseif S{'hit','miss','nonblock','nonparry','r_miss'}:contains(sort_value) then -- sort by tally
				if get_player_stat_tally(sort_value,player) > top_result and not sorted_player_table:contains(player) then
					top_result = get_player_stat_tally(sort_value,player)
					player_name = player
				end		
			elseif (S{'melee','ranged','crit','r_crit'}:contains(sort_value) or get_stat_type(sort_value)=="defense") and get_player_stat_percent(sort_value,player) then -- sort by percent
				if get_player_stat_percent(sort_value,player) > top_result and not sorted_player_table:contains(player) then
					top_result = get_player_stat_percent(sort_value,player)
					player_name = player
				end	
			elseif S{'sc','add','spike'}:contains(sort_value) then --sort by damage
				if get_player_stat_damage(sort_value,player) > top_result and not sorted_player_table:contains(player) then
					top_result = get_player_stat_damage(sort_value,player)
					player_name = player
				end	
			end
		end	
		if player_name then sorted_player_table:append(player_name) end		
	end

	
	return sorted_player_table
end

--takes table and collapses WS, JA, and spells
function collapse_categories(t)
	for key,value in pairs(t) do
		if get_stat_type(key)=='category' then -- ws, ja, spell
			spells = value
			t[key].tally = 0
			t[key].damage = 0
			for spell,data in pairs(value) do
				if type(data)=='table' then
					t[key].tally = data.tally
					t[key].damage = data.damage
					t[key][spell] = nil
				end
			end
			return
		elseif type(value)=='table' then -- go deeper
			collapse_categories(value)
		else
			return -- hit a dead end, go back
		end
	end
	
	return t
end

function collapse_mobs(s_type,mob_filters)
	local player_table = nil
	
	for mob,players in pairs(copy(database)) do
		if not player_table then
			player_table = {}
		end
		if check_filters('mob',mob) then
			for player,player_data in pairs(players) do
				if check_filters('player',player) then
					if not player_table[player] then
						player_table[player] = player_data
					else
						merge_tables(player_table[player],player_data)
					end
				end				
			end
		end
	end
	
	if player_table then
		collapse_categories(player_table)
	end

	return player_table
end

function get_player_spell_table(spell_type,mob_filters)
	local player_table = nil
	
	for mob,players in pairs(database) do
		if not player_table then
			player_table = {}
		end
		if check_filters('mob',mob) then
			for player,mob_player_table in pairs(players) do
				if check_filters('player',player) then
					if not player_table[player] then
						player_table[player] = {}
					end
					if mob_player_table['category'] and mob_player_table['category'][spell_type] then
						for spell,spell_table in pairs(mob_player_table['category'][spell_type]) do
							if not player_table[player][spell] then
								player_table[player][spell] = {}
							end
							for datum,value in pairs(spell_table) do 
								if not player_table[player][spell][datum] then
									player_table[player][spell][datum] = 0
								end
								player_table[player][spell][datum] = player_table[player][spell][datum] + value
							end
						end
					end
				end
			end
		end
	end
	
	return player_table
end

function get_player_stat_tally(stat,plyr,mob_filters)
	if type(stat)=='number' then stat=tostring(stat) end
	local tally = 0
	for mob,mob_table in pairs(database) do
		if check_filters('mob',mob) then
			for player,mob_player_table in pairs(mob_table) do
				if player==plyr then
					if mob_player_table[get_stat_type(stat)] and mob_player_table[get_stat_type(stat)][stat] then
						if get_stat_type(stat)=="category" then --handle ws/ja/spell tally								
							for spell,spell_table in pairs (mob_player_table[get_stat_type(stat)][stat]) do
								if spell_table.tally then
									tally = tally + spell_table.tally
								end
							end
						elseif mob_player_table[get_stat_type(stat)][stat].tally then
							tally = tally + mob_player_table[get_stat_type(stat)][stat].tally
						end
					end
				end
			end
		end
	end
	return tally
end

function get_player_stat_damage(stat,plyr,mob_filters)
	if type(stat)=='number' then stat=tostring(stat) end
	local damage = 0
	for mob,mob_table in pairs(database) do
		if check_filters('mob',mob) then
			for player,mob_player_table in pairs(mob_table) do
				if player==plyr then
					if mob_player_table[get_stat_type(stat)] and mob_player_table[get_stat_type(stat)][stat] then
						if mob_player_table[get_stat_type(stat)][stat].damage then
							damage = damage + mob_player_table[get_stat_type(stat)][stat].damage
						elseif get_stat_type(stat)=="category" then -- handle ws/ja/spell damage							
							for spell,spell_table in pairs (mob_player_table[get_stat_type(stat)][stat]) do
								if spell_table.damage then
									damage = damage + spell_table.damage
								end
							end
						end
					end
				end
			end
		end
	end
	return damage
end

function get_player_stat_avg(stat,plyr,mob_filters)
	if type(stat)=='number' then stat=tostring(stat) end
	local total,tally,result,digits = 0,0,0,0
	
	if stat=='multi' then
		digits = 2
		for i,__ in pairs(stat_types.multi) do
			total = total + (get_player_stat_tally(i,plyr,mob_filters) * tonumber(i))
			tally = tally + get_player_stat_tally(i,plyr,mob_filters)
		end
	else	
		digits = 0
		total = get_player_stat_damage(stat,plyr,mob_filters)
		tally = get_player_stat_tally(stat,plyr,mob_filters)		
	end

	if tally == 0 then return nil end

	local shift = 10 ^ digits
	result = math.floor( (total / tally)*shift + 0.5 ) / shift
	
	return result
end

function get_player_stat_percent(stat,plyr,mob_filters)
	if type(stat)=='number' then stat=tostring(stat) end
	if stat=="damage" then
		dividend = get_player_damage(plyr,mob_filters)
		divisor = get_player_damage(nil,mob_filters)
	else
		if not percent_table[stat] then
			return nil
		end
		dividend = get_player_stat_tally(stat,plyr,mob_filters)
		divisor = get_player_stat_tally(stat,plyr,mob_filters)
		
		if percent_table[stat] then
			for v,__ in pairs(percent_table[stat]) do
				-- if string begins with +
				if type(v)=='string' and v:startswith('+') then
					dividend = dividend + get_player_stat_tally(string.sub(v,2),plyr,mob_filters)
					divisor = divisor + get_player_stat_tally(string.sub(v,2),plyr,mob_filters)
				else
					divisor = divisor + get_player_stat_tally(v,plyr,mob_filters)
				end
			end
		end
	end
	
	if dividend==0 or divisor==0 then
		return nil
	end

	digits = 4

	shift = 10 ^ digits
	result = math.floor( (dividend / divisor) *shift + 0.5 ) / shift

	return result * 100
end

function get_player_damage(plyr,mob_filters)
	local damage = 0
	for __,player in pairs(get_players()) do		
		if not plyr or (plyr and player==plyr) then
			for stat_type,stats in pairs(stat_types) do
				if stat_type~='defense' then
					for stat,__ in pairs(stats) do
						damage = damage + get_player_stat_damage(stat,player)
					end
				end
			end
		end
	end
	return damage
end


--Copyright (c) 2013~2016, F.R
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of <addon name> nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
--DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.