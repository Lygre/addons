_addon.command = 'fol'
_addon.name = 'Follow'
_addon.version = '1.0.0'
_addon.author = 'Lygre'

require('lists')
require('tables')
require('strings')
texts = require('texts')
config = require('config')
require('luau')
packets = require('packets')
functions = require('functions')
res = require('resources')
chat = require('chat')

local player_array = L{}

windower.register_event('addon command', function(...)
	local commands = {...}
	-- check_player()
	-- if commands[1] then
	-- 	if player_array:contains(commands[1]:capitalize()) then
	-- 		local fol_target = strings.capitalize(commands[1])
	-- 		find_index(fol_target)

	-- 		windower.send_ipc_message('fol')
	-- 	end		
	-- end
		selffol = windower.ffxi.get_player()
		player = windower.ffxi.get_mob_by_name(selffol.name)
		follow_player = player.index
		windower.send_ipc_message('fol')
end)

windower.register_event('ipc message', function(msg)
	if msg == 'fol' then
		windower.ffxi.follow(follow_player)
		--follow(follow_player)
	end
end)
function self_follow()
	follow_player = windower.ffxi.get_player().index
	return follow_player
end

-----------------------
-- function follow()
-- 	windower.ffxi.follow(follow_player)
-- end
-- function check_player()
-- 	player_array = L{}
-- 	local mob_array = windower.ffxi.get_mob_array()
-- 	for i=1,#mob_array do
-- 		if not mob_array[i].is_npc then
-- 			list.append(player_array, mob_array[i].name)
-- 		end
-- 	end
-- end
function find_index(named)
	local fol_ind = table.find(player_array, named)
	local follow_player = windower.ffxi.get_mob_by_name(player_array[fol_ind]).index
	return follow_player
end

