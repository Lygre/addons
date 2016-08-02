--[[
    Functions for executing semi-arbitrary code from the chat window.  Formerly
    part of info/info_share.lua
    Author: Ragnarok.Lorand
--]]

local lor_exec = {}
lor_exec._author = 'Ragnarok.Lorand'
lor_exec._version = '2016.07.02'

require('lor/lor_utils')
_libs.req('maths', 'strings', 'tables')
_libs.lor.req('chat')
_libs.lor.exec = lor_exec


--[[
    Parses the given command for table names or functions, then returns the
    result of executing the given function, or table or value with the
    given name.
--]]
local function parse_for_info(command)
    local toload = command:startswith('return ') and command or 'return '..command
    local loaded = loadstring(toload)
    lor.G.setfenv(loaded, _G)
    return loaded()
end


function lor_exec.process_input(command, args)
    local cmd = command:lower()
    if S{'search','with','find'}:contains(cmd) then
        local target = args[1]
        local field = args[2]
        local val = args[3]
        if (target ~= nil) and (field ~= nil) and (val ~= nil) then
            local parsed = parse_for_info(target)
            local results = parsed:with(field, val)
            if (results ~= nil) then
                pprint(parsed:with(field, val), target..':with('..field..','..val..')')
            else
                atc(2, target..':with('..field..','..val..'): No results.')
            end
        else
            atc(0, 'Error: Invalid arguments passed for search')
        end
    elseif cmd == 'spells' then
        local stype = args[1]
        atc(0, 'spell_id,spell_name,element,skill')
        for k,v in pairs(res.spells) do
            if v.type == stype then
                atc(0, v.id..','..v.en..','..v.element..','..v.skill)
            end
        end
    elseif cmd == 'colortest' then
        for c = 0, 256 do
            atc(c, 'color test: '..c)
        end
    elseif cmd == 'colorize_test' then
        atc(0,'Colorize Test')
        for c = 0, 37 do
            if (c<14) or (c>24) then
                local line = ''
                for i = 0, 9 do
                    if (#line > 1) then
                        line = line..' '
                    end
                    local n = (c*10) + i
                    local ns = '%03d':format(n):colorize(n)
                    line = line..ns
                end
                atc(0,line)
            end
        end
    else
        if (args ~= nil) and (sizeof(args) > 0) then
            local sargs = table.concat(args, ' ')
            local joiner = (#sargs > 0) and ' ' or ''
            command = command..joiner..sargs
            atc(command)
        end
        local parsed = parse_for_info(command)
        
        if parsed ~= nil then
            local msg = ':'
            if (type(parsed) == 'table') then
                msg = ' ('..sizeof(parsed)..'):'
            end
            pprint(parsed, command..msg)
        else
            atc(3,'Error: Unable to parse valid command from "'..command..'"')
        end
    end
end


return lor_exec

-----------------------------------------------------------------------------------------------------------
--[[
Copyright © 2016, Ragnarok.Lorand
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of libs/lor nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Lorand BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]
-----------------------------------------------------------------------------------------------------------
