_addon.name = 'RollBot'
_addon.author = 'Lygre'
_addon.commands = {'rollbot','rb','rbot'}
_addon.version = '0.0.1'
_addon.lastUpdate = '2016.09.27'

require('luau')
-- require('lor/lor_utils')
-- files = require('files')
-- _libs.lor.req('all')
-- _libs.lor.debug = false
packets = require('packets')

require('tables')
require('strings')
require('logger')
require('sets')
-- config = require('config')
chat = require('chat')
res = require('resources')

function string.join(jstr, ...)
	--Somewhat equivalent to Python's str.join(iterable)
	local tbl = {...}
	local building = ''
	local i = 1
	while i <= #tbl do
		local ele = tbl[i]
		if type(ele) == 'table' then
			ele = string.join(jstr, unpack(ele))
		end
		building = building..((i == 1) and '' or jstr)..tostring(ele)
		i = i + 1
	end
	return building
end


rollslist = S{
		"Corsair's Roll",
		"Ninja Roll",
		"Hunter's Roll",
		"Chaos Roll",
		"Magus's Roll",
		"Healer's Roll",
		"Puppet Roll",
		"Choral Roll",
		"Monk's Roll",
		"Beast Roll",
		"Samurai Roll",
		"Evoker's Roll",
		"Rogue's Roll",
		"Warlock's Roll",
		"Fighter's Roll",
		"Drachen Roll",
		"Gallant's Roll",
		"Wizard's Roll",
		"Dancer's Roll",
		"Scholar's Roll",
		"Bolter's Roll",
		"Caster's Roll",
		"Courser's Roll",
		"Blitzer's Roll",
		"Tactician's Roll",
		"Allies' Roll",
		"Miser's Roll",
		"Companion's Roll",
		"Avenger's Roll",
		"Runeist's Roll",
		"Naturalist's Roll",
	}

