--[[ TO DO:

	-- Clean construct_database of extraneous details
	
]]

files = require('files')
xml = require('xml')

function import_parse(file_name)   
	local path = '/data/export/'..file_name
	
	import = files.new(path..'.xml', true)
	parsed, err = xml.read(import)
	
	if not parsed then
		message(err or 'XML error: Unknown error.')
		return
	end
	
	imported_database = construct_database(parsed)	
	merge_tables(database,imported_database)
	
	-- Add nonblocks in for old version
	for mob,players in pairs(database) do
		for player,player_table in pairs(players) do
			if player_table['defense'] and player_table['defense']['block'] and not player_table['defense']['nonblock'] then
				player_table['defense']['nonblock'] = player_table['defense']['hit']
			end
		end
	end
	
	-- Add total_damage in for old version
	for mob,players in pairs(database) do
		for player,player_table in pairs(players) do
			if not player_table.total_damage then
				player_table.total_damage = find_total_damage(player,mob)
			end
		end
	end

	message('Parse ['..file_name..'] was imported to database!')
end

function export_parse(file_name)   	
    if not windower.dir_exists(windower.addon_path..'data') then
        windower.create_dir(windower.addon_path..'data')
    end
	if not windower.dir_exists(windower.addon_path..'data/export') then
        windower.create_dir(windower.addon_path..'data/export')
    end
	
	local path = windower.addon_path..'data/export/'
	if file_name then
		path = path..file_name
	else
		path = path..os.date(' %H %M %S%p  %y-%d-%m')
	end
	
	if windower.file_exists(path..'.xml') then
		path = path..'_'..os.clock()
	end
	
	local f = io.open(path..'.xml','w+')
	f:write('<database>\n')

	--filter mobs
	for mob,data in pairs(database) do		
		if check_filters('mob',mob) then
			f:write('    <'..mob..'>\n')
			f:write(to_xml(data,'        '))
			f:write('    </'..mob..'>\n')
		end		
	end
	
	f:write('</database>')
	f:close()
	
	message('Database was exported to '..path..'.xml!')
	if get_filters()~="" then
		message('Note that the database was filtered by [ '..get_filters()..' ]')
	end
end

function to_xml(t,indent_string)
	local indent = indent_string or '    '
	local xml_string = ""
	for key,value in pairs(t) do
		key = tostring(key)
		xml_string = xml_string .. indent .. '<'..key:gsub(" ","_")..'>'		
		if type(value)=='number' then
			xml_string = xml_string .. value
			xml_string = xml_string .. '</'..key:gsub(" ","_")..'>\n'
		elseif type(value)=='table' then
			xml_string = xml_string .. '\n' .. to_xml(value,indent..'    ')
			xml_string = xml_string .. indent .. '</'..key:gsub(" ","_")..'>\n'
		end
		
	end
	
	return xml_string
end

---------------------------------------------------------
-- Function credit to the Windower Luacore config library
---------------------------------------------------------
function construct_database(node, settings, key, meta)
    settings = settings or T{}
    key = key or 'settings'
    meta = meta

    local t = T{}
    if node.type ~= 'tag' then
        return t
    end

    if not node.children:all(function(n)
        return n.type == 'tag' or n.type == 'comment'
    end) and not (#node.children == 1 and node.children[1].type == 'text') then
        error('Malformatted settings file.')
        return t
    end

    -- TODO: Type checking necessary? merge should take care of that.
    if #node.children == 1 and node.children[1].type == 'text' then
        local val = node.children[1].value
        if node.children[1].cdata then
            --meta.cdata:add(key)
            return val
        end

        if val:lower() == 'false' then
            return false
        elseif val:lower() == 'true' then
            return true
        end

        local num = tonumber(val)
        if num ~= nil then
            return num
        end

        return val
    end

    for child in node.children:it() do
        if child.type == 'comment' then
            meta.comments[key] = child.value:trim()
        elseif child.type == 'tag' then
            key = child.name
            local childdict
            if table.containskey(settings, key) then
                childdict = table.copy(settings)
            else
                childdict = settings
            end
            t[child.name] = construct_database(child, childdict, key, meta)
        end
    end

    return t
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