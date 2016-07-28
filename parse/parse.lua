_addon.version = '1.32'
_addon.name = 'Parse'
_addon.author = 'F'
_addon.commands = {'parse','p'}

require 'tables'
require 'sets'
require 'strings'
require 'actions'
config = require('config')
texts = require('texts')
res = require 'resources'

messageColor = 213

default_settings = {}
default_settings.update_interval = 3
default_settings.autoexport_interval = 500
default_settings.debug = false
default_settings.index_shield = false
default_settings.index_reprisal = true
default_settings.index_palisade = true
default_settings.index_battuta = true
default_settings.record = {
		["me"] = true,
		["party"] = true,
		["trust"] = true,
		["alliance"] = true,
		["pet"] = true,
		["fellow"] = true
	}
default_settings.label = {
		["player"] = {red=100,green=200,blue=200},
		["stat"] = {red=225,green=150,blue=0},
	}
default_settings.display = {}
default_settings.display.melee = {
		["visible"] = true,
		["type"] = "offense",
		["pos"] = {x=570,y=50},
		["order"] = L{"damage","melee","ws"},
		["max"] = 6,
		["data_types"] = {
			["damage"] = S{'total','total-percent'},
			["melee"] = S{'percent'},
			["miss"] = S{'tally'},
			["crit"] = S{'percent'},
			["ws"] = S{'avg'},
			["ja"] = S{'avg'},
			["multi"] = S{'avg'}
		},
		["bg"] = {visible=true,alpha=50,red=0,green=0,blue=0},
		["text"] = {size=10,font="consolas",alpha=255,red=255,green=255,blue=255,stroke={width=1,alpha=200,red=0,green=0,blue=0}},
		["padding"] = 4,
		["flags"] = {draggable=true,right=false,bottom=false,bold=true}
	}
default_settings.display.defense = {
		["visible"] = false,
		["type"] = "defense",
		["pos"] = {x=150,y=440},
		["order"] = L{"block","hit","parry",},
		["max"] = 2,
		["data_types"] = {
			["block"] = S{'avg','percent'},
			["evade"] = S{'percent'},
			["hit"] = S{'avg'},
			["parry"] = S{'percent'},
			["absorb"] = S{'percent'},
			["intimidate"] = S{'percent'},
		},
		["bg"] = {visible=true,alpha=50,red=0,green=0,blue=0},
		["text"] = {size=10,font="consolas",alpha=255,red=255,green=255,blue=255,stroke={width=1,alpha=200,red=0,green=0,blue=0}},
		["padding"] = 4,
		["flags"] = {draggable=true,right=false,bottom=false,bold=true}
	}
default_settings.display.ranged = {
		["visible"] = false,
		["type"] = "offense",
		["pos"] = {x=570,y=200},
		["order"] = L{"damage","ranged","ws"},
		["max"] = 6,
		["data_types"] = {
			["damage"] = S{'total','total-percent'},
			["ranged"] = S{'percent'},
			["r_crit"] = S{'percent'},
			["ws"] = S{'avg'},
		},
		["bg"] = {visible=true,alpha=50,red=0,green=0,blue=0},
		["text"] = {size=10,font="consolas",alpha=255,red=255,green=255,blue=255,stroke={width=1,alpha=200,red=0,green=0,blue=0}},
		["padding"] = 4,
		["flags"] = {draggable=true,right=false,bottom=false,bold=true}
	}
default_settings.display.magic = {
		["visible"] = false,
		["type"] = "offense",
		["pos"] = {x=570,y=50},		
		["order"] = L{"damage","spell"},
		["max"] = 6,
		["data_types"] = {
			["damage"] = S{'total','total-percent'},
			["spell"] = S{'avg'},
		},
		["bg"] = {visible=true,alpha=50,red=0,green=0,blue=0},
		["text"] = {size=10,font="consolas",alpha=255,red=255,green=255,blue=255,stroke={width=1,alpha=200,red=0,green=0,blue=0}},
		["padding"] = 4,
		["flags"] = {draggable=true,right=false,bottom=false,bold=true}
	}
	
settings = config.load(default_settings)
config.save(settings)

