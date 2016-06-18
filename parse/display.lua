--[[ TO DO

	-- Update filter header directly

]]

function init_boxes()
	for box,__ in pairs(settings.display) do
		create_text(box)
	end
end

function create_text(stat_type)
	local t_settings = settings.display[stat_type]

    text_box[stat_type] = texts.new(t_settings)
	text_box[stat_type]:hide()
	update_text(text_box[stat_type])
end

function update_text(stat_type)
	-- Don't update if box wasn't properly added, there are no settings, or it is not set to visible
	if not text_box[stat_type] or not settings.display[stat_type] or not settings.display[stat_type].visible then
		return
	end
	
	local info = {}
	local head = L{}
	local to_be_sorted = {}
	local sorted_players = L{}
	local all_damage = 0
	
	if settings.display[stat_type]["type"] == "offense" then 
		sort_type = "damage" 
	else 
		sort_type = "defense" 
	end

	-- add data to info table
	for __,player_name in pairs(get_players()) do		

		if (settings.display and settings.display[stat_type]) then
			to_be_sorted[player_name] = get_player_stat_tally('parry',player_name) + get_player_stat_tally('hit',player_name) + get_player_stat_tally('evade',player_name)
			info[player_name] = '\\cs('..label_colors('player')..')'..string.format('%-13s',player_name..' ')..'\\cr' 
			for stat in settings.display[stat_type].order:it() do 
				if settings.display[stat_type].data_types[stat] then					
					local d = {}					
					for report_type,__ in pairs(settings.display[stat_type].data_types[stat]) do
						if report_type=="total" then
							local total = get_player_damage(player_name) -- getting player's damage
							d[report_type] = total or "--"
							all_damage = all_damage + total
							if sort_type=='damage' then to_be_sorted[player_name] = total end
						elseif report_type=="total-percent" then
							d[report_type] = get_player_stat_percent(stat,player_name) or "--"
							--d[report_type] = (total or get_player_damage(player_name)) / get_player_damage() or "--"
						elseif report_type=="avg" then
							d[report_type] = get_player_stat_avg(stat,player_name) or "--" 
						elseif report_type=="percent" then
							d[report_type] = get_player_stat_percent(stat,player_name) or "--"
						elseif report_type=="tally" then
							d[report_type] = get_player_stat_tally(stat,player_name) or "--"
						elseif report_type=="damage" then
							d[report_type] = get_player_stat_damage(player_name) or "--"
						else
							d[report_type] = "--"
						end											
					end
					info[player_name] = info[player_name] .. (format_display_data(d))	
				end
			end
		end
	end
	
	-- sort players
	for i=1,settings.display[stat_type].max,+1 do
		p_name = nil
		top_result = 0
		for player_name,sort_num in pairs(to_be_sorted) do
			if sort_num > top_result and not sorted_players:contains('${'..player_name..'}') then
				top_result = sort_num
				p_name = player_name					
			end						
		end	
		if p_name then sorted_players:append('${'..p_name..'}') end		
	end

	head:append('[ ${title} ] ${filters} ${pause}')
	info['title'] = stat_type

	info['filters'] = update_filters()
	
	if pause then
		info['pause'] = "- PARSE PAUSED -"
	end

	head:append('${header}')
	info['header'] = format_display_head(stat_type)

	if sorted_players:length() == 0 then
		head:append('No data found')
	end
	
	if text_box[stat_type] then
		text_box[stat_type]:clear()
		text_box[stat_type]:append(head:concat('\n'))
		text_box[stat_type]:append('\n')
		text_box[stat_type]:append(sorted_players:concat('\n'))	
		text_box[stat_type]:update(info)
		
		if settings.display[stat_type].visible then
			text_box[stat_type]:show()
		end
	end

end

function format_display_head(box_name)
	local text = string.format('%-13s',' ')
	for stat in settings.display[box_name].order:it() do
		if settings.display[box_name].data_types[stat] then
			characters = 0
			for i,v in pairs(settings.display[box_name].data_types[stat]) do
				characters = characters + 7
				if i=='total' then characters = characters +1 end
			end
			text = text .. '\\cs('..label_colors('stat')..')' .. string.format('%-'..characters..'s',stat) .. '\\cr'
		end
	end
	return text
end

function label_colors(label)
	local r, b, g = 255, 255, 255
	
	if settings.label[label] then
		r = settings.label[label].red or 255
		b = settings.label[label].blue or 255
		g = settings.label[label].green or 255
	end
	
	return tostring(r)..','..tostring(g)..','..tostring(b)
end

function format_display_data(data)
	line = ""
	
	if data["total-percent"] then
		line = line .. string.format('%-7s',data["total-percent"] .. '% ')
	end
	
	if data["percent"] then
		line = line .. string.format('%-7s',data["percent"] .. '% ')
	end
	
	if data["total"] then
		line = line .. string.format('%-8s',data["total"] .. ' ')
	end

	if data["avg"] then
		line = line .. string.format('%-7s','~' .. data["avg"] .. ' ')
	end

	if data["tally"] then
		if data["damage"] then
			line = line .. string.format('%-7s',data["damage"] ..' ')
		end
		line = line .. string.format('%-7s','#' .. data["tally"])
	elseif data["damage"] then
		line = line .. string.format('%-7s',data["damage"])
	end
	
	return line
end

function update_texts()
	for v,__ in pairs(text_box) do
		update_text(v)
	end
end

-- I want this to edit the text boxes directly
function update_filters()
	local text = ""
	if filters['mob'] and filters['mob']:tostring()~="{}" then
		text = text .. ('Monsters: ' .. filters['mob']:tostring())
	end
	if filters['player'] and filters['player']:tostring()~="{}" then
		text = text .. ('\nPlayers: ' .. filters['player']:tostring())
	end
	return text
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