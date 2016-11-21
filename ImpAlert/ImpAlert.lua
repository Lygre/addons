_addon.name     = 'ImpAlert'
_addon.author   = 'Lygre'
_addon.version  = '1.0.1'
_addon.commands = {}

require('luau')
require('pack')
require('lists')
require('logger')
require('sets')
packets = require('packets')
require('chat')
res = require('resources')

local cur_imps = 0

windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)
    if id == 0x118 then
    	cur_imps = data:unpack('H',0x0B)
    	-- print(cur_imps)
    	if cur_imps == 15 then
    		windower.add_to_chat(2,"Imprimaturs are full! Spend them!")
    	end
    end
end)

