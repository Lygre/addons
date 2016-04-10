bit = require('bit')

reg = {}

windower.register_event('incoming chunk',function(id,original,modified,is_injected,is_blocked)
    if id == 0x00E and string.len(original) >= 53 then
        local bool = ( bit.band(original:byte(33),0x06) > 0)
        reg[original:byte(10)*256+original:byte(9)]=bool
        if bool then
            return original:sub(1,32)..string.char(bit.band(original:byte(33),0xF9))..original:sub(34,string.len(original))
        end
    end
end)

windower.register_event('outgoing chunk',function(id,original,modified,is_injected,is_blocked)
    if id == 0x015 and reg[original:byte(24)*256+original:byte(23)] then
        return original:sub(1,22)..string.char(0,0)..original:sub(25)
    end
end)

windower.register_event('zone change',function(...)
    reg = {}
end)