rollInfoTemp = {
		-- Okay, this goes 1-11 boost, Bust effect, Effect, Lucky, +1 Phantom Roll Effect, Bonus Equipment and Effect,
		['Chaos'] = {6,8,9,25,11,13,16,3,17,19,31,"-4", '% Attack!', 4, 3},
		['Fighter\'s'] = {2,2,3,4,12,5,6,7,1,9,18,'-4','% Double-Attack!', 5, 1},
		['Wizard\'s'] = {4,6,8,10,25,12,14,17,2,20,30, "-10", ' MAB', 5, 2},
		['Evoker\'s'] = {1,1,1,1,3,2,2,2,1,3,4,'-1', ' Refresh!',5, 1},
		['Rogue\'s'] = {2,2,3,4,12,5,6,6,1,8,14,'-6', '% Critical Hit Rate!', 5, 1},
		['Corsair\'s'] = {10, 11, 11, 12, 20, 13, 15, 16, 8, 17, 24, '-6', '% Experience Bonus',5, 2},
		['Hunter\'s'] = {10,13,15,40,18,20,25,5,27,30,50,'-?', ' Accuracy Bonus',4, 5},
		['Magus\'s'] = {5,20,6,8,9,3,10,13,14,15,25,'-8',' Magic Defense Bonus',2, 2},
		['Healer\'s'] = {3,4,12,5,6,7,1,8,9,10,16,'-4','% Cure Potency',3, 1},
		['Drachen'] = {10,13,15,40,18,20,25,5,28,30,50,'-8',' Pet: Accuracy Bonus',4, 5},
		['Choral'] = {8,42,11,15,19,4,23,27,31,35,50,'+25', '- Spell Interruption Rate',2, 0},
		['Monk\'s'] = {8,10,32,12,14,15,4,20,22,24,40,'-?', ' Subtle Blow', 3, 4},
		['Beast'] = {6,8,9,25,11,13,16,3,17,19,31,'-10', '% Pet: Attack Bonus',4, 3},
		['Samurai'] = {7,32,10,12,14,4,16,20,22,24,40,'-10',' Store TP Bonus',2, 4},
		['Warlock\'s'] = {2,3,4,12,5,6,7,1,8,9,15,'-5',' Magic Accuracy Bonus',4, 1},
		['Puppet'] = {5,8,35,11,14,18,2,22,26,30,40,'-8',' Pet: Magic Attack Bonus',3, 3},
		['Gallant\'s'] = {4,5,15,6,7,8,3,9,10,11,20,'-10','% Defense Bonus', 3, 2.4},
		['Dancer\'s'] = {3,4,12,5,6,7,1,8,9,10,16,'-4',' Regen',3, 2},
		['Bolter\'s'] = {0.3,0.3,0.8,0.4,0.4,0.5,0.5,0.6,0.2,0.7,1.0,'-8','% Movement Speed',3, 0.2},
		['Caster\'s'] = {6,15,7,8,9,10,5,11,12,13,20,'-10','% Fast Cast',2, 3,{7,11140,10}},
		['Tactician\'s'] = {10,10,10,10,30,10,10,0,20,20,40,'-10',' Regain',5, 2, {5, 11100, 10}},
		['Miser\'s'] = {30,50,70,90,200,110,20,130,150,170,250,'0',' Save TP',5, 15},
		['Ninja'] = {4,5,5,14,6,7,9,2,10,11,18,'-10',' Evasion Bonus',4, 2},
		['Scholar\'s'] = {'?','?','?','?','?','?','?','?','?','?','?','?',' Conserve MP',2, 0},
		['Allies\''] = {6,7,17,9,11,13,15,17,17,5,17,'?','% Skillchain Damage',3, 1,{6,11120, 5}},
		['Companion\'s'] = {{4,20},{20, 50},{6,20},{8, 20},{10,30},{12,30},{14,30},{16,40},{18, 40}, {3,10},{30, 70},'-?',' Pet: Regen/Regain',2, {1,5}},
		['Avenger\'s'] = {'?','?','?','?','?','?','?','?','?','?','?','?',' Counter Rate',4, 0},
		['Blitzer\'s'] = {2,3.4,4.5,11.3,5.3,6.4,7.2,8.3,1.5,10.2,12.1,'-?', '% Attack delay reduction',4, 1, {4,11080, 5}},
		['Courser\'s'] = {'?','?','?','?','?','?','?','?','?','?','?','?',' Snapshot',3, 0},
		['Runeist\'s'] = {'?','?','?','?','?','?','?','?','?','?','?','?',' Magic Evasion',4, 0},
		['Naturalist\'s'] = {'?','?','?','?','?','?','?','?','?','?','?','?',' Enhancing Magic Duration',3, 0}
	}
RollLuckyUnlucky = {
		['Chaos Roll'] = {4,8},
		['Fighter\'s Roll'] = {5,9},
		['Wizard\'s Roll'] = {5,9},
		['Evoker\'s Roll'] = {5,9},
		['Rogue\'s Roll'] = {5,9},
		['Corsair\'s Roll'] = {5,9},
		['Hunter\'s Roll'] = {4,8},
		['Magus\'s Roll'] = {2,6},
		['Healer\'s Roll'] = {3,7},
		['Drachen Roll'] = {4,8},
		['Choral Roll'] = {2,6},
		['Monk\'s Roll'] = {3,7},
		['Beast Roll'] = {4,8},
		['Samurai Roll'] = {2,6},
		['Warlock\'s Roll'] = {4,8},
		['Puppet Roll'] = {3,7},
		['Gallant\'s Roll'] = {3,7},
		['Dancer\'s Roll'] = {3,7},
		['Bolter\'s Roll'] = {3,9},
		['Caster\'s Roll'] = {2,7},
		['Tactician\'s Roll'] = {5,8},
		['Miser\'s Roll'] = {5,7},
		['Ninja Roll'] = {4,8},
		['Scholar\'s Roll'] = {2,6},
		['Allies\' Roll'] = {3,10},
		['Companion\'s Roll'] = {2,10},
		['Avenger\'s Roll'] = {4,8},
		['Blitzer\'s Roll'] = {4,9},
		['Courser\'s Roll'] = {3,9},
		['Runeist\'s Roll'] = {4,8},
		['Naturalist\'s Roll'] = {3,7},
}

