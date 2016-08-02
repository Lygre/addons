--[[
    Settings library that saves settings as a lua file instead of XML.  The
    config library is too inflexible for storing k,v pairs when keys contain
    invalid xml tags, and XML is very verbose.  This was easier than finding or
    writing a JSON writer since the included JSON library is for reading only.
    
    Any valid lua can be loaded by this library.  Results may be unpredictable
    if saving tables that contain types other than string/number/table.
    
    Author: Ragnarok.Lorand
--]]

local lor_settings = {}
lor_settings._author = 'Ragnarok.Lorand'
lor_settings._version = '2016.07.31.1'

require('lor/lor_utils')
_libs.lor.settings = lor_settings
_libs.lor.req('chat')
files = require('files')


function lor_settings.load(filepath, defaults)
    if type(filepath) ~= 'string' then
        filepath, defaults = 'data/settings.lua', filepath
    end
    local loaded = nil
    local fcontents = files.read(filepath)
    if (fcontents ~= nil) then
        loaded = loadstring(fcontents)()
    end
    
    local do_save = false
    if loaded == nil then
        loaded = defaults
        do_save = true
    end
    
    local m = getmetatable(loaded)
    if m == nil then
        m = {}
        setmetatable(loaded, m)
    end
    m.__settings_path = filepath
    
    if do_save then
        lor_settings.save(loaded)
    end
    return loaded
end


local function str_esc(s)
    return s:gsub("'","\\'")
end


local function prepare(t)
    local res = {}
    local tlen = 0
    for _,_ in pairs(t) do tlen = tlen + 1 end
    local i = 1
    for k,v in pairs(t) do
        local pk = tostring(k)
        if type(k) ~= 'number' then
            pk = "'%s'":format(str_esc(pk))
        end
        pk = '[%s] =':format(pk)
        
        if type(v) == 'table' then
            res[#res+1] = '%s {\n':format(pk)
            for _,line in pairs(prepare(v)) do
                res[#res+1] = '\t%s':format(line)
            end
            res[#res+1] = '}'
        else
            local pv = tostring(v)
            if type(v) ~= 'number' then
                pv = "'%s'":format(str_esc(pv))
            end
            res[#res+1] = '%s %s':format(pk, pv)
        end
        
        if i < tlen then
            res[#res] = res[#res]..','
        end
        res[#res] = res[#res]..'\n'
        i = i + 1
    end
    return res
end


function lor_settings.save(settings_tbl)
    local m = getmetatable(settings_tbl)
    if m == nil or m.__settings_path == nil then
        error('Invalid argument passed to settings.save: %s':format(tostring(settings_tbl)))
        return
    end
    
    local prepared = prepare(settings_tbl)
    if prepared == nil then
        error('Unexpected error occurred while preparing output')
        return
    end
    
    local filepath = windower.addon_path .. m.__settings_path
    local f = io.open(filepath, 'w')
    f:write('return {\n')
    for _,line in pairs(prepared) do
        f:write('\t%s':format(line))
    end
    f:write('}\n')
    f:close()
    
    windower.add_to_chat(1, 'Saved settings to: %s':format(filepath))
end


return lor_settings

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