--[[
skilluptracker v1.03

Copyright (c) 2014, Mujihina
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of skilluptracker nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Mujihina BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]


_addon.name    = 'skilluptracker'
_addon.author  = 'Mujihina'
_addon.version = '1.03'
_addon.command = 'skilluptracker'
_addon.commands = {'sut'}

-- Required libraries
-- luau
-- config
-- resources.skills
-- resources.jobs
-- texts
-- job_grades.lua (included with this addon)
require ('luau')
require ('pack')
lib = {}
lib.config = require ('config')
lib.skills = require ('resources').skills
lib.texts = require ('texts')
lib.grades = require ('job_grades')


-- Load Defaults
function load_defaults()
    -- Do not load anything if we are not logged in
    if (not windower.ffxi.get_info().logged_in) then return end

    -- Skip if defaults have been loaded.
    if (global) then return end
    
    -- Main global structure
    global = {}
    global.player_name = windower.ffxi.get_player().name
    global.skills_file = "data/%s.xml":format(global.player_name)
    global.main_job_id = 0
    global.main_level = 0
    global.sub_job_id = 0
    global.sub_job_level = 0
    

    -- Default values
    global.defaults = {}
    global.defaults.combatbox = {}
    global.defaults.combatbox.pos = {}
    global.defaults.combatbox.pos.x = 0
    global.defaults.combatbox.pos.y = 50
    global.defaults.combatbox.text = {}
    global.defaults.combatbox.text.font = 'Consolas'
    global.defaults.combatbox.text.size = 10
    global.defaults.combatbox.text.alpha = 255
    global.defaults.combatbox.text.red = 255
    global.defaults.combatbox.text.green = 255
    global.defaults.combatbox.text.blue = 255
    global.defaults.combatbox.bg = {}
    global.defaults.combatbox.bg.alpha = 192
    global.defaults.combatbox.bg.red = 0
    global.defaults.combatbox.bg.green = 0
    global.defaults.combatbox.bg.blue = 0
    global.defaults.combatbox.padding = 5
    global.defaults.combatbox.show = false

    global.defaults.magicbox = {}
    global.defaults.magicbox.pos = {}
    global.defaults.magicbox.pos.x = 250
    global.defaults.magicbox.pos.y = 50
    global.defaults.magicbox.text = {}
    global.defaults.magicbox.text.font = 'Consolas'
    global.defaults.magicbox.text.size = 10
    global.defaults.magicbox.text.alpha = 255
    global.defaults.magicbox.text.red = 255
    global.defaults.magicbox.text.green = 255
    global.defaults.magicbox.text.blue = 255
    global.defaults.magicbox.bg = {}
    global.defaults.magicbox.bg.alpha = 192
    global.defaults.magicbox.bg.red = 0
    global.defaults.magicbox.bg.green = 0
    global.defaults.magicbox.bg.blue = 0
    global.defaults.magicbox.padding = 5
    global.defaults.magicbox.show = false

    global.defaults.craftbox = {}
    global.defaults.craftbox.pos = {}
    global.defaults.craftbox.pos.x = 500
    global.defaults.craftbox.pos.y = 50
    global.defaults.craftbox.text = {}
    global.defaults.craftbox.text.font = 'Consolas'
    global.defaults.craftbox.text.size = 10
    global.defaults.craftbox.text.alpha = 255
    global.defaults.craftbox.text.red = 255
    global.defaults.craftbox.text.green = 255
    global.defaults.craftbox.text.blue = 255
    global.defaults.craftbox.bg = {}
    global.defaults.craftbox.bg.alpha = 192
    global.defaults.craftbox.bg.red = 0
    global.defaults.craftbox.bg.green = 0
    global.defaults.craftbox.bg.blue = 0
    global.defaults.craftbox.padding = 5
    global.defaults.craftbox.show = false

    global.defaults.skills = {}
    global.textdata = {}
    
    local current_skills = windower.ffxi.get_player().skills
    
    -- Set current skills as default values
    --for i,_ in ipairs (lib.skills) do
    for _,i in lib.skills:it() do
        -- Skip the weird (n/a) entry with index 0,  and puppet skills
        if ( (i ~= 0) and (lib.skills[i]['category'] ~= 'Puppet')) then
            local skill_index = tostring(i)
            -- short name is the way it shows in the windower.ffxi.get_player().skills table
            local short_name = lib.skills[i]['name']:lower():gsub(' ', '_'):gsub('-','_')
            global.defaults.skills[skill_index] = T{}
            global.defaults.skills[skill_index]['id'] = tonumber(skill_index)
            global.defaults.skills[skill_index]['name'] = lib.skills[i]['name']
            global.defaults.skills[skill_index]['short_name'] = short_name
            if (not current_skills[short_name]) then
                print ("DEBUG: sut warning: Could not find skill %s":format(short_name))
                global.defaults.skills[skill_index]['level'] = 0
            else
                global.defaults.skills[skill_index]['level'] = current_skills[short_name]
            end
        end
    end
    -- Load previous settings
    global.settings = lib.config.load(global.skills_file, global.defaults)
    
    -- Load skills
    load_skills()
end


-- get short name of skill, and return skill id.
function get_skill_id(skill_name)
    --print ("original skill is %s":format(skill_name))
    --Fix for Hand-to-hand
    if (skill_name == "Hand To Hand" or skill_name == "Hand-to-hand") then skill_name = "Hand-to-Hand" end
    --Fix for Leathercraft/Leatherworking
    if (skill_name == "Leatherworking") then skill_name = "Leathercraft" end
    
    local skill = lib.skills:with('name', skill_name)
    if (skill) then
        return tostring(skill.id)
    else
        print ("sut warning: Unable to find skill id for %s":format(skill_name))
        return "0"
    end
end


-- Calculate max skill level based on grade and job level
function calculate_max(level, grade)
    if (grade == "Z" or level == 0) then return 0 end
    if (grade == "A+") then
        if (level < 51) then return level*3 + 3 end
        if (level < 61) then return level*5 - 97 end
        if (level < 71) then return math.floor (level*4.85 - 88) end
        if (level < 81) then return level*5 - 99 end
        if (level < 91) then return level*6 - 179 end
        return level*7 - 269
    end
    if (grade == "A-") then
        if (level < 51) then return level*3 + 3 end
        if (level < 61) then return level*5 - 97 end
        if (level < 71) then return math.floor(level*4.1 - 43) end
        if (level < 81) then return level*5 - 106 end
        if (level < 91) then return level*6 - 186 end
        return level*7 - 276
    end
    if (grade == "B+") then
        if (level < 51) then return math.floor(level*2.9 + 2.101)  end
        if (level < 61) then return math.floor(level*4.9 - 98)  end
        if (level < 71) then return math.floor(level*3.7 - 26) end
        if (level < 73) then return level*4 - 47 end        
        if (level < 81) then return level*5 - 119 end
        if (level < 91) then return level*6 - 199 end        
        return level*7 - 289
    end
    if (grade == "B") then
        if (level < 51) then return math.floor(level*2.9 + 2.101)  end
        if (level < 61) then return math.floor(level*4.9 - 98)  end
        if (level < 71) then return math.floor(level*3.23 + 2.2) end
        if (level < 74) then return level*4 - 52 end
        if (level < 81) then return level*5 - 125 end
        if (level < 91) then return level*6 - 205 end
        return level*7 - 295
    end
    if (grade == "B-") then
        if (level < 51) then return math.floor(level*2.9 + 2.101)  end
        if (level < 61) then return math.floor(level*4.9 - 98)  end
        if (level < 71) then return math.floor(level*2.7 + 34) end
        if (level < 74) then return level*3 + 13 end
        if (level < 76) then return level*4 - 60 end
        if (level < 81) then return level*5 - 135 end        
        if (level < 91) then return level*6 - 215 end
        return level*7 - 305
    end
    if (grade == "C+") then
        if (level < 51) then return math.floor(level*2.8 + 2.201) end
        if (level < 61) then return math.floor(level*4.8 - 98) end
        if (level < 71) then return math.floor(level*2.5 + 40) end
        if (level < 76) then return level*3 + 5 end
        if (level < 81) then return level*5 - 145 end
        if (level < 91) then return level*6 - 225 end
        return level*7 - 315
    end
    if (grade == "C") then
        if (level < 51) then return math.floor(level*2.8 + 2.201) end
        if (level < 61) then return math.floor(level*4.8 - 98) end
        if (level < 71) then return math.floor(level*2.25 + 55) end
        if (level < 76) then return math.floor(level*2.6 + 30) end
        if (level < 81) then return level*5 - 150 end
        if (level < 91) then return level*6 - 230 end
        return level*7 - 320        
    end
    if (grade == "C-") then
        if (level < 51) then return math.floor(level*2.8 + 2.201) end
        if (level < 61) then return math.floor(level*4.8 - 98) end
        if (level < 71) then return level*2 + 70 end
        if (level < 76) then return level*2 + 70 end
        if (level < 81) then return level*5 - 155 end
        if (level < 91) then return level*6 - 235 end
        return level*7 - 325        
    end
    if (grade == "D") then
        if (level < 51) then return math.floor(level*2.7 + 1.3) end
        if (level < 61) then return math.floor(level*4.7 - 99) end
        if (level < 71) then return math.floor(level*1.85 + 72) end
        if (level < 76) then return math.floor(level*1.7 + 83) end
        if (level < 81) then return level*4 - 90 end
        if (level < 91) then return level*5 - 170 end
        return level*6 - 260
    end
    if (grade == "E") then
        if (level < 51) then return math.floor(level*2.5 + 1.5) end
        if (level < 61) then return math.floor(level*4.5 - 99) end
        if (level < 76) then return level*2 + 50 end
        if (level < 81) then return level*3 - 25 end
        if (level < 91) then return level*4 - 105 end
        return level*5 - 195
    end
    if (grade == "F") then    
        if (level < 51) then return math.floor(level*2.3 + 1.701) end
        if (level < 61) then return math.floor(level*4.3 - 99) end
        if (level < 81) then return math.floor(level*2 + 39) end
        if (level < 91) then return level*3 - 41 end
        return level*4 - 131
    end
    if (grade == "G") then
        if (level < 51) then return level*2 + 1 end
        if (level < 71) then return level*3 - 49 end
        if (level < 91) then return level*2 + 21 end
        return level*3 - 69
    end
    print ("DEBUG: sut warning: Unrecognized grade: %s":format(grade))
    return 0
end


-- Get max skill level of skill with skill id = i
function get_max_level (i)
    -- Don't look up grades or max skillcap for crafting skills
    if (lib.skills[tonumber(i)]['category'] == 'Synthesis') then return 0 end

    local main_grade = lib.grades[i][global.main_job_id]
    local main_max = calculate_max (global.main_job_level, main_grade)

    if (global.sub_job_id) then
        local sub_grade = lib.grades[i][global.sub_job_id]
        local sub_max = calculate_max (global.sub_job_level, sub_grade)
        return math.max (main_max, sub_max)
    else
        return main_max
    end
end


-- Load skills. This only happens after login (with delay), job change, level up/down, or if addon is
-- loaded/reloaded after player logs in.
function load_skills()
    if (not windower.ffxi.get_info().logged_in) then return end
    
    -- Load defaults if needed
    if (not global) then load_defaults() return end
    
    --Added to avoid issues when changing characters too fast
    if (global.player_name ~= windower.ffxi.get_player().name) then
        print ("sut: Reloading")
        logout()
        load_defaults()
        return
    end

    
    local player = windower.ffxi.get_player()
    local main_job = player.main_job_full
    local sub_job = player.sub_job_full

    global.main_job_id = player.main_job_id
    global.main_job_level = player.main_job_level
    global.sub_job_id = player.sub_job_id
    global.sub_job_level = player.sub_job_level
    
    global.textdata = {}

    -- if char has no sub yet
    if (not global.sub_job_id) then
        print ("sut: Loading skills for %s as %s %d":format(global.player_name, main_job, global.main_job_level))
    else    
        print ("sut: Loading skills for %s as %s %d / %s %d":format(global.player_name, main_job, global.main_job_level, sub_job, global.sub_job_level))
    end

    for i,v in pairs (windower.ffxi.get_player().skills) do
        local skill_index = get_skill_id(i:gsub('_', ' '):gsub('-', ' '):capitalize())
        local stored_level = global.settings.skills[skill_index]['level']
        local skill_name = global.settings.skills[skill_index]['short_name']        

        -- Check for updated skill levels, but only update those values that were previously zero.
        -- We skip the others to avoid discrepancies every time this function runs caused
        -- by gear that increases skill. 
        if (  (stored_level == 0)  and  (v > 0)  ) then
            print ("sut: %s has been defaulted to %d":format(skill_name, v))
            stored_level = v
        end
        update_skill (skill_index, stored_level)
        -- Display max level for non-synthesis skills
        if (lib.skills[tonumber(skill_index)]['category'] ~= 'Synthesis') then
            global.textdata["%s_max":format(skill_name)] = "%d":format(get_max_level(tonumber(skill_index)))
        end
    end
    create_text_boxes()
end


-- Update level for skill_id.
function update_skill(skill_id, level)
    if (global.settings.skills[skill_id] and global.settings.skills[skill_id]['level']) then
        local short_name = global.settings.skills[skill_id]['short_name']
        global.settings.skills[skill_id]['level'] = level
        global.textdata["%s_level":format(short_name)] = "%5.1f":format(level)
        local max = get_max_level (tonumber(skill_id))
        -- Show skills we believe to be maxed out in a different color
        if ( (max > 0) and ((level + 0.01) >= max) ) then
            global.textdata["%s_cs":format(short_name)] = '(100,100,255)'
        end
        lib.config.save(global.settings, 'all')
    end    
end


-- Create text boxes, and generate templates
function create_text_boxes()
    -- Combat Skills
    local combatbox_template = L{'\\cs(0,255,255)Combat Skills\\cr'}
      for v, i in lib.skills:category('Combat'):it() do
        -- Only show skills with grade better than Z
        if ( (lib.grades[i][global.main_job_id] ~= 'Z') or (global.sub_job_id and (lib.grades[i][global.sub_job_id] ~= 'Z')) ) then
            local short_name = global.settings.skills[tostring(i)]['short_name']
            local full_name = v['name']:rpad(' ', 18)
            -- format: <color_start or nil><full_name plus padding> <level float or 0> / <level_cap or 0><color end or nil>
            -- e.g. ${archery_cs|\\cs(255,255,255)}Archery:      ${archery_level|0} / ${archery_max|0}\\cr
            combatbox_template:append('\\cs${%s_cs|(255,255,255)}%s${%s_level|0} / ${%s_max|0}\\cr ':format (short_name, full_name, short_name, short_name))
        end
    end
    if (combatbox_template:length() < 2) then
        combatbox_template:append('(none)')
    else 
    	combatbox_template:append (' ')    
    end

    if (global.combatbox) then    
        global.combatbox:destroy()
    end
    global.combatbox = lib.texts.new (combatbox_template:concat('\n'), global.settings.combatbox)
    global.combatbox:update(global.textdata)
    if (global.settings.combatbox.show) then global.combatbox:show() end
    
    -- Magic Skills
    local magicbox_template = L{'\\cs(0,255,255)Magic Skills\\cr'}
    for v,i in lib.skills:category('Magic'):it() do
        -- Only show skills with grade better than Z
        if ( (lib.grades[i][global.main_job_id] ~= 'Z') or (global.sub_job_id and (lib.grades[i][global.sub_job_id] ~= 'Z')) ) then
            local short_name = global.settings.skills[tostring(i)]['short_name']
            local full_name = v['name']:rpad(' ', 18)
            -- format: <color_start or nil><full_name plus padding> <level float or 0> / <level_cap or 0><color end or nil>
            -- e.g. ${archery_cs|\\cs(255,255,255)}Archery:      ${archery_level|0} / ${archery_max|0}\\cr
            magicbox_template:append('\\cs${%s_cs|(255,255,255)}%s${%s_level|0} / ${%s_max|0}\\cr ':format (short_name, full_name, short_name, short_name))
        end
    end
    if (magicbox_template:length() < 2) then
        magicbox_template:append('(none)')
    else
    	magicbox_template:append (' ')
    end

    if (global.magicbox) then
        global.magicbox:destroy()
    end

    global.magicbox = lib.texts.new (magicbox_template:concat('\n'), global.settings.magicbox)
    global.magicbox:update(global.textdata)

    if (global.settings.magicbox.show) then global.magicbox:show() end

    -- Craft Skills
    local craftbox_template = L{'\\cs(0,255,255)Craft Skills\\cr'}
    for v,i in lib.skills:category('Synthesis'):it() do
        local short_name = global.settings.skills[tostring(i)]['short_name']
        local full_name = v['name']:rpad(' ', 18)
        -- format: <full_name plus padding> <level float or 0>
        -- e.g. Cooking      ${cooking_level|0}
        craftbox_template:append('%s${%s_level|0} ':format (full_name, short_name))        
    end
    if (craftbox_template:length() < 2) then
        craftbox_template:append('(none)')
    else
        craftbox_template:append(' ')
    end

    if (global.craftbox) then    
        global.craftbox:destroy()
    end
    global.craftbox = lib.texts.new (craftbox_template:concat('\n'), global.settings.craftbox)
    global.craftbox:update(global.textdata)
    if (global.settings.craftbox.show) then global.craftbox:show() end
end


-- Update text boxes with new data
function update_text_boxes()
    global.combatbox:update(global.textdata)
    global.magicbox:update(global.textdata)
    global.craftbox:update(global.textdata)    
end


-- Hide textboxes and prepare for possible character switch
function logout()
    global.combatbox:hide()
    global.magicbox:hide()
    global.craftbox:hide()

    global.combatbox:destroy()
    global.magicbox:destroy()
    global.craftbox:destroy()

    -- To avoid weird things when switching characters
    --global.clear()
    global = nil
end


-- Show syntax
function show_syntax()
    windower.add_to_chat (200, 'sut: Syntax is:')
    windower.add_to_chat (207, '    \'sut hide < combat | magic | craft | all >\': Hide windows')
    windower.add_to_chat (207, '    \'sut show < combat | magic | craft | all >\': Show windows')
end


-- Parse and process commands
function sut_command (cmd, arg)
        
    if (cmd == 'help' or cmd == '?') then
        show_syntax()
        return
    end

    -- Force a skill reload. Mostly for debugging.
    if (cmd == 'u') then load_skills() return end


    if (not arg) then 
        windower.add_to_chat (167, 'sut: Check your syntax')
        return
    end
                
    -- hide windows
    if (cmd == 'hide' or cmd == 'h') then
        -- hide all
        if (arg == 'all' or arg == 'a') then
            global.combatbox:hide()
            global.magicbox:hide()
            global.craftbox:hide()
            global.settings.combatbox.show = false
            global.settings.magicbox.show = false
            global.settings.craftbox.show = false
            lib.config.save(global.settings, 'all')
            return
        end
        -- hide combat only
        if (arg == 'combat' or arg == 'co') then
            global.combatbox:hide()
            global.settings.combatbox.show = false
            lib.config.save(global.settings, 'all')
            return
        end
        -- hide magic only
        if (arg == 'magic' or arg == 'm') then
            global.magicbox:hide()
            global.settings.magicbox.show = false
            lib.config.save(global.settings, 'all')
            return
        end
        -- hide craft only
        if (arg == 'craft' or arg == 'cr') then
            global.craftbox:hide()
            global.settings.craftbox.show = false
            lib.config.save(global.settings, 'all')
            return
        end
        windower.add_to_chat (167, 'sut: Check your syntax')
        return
    end
                
    -- show windows
    if (cmd == 'show' or cmd == 's') then
        -- show all
        if (arg == 'all' or arg == 'a') then
            global.settings.combatbox.show = true
            global.settings.magicbox.show = true
            global.settings.craftbox.show = true
            lib.config.save(global.settings, 'all')
            global.combatbox:show()
            global.magicbox:show()
            global.craftbox:show()
            return
        end
        -- show combat only
        if (arg == 'combat' or arg == 'co') then
            global.settings.combatbox.show = true
            lib.config.save(global.settings, 'all')
            global.combatbox:show()
            return
        end
        -- show magic only
        if (arg == 'magic' or arg == 'm') then
            global.settings.magicbox.show = true
            lib.config.save(global.settings, 'all')
            global.magicbox:show()
            return
        end
        -- show craft only
        if (arg == 'craft' or arg == 'cr') then
            global.settings.craftbox.show = true
            lib.config.save(global.settings, 'all')
            global.craftbox:show()
            return
        end
        windower.add_to_chat (167, 'sut: Check your syntax')
        return
    end
    -- Show Syntax
    windower.add_to_chat (167, 'sut: Check your syntax')
end



-- Process incoming texts
function process_skillup_text (original, modified, original_mode, modified_mode, blocked)    
    -- All skill up msgs have mode = 129.
    if (original_mode == 129) then
    	line = original:strip_colors()
    	--print ("original is %s":format(original))
    	--print ("modified is %s":format(modified))                
        -- skillup increase
        -- example: "Name's healing magic skill rises 0.3 points."
        if (line:match('skill rises')) then
            local _,_, player_name, skill_name, increase  = line:find("(%a+)'s (.+) skill rises 0.(%d+)")
            local skill_id = get_skill_id(skill_name:capitalize())

            -- Unable to find skill_id
            if (not skill_id) then return end

            local old_level = global.settings.skills[skill_id]['level']
        --    local new_level = tonumber(old_level) + tonumber("0.%d":format(increase))
            local new_level = tonumber(old_level) + (tonumber(increase) / 10)

            update_skill (skill_id, new_level)
            update_text_boxes()

            if (lib.skills[tonumber(skill_id)]['category'] == 'Synthesis') then
                return "%s (%0.1f)":format(modified, new_level)
            else
                local max = get_max_level (tonumber(skill_id))
                return "%s (%0.1f/%d)":format(modified, new_level, max)
            end
        end
        
        -- new skill level 
        -- example: "Name's healing magic skill reaches level 167"
        if (line:match('skill reaches')) then
            local _,_, player_name, skill_name, level_str  = line:find("(%a+)'s (.+) skill reaches level (%d+)")
            local skill_id = get_skill_id(skill_name:capitalize())

            -- Unable to find skill_id
            if (not skill_id) then return end

            local old_level = global.settings.skills[skill_id]['level']
            local new_level = tonumber(level_str)
    
            -- in sync
            if ((old_level + 0.01):floor() == new_level:floor()) then
                if (lib.skills[tonumber(skill_id)]['category'] == 'Synthesis') then
                    return "%s (%0.1f)":format(modified, old_level)
                else
                    local max = get_max_level (tonumber(skill_id))
                    return "%s (%0.1f/%d)":format(modified, old_level, max)
                end
            end
            --[[
            --DEBUG MESSAGE
            print ("------------")
            print ("OUT OF SYNC:")
            print (old_level, old_level:floor(), new_level, new_level:floor())
            print('nnnn':pack(old_level, old_level:floor(), new_level, new_level:floor()):hex(' '))
            print ("------------")
          ]]
            
            -- out of sync
            update_skill (skill_id, new_level)
            update_text_boxes()
            print ("sut: %s has been corrected from %0.1f to %s.0":format(skill_name, old_level, level_str))
            return modified -- return unmodified string
        end
    end
end


-- Add a delay of 5 secs before running load_skills. Only used with login events.
function delay_load_skills()
    print ("sut: Loading skills in 5 secs...")
    windower.send_command ('wait 5; lua i skilluptracker load_skills')
end

function level_change(new)
	-- Debug
    -- print ("level change")
    -- print ("new level is %d":format(new))
    load_skills()
end

-- Register callbacks
windower.register_event ('addon command', sut_command)
windower.register_event ('load', load_defaults)
windower.register_event ('job change', load_skills)
windower.register_event ('level up', 'level down', level_change)
-- Skill data doesn't seem to be available yet right after a login, so delay load_skills by 5 secs.
windower.register_event ('login', delay_load_skills)
windower.register_event ('incoming text', process_skillup_text)
windower.register_event ('logout', logout)