windower.register_event('load', function()
	zone_enter_rb = os.clock()-25
	enabled = false
	rollcmd1 = ""
	rollcmd2 = ""
	rollnum1 = 0
	rollnum2 = 0
	currentRoll = ""
	boo = 0
	indoor_zones = S{0,26,53,223,224,225,226,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,252,256,257,280,284}
	crookedRoll = ""
	-- windower.ffxi.get_player

end)
windower.register_event('zone change', function(new_id, old_id)
	zone_enter_rb = os.clock()
	local zone_info = windower.ffxi.get_info()
	if zone_info ~= nil then
		if zone_info.zone == 131 then
			windower.send_command('lua unload RollBot')
		elseif zone_info.mog_house == true then
			enabled = false
		elseif indoor_zones:contains(zone_info.zone) then
			enabled = false
		end
	end
end)

--[[
Recreates rollInfoTemp into table rollInfo
]]--
rollInfo = {}
	for key, val in pairs(rollInfoTemp) do
		rollInfo[res.job_abilities:with('english', key .. ' Roll').id] = {key, unpack(val)}
	end

windower.register_event('addon command', function (command,...)
	command = command and command:lower() or 'help'
	local args = T{...}
	local arg_str = windower.convert_auto_trans(' ':join(args))
	
	if S{'reload','unload'}:contains(command) then
		windower.send_command('lua %s %s':format(command, _addon.name))
	elseif S{'on','enable'}:contains(command) then
		enabled = true
		windower.add_to_chat(204, 'RollBot On')
		roll()
	elseif S{'off','disable','stop'}:contains(command) then
		enabled = false
		windower.add_to_chat(204, 'Rollbot Off')
	elseif S{'rollset1'}:contains(command) then
		if args then
			rollcmd1 = arg_str
			windower.add_to_chat(204, 'Roll One: '..rollcmd1..'')
		else 
			windower.add_to_chat(204, 'No Roll specified')
		end
	elseif S{'rollset2'}:contains(command) then
		if args then
			rollcmd2 = arg_str
			windower.add_to_chat(204, 'Roll Two: '..rollcmd2..'')
		else 
			windower.add_to_chat(204, 'No Roll specified')
		end
	elseif S{'crooked'}:contains(command) then
		if args then
			crookedRoll = arg_str
			windower.add_to_chat(204, 'Crooked Roll: '..crookedRoll..'')
		end
	-- elseif S{'enable','on','start'}:contains(command) then
	--  enabled = true
	--  print_status()
	-- elseif command == 'autora' then
	--  local cmd = args[2] and args[2]:lower() or (useAutoRA and 'off' or 'on')
	--  if S{'on'}:contains(cmd) then
	--      useAutoRA = true
	--      atc('AutoWS will now resume auto ranged attacks after WSing')
	else
		windower.add_to_chat(204, 'Unknown command')
	end
end)

fps = 1

windower.register_event('prerender', function(spell)
	if fps < 30 then
		fps = fps +1
	else
		fps = 1
	end
	
	
	
	
	if fps == 1 then
		roll()
	end
end)