update_tracker,update_interval = 0,settings.update_interval
autoexport = nil
autoexport_tracker,autoexport_interval = 0,settings.autoexport_interval
pause = false
buffs = {["Palisade"] = false, ["Reprisal"] = false, ["Battuta"] = false}

database = {}
filters = {
		['mob'] = S{},
		['player'] = S{}
	}
renames = {}
text_box = {}

stat_types = {}
stat_types.defense = S{"hit","block","evade","parry","intimidate","absorb","shadow","anticipate","nonparry","nonblock"}
stat_types.melee = S{"melee","miss","crit"}
stat_types.ranged = S{"ranged","r_miss","r_crit"}
stat_types.category = S{"ws","ja","spell","ws_miss","ja_miss"}
stat_types.other = S{"spike","sc","add"}
stat_types.multi = S{'1','2','3','4','5','6','7','8'}

damage_types = S{"melee","crit","ranged","r_crit","ws","ja","spell","spike","sc","add"}

require 'utility'
require 'retrieval'
require 'display'
require 'action_parse'
require 'report'
require 'file_handle'

ActionPacket.open_listener(parse_action_packet)
init_boxes()

windower.register_event('addon command', function(...)
    local args = {...}
    if args[1] == 'report' then
		report_data(args[2],args[3],args[4])
	elseif (args[1] == 'filter' or args[1] == 'f') and args[2] then
		edit_filters(args[2],args[3],args[4])
		update_texts()
	elseif (args[1] == 'list' or args[1] == 'l') then
		print_list(args[2])
	elseif (args[1] == 'show' or args[1] == 's' or args[1] == 'display' or args[1] == 'd') then
		toggle_box(args[2])
		update_texts()
	elseif args[1] == 'reset' then
		reset_parse()
		update_texts()
	elseif args[1] == 'pause' or args[1] == 'p' then
		if pause then pause=false else pause=true end
		update_texts()
	elseif args[1] == 'rename' and args[2] and args[3] then
		if args[3]:gsub('[%w_]','')=="" then
			renames[args[2]:gsub("^%l", string.upper)] = args[3]
			message('Data for player/mob '..args[2]:gsub("^%l", string.upper)..' will now be indexed as '..args[3])	
			return
		end
		message('Invalid character found. You may only use alphanumeric characters or underscores.')
	elseif args[1] == 'interval' then
		if type(tonumber(args[2]))=='number' then update_tracker,update_interval = 0, tonumber(args[2]) end
		message('Your current update interval is every '..update_interval..' actions.')
	-- elseif args[1] == 'save' then
		-- save_parse(args[2])
	elseif args[1] == 'export' then
		export_parse(args[2])
	elseif args[1] == 'autoexport' then
		if (autoexport and not args[2]) or args[2] == 'off' then
			autoexport = nil message('Autoexport turned off.')
		else
			autoexport = args[2] or 'autoexport'
			message('Autoexport now on. Saving under file name "'..autoexport..'" every '..autoexport_interval..' recorded actions.')
		end
	elseif args[1] == 'import' and args[2] then
		import_parse(args[2])
		update_texts()
	elseif args[1] == 'help' then
		message('report [stat] [chatmode] : Reports stat to designated chatmode. Defaults to damage.')
		message('filter/f [add/+ | remove/- | clear/reset] [string] : Adds/removes/clears mob filter.')
		message('show/s [melee/ranged/magic/defense] : Shows/hides display box. "melee" is the default.')
		message('pause/p : Pauses/unpauses parse. When paused, data is not recorded.')
		message('reset :  Resets parse.')
		message('interval [number] :  Defines how many actions it takes before displays are updated.')
		message('rename [player name] [new name] : Renames a player or monster for NEW incoming data.')
		-- message('save [file name] : Saves parse to tab-delimited txt file. Filters are applied and data is collapsed.')
		message('import/export [file name] : Imports/exports an XML file to/from database. Filters are applied permanently.')
		message('autoexport [file name] : Automatically exports an XML file every '..autoexport_interval..' recorded actions.')
		message('list/l [mobs/players] : Lists the mobs and players currently in the database. "mobs" is the default.')
	else
		message('That command was not found. Use //parse help for a list of commands.')
	end
end )

