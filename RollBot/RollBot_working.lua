_addon.name = 'RollBot'
_addon.author = 'Lygre'
_addon.commands = {'rollbot','rb','rbot'}
_addon.version = '1.0.1'
_addon.lastUpdate = '2016.12.03'

require('luau')
packets = require('packets')
require('tables')
require('strings')
require('logger')
require('sets')
chat = require('chat')
res = require('resources')
require('maths')
require('rollinfo')
config = require('config')

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

local profile = {}
local profiles = {}
-- local focusMembers = {}

function math.round(num, prec)
    local mult = 10^(prec or 0)
    return (math.floor(num * mult + 0.5) / mult)
end

profiles = {
	['standard_melee'] = {
		rolls = {
			[1] = "Samurai Roll",
			[2] = "Chaos Roll"},
		crooked = {[1]="Samurai Roll"}
	}
}
windower.register_event('load', function()
	zone_enter_rb = os.clock()-25
	enabled = false
	set_rolls = {}
	my_rolls = {}
	active_rolls = {}
	currentRoll = ""
	boo = 0
	indoor_zones = S{0,26,53,223,224,225,226,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,252,256,257,280,284}
	crookedRoll = 0
	get_active_rolls()
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

function loadProfile(pname)
	profile.rolls = {}
	profile.crooked = {}
	for action,index in pairs(profiles[pname]) do
		for i,v in pairs(profiles[pname][action]) do
			table.append(profile[action],profiles[pname][action][i])
		end
	end
	set_rolls[1] = profile.rolls[1]
	set_rolls[2] = profile.rolls[2]
	crookedRoll = profile.crooked[1]
	print(set_rolls[1],set_rolls[2],crookedRoll)
end
-- windower.register_event('lose buff',)
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
	elseif S{'settings','info'}:contains(command) then
		update()
		windower.add_to_chat(204, 'Rollbot - Set Rolls:')
		for i,v in ipairs(set_rolls) do
			windower.add_to_chat(204, 'Set Roll '..i..': '..set_rolls[i])
		end
		windower.add_to_chat(204, 'Crooked Roll: '..crookedRoll)
		windower.add_to_chat(204, 'Active Rolls:')
		for k,v in pairs(active_rolls) do
			windower.add_to_chat(204, active_rolls[k].name .. ' - #'..active_rolls[k].value)
		end
		if focusMembers then
			windower.add_to_chat(204, 'Focus targets: ')
			for i,v in ipairs(focusMembers) do
				windower.add_to_chat(204, focusMembers[i].name..': '..focusMembers[i].distance..' yalms')
				-- check_focus_distance()
			end
		end
	elseif S{'rollset'}:contains(command) then
		if args then
			local arg_str2 = ...:lower() 
			for i,v in pairs(rollslist) do
				local capture = string.match(rollslist[i], '(.+\'?s?) Roll') or ''
				if string.lower(capture):contains(arg_str2) then
					if #set_rolls < 2 then
						set_rolls[#set_rolls + 1] = rollslist[i]
						windower.add_to_chat(204, 'Roll '..#set_rolls..': '..rollslist[i]..'')
					else 
						set_rolls = {}
						set_rolls[#set_rolls + 1] = rollslist[i]
						windower.add_to_chat(204, 'Roll '..#set_rolls..': '..rollslist[i]..'')
					end
				end
			end
		else 
			windower.add_to_chat(204, 'No Roll specified')
		end
	elseif S{'setlist'}:contains(command) then
		if args then
			loadProfile(args[1])
			-- enabled = true
		end
	elseif S{'crooked'}:contains(command) then
		if args then
			local arg_str2 = ...:lower() 
			for i,v in ipairs(set_rolls) do
				local capture = string.match(set_rolls[i], '(.+\'?s?) Roll') or ''
				if string.lower(capture):contains(arg_str2) then
					crookedRoll = set_rolls[i]
					windower.add_to_chat(204, 'Crooked Roll: '..crookedRoll..'')
				end
			end
		else 
			windower.add_to_chat(204, 'No Roll specified for Crooked Cards')
		end
	elseif S{'focus'}:contains(command) then
		if args then
			local arg_str2 = ...:lower() 
			local index = get_focus_info(arg_str2)
			local focusname = windower.ffxi.get_mob_by_index(index).name

			if not focusMembers then focusMembers = {} end

			-- for i,v in pairs(focusMembers) do
				if not table.contains(focusMembers, focusname) then 
					table.append(focusMembers,{name=focusname,distance=0}) 
				end
			-- end
			windower.add_to_chat(204, focusMembers[#focusMembers].name .. ' added to Focus list.')
		end
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
	if enabled then
		if set_rolls then
			if check_timer('Phantom Roll') then
				for i,v in ipairs(set_rolls) do
					if not buffactive(set_rolls[i]) then
						if check_timer('Crooked Cards') and (not buffactive('Crooked Cards')) and crookedRoll and (crookedRoll == set_rolls[i]) then
							windower.send_command('input /ja "Crooked Cards" <me>;wait 1;input /ja "'..set_rolls[i]..'" <me>')
							currentRoll = set_rolls[i]
							-- my_rolls[#my_rolls+1] = {name = currentRoll, }
							break
						else
							windower.send_command('input /ja "'..set_rolls[i]..'" <me>')
							currentRoll = set_rolls[i]							
							break
						end
					end
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
--[[
	Returns given party member's name's index
]]
function get_focus_info(name)
	local array = windower.ffxi.get_mob_array()
	for id,_ in pairs(array) do
		if array[id].name:lower() == name:lower() then
			return array[id].index
		end
	end
end

-- function get_party_info()
function get_active_rolls()
	local player = windower.ffxi.get_player()
	if (player ~= nil) and (player.buffs ~= nil) then
		for _,bid in pairs(player.buffs) do
			local buff = res.buffs[bid].en
			if buff:contains('Roll') then
				active_rolls[buff] = {name=buff,value=0}
			end
		end
	end
end

function update()
	get_active_rolls()
	local oldState = enabled
	local bool,fname,fdist = check_focus_distance()
	if focusMembers then
		for i,v in ipairs(focusMembers) do
			focusMembers[i] = {name=fname,distance=fdist}
			print(focusMembers[i].name,focusMembers[i].distance)
		end
	end
	if oldState then
		if bool then
			enabled = true
			windower.add_to_chat(204, 'All focus targets in range, starting/resuming rolls')
		else
			enabled = false
			windower.add_to_chat(204, 'Not all focus targets in range of rolls. Pausing until closer')
		end
	else
		if bool then
			windower.add_to_chat(204, 'All focus targets in range')
		else
			windower.add_to_chat(204, 'Not all focus targets in range of rolls.')
		end
	end
	return enabled
end

function check_focus_distance()
	if focusMembers then
		for i,v in ipairs(focusMembers) do
			local distance = windower.ffxi.get_mob_by_name(focusMembers[i].name).distance
			distance = math.round(math.sqrt(distance),2)
			if distance > 14.9 then
				-- print(distance)
				return false, focusMembers[i].name, distance
			else 
				-- print(distance)
				return true, focusMembers[i].name, distance
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

---Need to add recognition of rolls from others being applied to us, and a function to remove said rolls from active_rolls table when they wear
windower.register_event('action', function(act)
	if act.category == 6 and table.containskey(rollInfo, act.param) then
		rollActor = act.actor_id
		local rollID = act.param
		local rollNum = act.targets[1].actions[1].param
		boo = res.job_abilities[rollID].en
		rollnum = rollNum
		if rollActor == windower.ffxi.get_player().id then
			windower.add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..boo..' ] *-*-*-*-*-*-*-*-*')
			for i,v in pairs(set_rolls) do
				if set_rolls[i] == boo then
					if table.length(my_rolls) < 3 then
						table.append(my_rolls,{name = boo, value = rollNum})
						active_rolls[boo] = {name = boo, value = rollNum}
						-- print(my_rolls[boo].name,my_rolls[boo].value)
						windower.add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..set_rolls[i]..' = '..rollNum..' ] *-*-*-*-*-*-*-*-*')
					end
				end
			end
		else
			local party = windower.ffxi.get_party()
			for i=0,5,1 do
				if party['p'..i].mob.id == rollActor then
					-- print('no wai')
					active_rolls[boo] = {name=boo, value = rollNum}
					break 
				end
			end  
		end
	end
end)