function roll()
	-- if not check_rolls() then
		if enabled then
			if (rollcmd1 ~= "") and (rollcmd2 ~= "") then
				if check_timer('Phantom Roll') then
					---This chunk needs fixing ----------TO DOOO!!!!!
					if not buffactive(rollcmd1) then
						currentRoll = rollcmd1
					elseif not buffactive(rollcmd2) then
						currentRoll = rollcmd2
					end
					if check_timer('Crooked Cards') and (not buffactive('Crooked Cards')) and (crookedRoll ~= "") then
						if (crookedRoll == currentRoll) then
							windower.send_command('input /ja "Crooked Cards" <me>;wait 1;input /ja "'..currentRoll..'" <me>')
						end
					elseif not buffactive(rollcmd1) or (not buffactive(rollcmd2)) then
						windower.send_command('input /ja "'..currentRoll..'" <me>')
					end
				elseif check_timer('Double-Up') and buffactive("Double-Up Chance") then
					if rollnum ~= RollLuckyUnlucky[currentRoll][1] and rollnum < 11 then
						if rollnum + 1 == RollLuckyUnlucky[currentRoll][1] then
							if get_recast('Snake Eye') < get_recast('Phantom Roll') then
								if check_timer('Snake Eye') and not buffactive('Snake Eye') then
									windower.send_command('input /ja "Snake Eye" <me>;wait 1;input /ja "Double-Up" <me>')
								end
							else 
								windower.send_command('input /ja "Double-Up" <me>')
							end
							-- if get_recast('Snake Eye') < get_recast('Phantom Roll') and (get_recast('Phantom Roll') - get_recast('Snake Eye')) > 2 then
							-- end
						elseif rollnum == RollLuckyUnlucky[currentRoll][2] then
							if check_timer('Snake Eye') and not buffactive('Snake Eye') then
								windower.send_command('input /ja "Snake Eye" <me>;wait 1;input /ja "Double-Up" <me>')
							end 
						elseif rollnum == 10 then
							if check_timer('Snake Eye') and not buffactive('Snake Eye') then
								windower.send_command('input /ja "Snake Eye" <me>;wait 1;input /ja "Double-Up" <me>')
							end
						elseif rollnum < 6 and rollnum ~= RollLuckyUnlucky[currentRoll][1] then
							windower.send_command('input /ja "Double-Up" <me>')
						end
					end
				end
			end
		end
	-- end
end
--[[
	Returns true if both assigned rolls are active with no double-up chance, false if a roll is missing
]]--
function check_rolls()
	if buffactive(rollcmd1) and buffactive(rollcmd2) then
		-- if not buffactive("Double-Up Chance") then
			return true 
		-- end
	end
	return false 
end

--[[
	Returns recast for specified ability in seconds
]]--
function get_recast(abil)
	local allRecasts = windower.ffxi.get_ability_recasts()
	local player = windower.ffxi.get_player()
	if (player == nil) then return false end
	if (player ~= nil) and (abil ~= nil) then
		for k,_ in pairs(allRecasts) do
			local JA = res.ability_recasts[k].en
			if JA:lower() == abil:lower() then
				return allRecasts[k]
			end
		end
	end
end

-- windower.register_event('lose buff', function()

-- end)
--[[
	Returns true if ability recast is ready, false otherwise
]]--
function check_timer(abil)
	local player = windower.ffxi.get_player()
	local allRecasts = windower.ffxi.get_ability_recasts()
	local availAbils = S(windower.ffxi.get_abilities().job_abilities)
	if (player == nil) then return false end
	if (player ~= nil) and (abil ~= nil) then
		for k,_ in pairs(allRecasts) do
			local JA = res.ability_recasts[k].en
			-- print(k,allRecasts[k])
			if JA:lower() == abil:lower() then
				local rc = allRecasts[k]
				return rc == 0
			end
		end
	end
	return false 
end


--[[
	Returns true if one of the given buffs are currently active.
--]]
function buffactive(...)
	local args = S{...}:map(string.lower)
	local player = windower.ffxi.get_player()
	if (player ~= nil) and (player.buffs ~= nil) then
		for _,bid in pairs(player.buffs) do
			local buff = res.buffs[bid]
			if args:contains(buff.en:lower()) then
				return true
			end
		end
	end
	return false
end

windower.register_event('action', function(act)
	if act.category == 6 and table.containskey(rollInfo, act.param) then
		--This is used later to allow/disallow busting
		--If you are not the rollActor you will not be disallowed to bust.
		rollActor = act.actor_id
		local rollID = act.param
		local rollNum = act.targets[1].actions[1].param
		boo = res.job_abilities[rollID].en
		--rollInfo[rollID][1]
		windower.add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..boo..' ] *-*-*-*-*-*-*-*-*')
		if rollcmd1 == boo then
			rollnum = rollNum
			windower.add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..rollcmd1..' = '..rollnum..' ] *-*-*-*-*-*-*-*-*')
		elseif rollcmd2 == boo then
			rollnum = rollNum
			windower.add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..rollcmd2..' = '..rollnum..' ] *-*-*-*-*-*-*-*-*')
		end
	end
end)