windower.register_event('gain buff', function(id)
	if id==403 then -- Reprisal
		buffs["Reprisal"] = true
	elseif id==478 then -- Palisade
		buffs["Palisade"] = true
	elseif id==570 then -- Battuta
		buffs["Battuta"] = true
	end
end )

windower.register_event('lose buff', function(id)
	if id==403 then -- Reprisal
		buffs["Reprisal"] = false
	elseif id==478 then -- Palisade
		buffs["Palisade"] = false
	elseif id==570 then -- Battuta
		buffs["Battuta"] = false
	end
end )

function get_stat_type(stat)
	for stat_type,stats in pairs(stat_types) do
		if stats:contains(stat) then
			return stat_type
		end
	end
	return nil
end

function reset_parse()
	database = {}
end

function toggle_box(box_name)
	if not box_name then
		box_name = 'melee'
	end
	if text_box[box_name] then
		if settings.display[box_name].visible then
			text_box[box_name]:hide()
			settings.display[box_name].visible = false
		else
			text_box[box_name]:show()
			settings.display[box_name].visible = true
		end
	else
		message('That display was not found. Display names are: melee, defense, ranged, magic.')
	end
end

function edit_filters(filter_action,str,filter_type)
	if not filter_type or not filters[filter_type] then
		filter_type = 'mob'
	end
	
	if filter_action=='add' or filter_action=="+" then
		if not str then message("Please provide string to add to filters.") return end
		filters[filter_type]:add(str)
		message('"'..str..'" has been added to '..filter_type..' filters.')
	elseif filter_action=='remove' or filter_action=="-" then
		if not str then message("Please provide string to remove from filters.") return end
		filters[filter_type]:remove(str)
		message('"'..str..'" has been removed from '..filter_type..' filters.')
	elseif filter_action=='clear' or filter_action=="reset" then
		filters[filter_type] = S{}
		message(filter_type..' filters have been cleared.')
	end	
end

function get_filters()
	local text = ""
	if filters['mob'] and filters['mob']:tostring()~="{}" then
		text = text .. ('Monsters: ' .. filters['mob']:tostring())
	end
	if filters['player'] and filters['player']:tostring()~="{}" then
		text = text .. ('\nPlayers: ' .. filters['player']:tostring())
	end
	return text
end

function print_list(list_type) 
	if not list_type or list_type=="monsters" or list_type=="m" then 
		list_type="mobs" 
	elseif list_type=="p" then
		list_type="players"
	end
	
	local lst = S{}
	if list_type=='mobs' then
		lst = get_mobs()
	elseif list_type=='players' then
		lst = get_players()
	else
		message('List type not found. Valid list types: mobs, players')
		return
	end
	
	if lst:length()==0 then message('No data found. Nothing to list!') return end
	
	lst['n'] = nil
	local msg = ""
	for __,i in pairs(lst) do
		msg = msg .. i .. ', '
	end
	
	msg = msg:slice(1,#msg-2)
	
	msg = prepare_string(msg,100)
	msg['n'] = nil
	
	for i,line in pairs(msg) do
		message(line)
	end
end

-- Returns true if no filters, or if monster, or part of monster name, is found in filter list
function check_filters(filter_type,mob_name)
	if not filters[filter_type] or filters[filter_type]:tostring()=="{}" then
		return true
	end
	
	local response = false
	local only_excludes = true
	for v,__ in pairs(filters[filter_type]) do
		if v:lower():startswith('!') then --exclusion filter
			if string.find(mob_name:lower(),v:lower():gsub('%!','')) or v:lower():gsub('%!',''):gsub('%^','')==mob_name:lower() then --immediately return false
				return false
			end
		elseif v:lower():startswith('^') then --exact match filter
			if v:lower():gsub('%^','')==mob_name:lower() then
				response = true				
			end
			only_excludes = false
		elseif string.find(mob_name:lower(),v:lower()) then --wildcard filter (default behavior)
			response = true
			only_excludes = false
		else
			only_excludes = false
		end
	end
	if not response and only_excludes then
		response = true
	end
	return response
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