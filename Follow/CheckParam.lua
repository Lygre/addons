require('lists')
texts = require('texts')
config = require('config')
packets = require('packets')

_addon.command = 'cp'
_addon.name = 'CheckParam'
_addon.version = '1.0.0'
_addon.author = 'Lygre'

windower.register_event('addon command', function(...)
	local commands = {...}
	if commands[1] == 'me' then
		local packet = packets.new('outgoing', 0x0DD, {['Check Type'] = 02})
		local data = packets.build(packet)
		packets.inject(packet)
	end
end)

