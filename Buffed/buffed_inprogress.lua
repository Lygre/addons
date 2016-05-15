_addon.name = 'Buffed'
_addon.author = 'Lygre'
_addon.version = '1.00'

require('luau')
packets = require('packets')

local abil_ids = {
    [33] = S{569,1782,1851,1952,3024,3093,3132,3220,3664,3978}, --Haste
    [34] = S{632,1789,3024,3522}, --BlazeSpikes
    [35] = S{878}, --Icespikes
    [36] = S{1255,1722}, --Blink 
    [38] = S{889,1239,1358,1537}, --ShockSpikes
    [37] = S{448,853,1744,1897,2077,2097,3024,3522}, --Stoneskin
    [39] = S{3014}, --Aquaveil
    [40] = S{908}, --Protect
    [41] = S{423,503,908,1590,3474,3862}, --Shell
    [42] = S{304,324,418,461,1674,1875,2579}, --Regen
    [43] = S{525}, --Refresh
    [44] = S{688,1008,2242,2939}, --MightsStrikes
    [46] = S{690,1009,1485,2020,2243}, --Hundred Fists
    [47] = S{691,1011,2245,2944}, --Manafont
    [48] = S{692,1012,2246,2942}, --Chainspell
    [49] = S{693,1013,2247}, --PerfectD
    [50] = S{694,1014,2248,2940}, --Invincible
    [51] = S{695,1015,2249}, --Blood Weapon
    [52] = S{696,1018,2251}, --Soujlvoice
    [54] = S{730,1020,2253,3175}, --MeikyoShisui
    [55] = S{734,1023,2256}, --AstralFlow
    [56] = S{261,265,286,510,526,537,598,697,1565,1647,2217,3858}, --Berserk
    [57] = S{698}, --Defender
    [58] = S{699}, --Aggressor
    [61] = S{359,704,1429}, --Counterstance
    [68] = S{633,1072,1079,1428,1512,1514,1516,2227}, --Warcry
    [80] = S{266,479}, --STR Boost
    [81] = S{267,480}, --DEX Boost
    [82] = S{268,481}, --VIT Boost
    [83] = S{285,1564}, --AGI Boost
    [84] = S{270,483}, --INT Boost
    [85] = S{271,484}, --MND Boost
    [86] = S{272,485}, --CHR Boost
    [90] = S{1734,1924,2756}, --Accuracy Boost
    [91] = S{356,481,1336,2173,2174,2423,2756,2945,3014,3024,3220,3515,3975}, --Attack Boost
    [92] = S{373,390,402,454,459,496,724,793,815,925,1660,1734,1869,1924,2579,3515,3878}, --Evasion Boost
    [93] = S{346,384,391,445,453,608,614,619,674,752,753,754,774,775,776,794,807,1050,1060,1078,1382,1583,1592,1648,1783,
        1860,1868,2226,3220,3483,3515,3864,3926,3971}, --Defense Boost
    [94] = S{823,3207}, --Enfire
    [95] = S{824,3208}, --Enblizzard
    [96] = S{825,3209}, --Enaero
    [97] = S{826,3210}, --Enstone
    [98] = S{827,887,3211}, --Enthunder
    [99] = S{828,3212}, --Enwater
    [116] = S{546,1703}, --Phalanx
    [119] = S{266,479}, --STR Boost
    [120] = S{267,480}, --DEX Boost
    [121] = S{268,481}, --VIT Boost
    [122] = S{285,1564}, --AGI Boost
    [123] = S{270,483}, --INT Boost
    [124] = S{271,484}, --MND Boost
    [125] = S{272,485}, --CHR Boost
    [150] = S{1504,1831}, --Physical Shield
    [151] = S{553,1141}, --Arrow Shield
    [152] = S{471,522,555,1143,1239,1505,1537,1829}, --Magic Shield
    [153] = S{650,1176,1186,4040}, --Damage Spikes
    [163] = S{}, --Azure Lore
    [169] = S{}, --Potency
    [170] = S{2579}, --Regain
    [172] = S{2756}, --Intension
    [173] = S{}, --Dread Spikes
    [190] = S{530,556,1957,1964,2173,2174,2756,3014,3024,3220,3515,3624,3765}, --Magic Atk Boost
    [191] = S{556,1352,1964,3220,3515}, --Magic Def. Boost
    [522] = S{3479}, --Elemental Sforzo
    [523] = S{3103,3985}, --Ignis
    [524] = S{3104,3986}, --Gelus
    [525] = S{3105,3987}, --Flabra
    [526] = S{3106,3988}, --Tellus
    [527] = S{3107,3989}, --Sulpor
    [528] = S{3108,3990}, --Unda
    [529] = S{3109,3991}, --Lux
    [530] = S{3110,3992}, --Tenebrae
    [533] = S{1734,1924,2756}, --Accuracy Boost
    [539] = S{304,324,418,461,1674,1875,2579}, --Regen
    [541] = S{525}, --Refresh
    [542] = S{266,479}, --STR Boost
    [543] = S{267,480}, --DEX Boost
    [544] = S{268,481}, --VIT Boost
    [545] = S{285,1564}, --AGI Boost
    [546] = S{270,483}, --INT Boost
    [547] = S{271,484}, --MND Boost
    [548] = S{272,485}, --CHR Boost
    [549] = S{356,481,1336,2173,2174,2423,2756,2945,3014,3024,3220,3515,3975}, --Attack Boost
    [550] = S{346,384,391,445,453,608,614,619,674,752,753,754,774,775,776,794,807,1050,1060,1078,1382,1583,1592,1648,1783,
        1860,1868,2226,3220,3483,3515,3864,3926,3971}, --Defense Boost
    [551] = S{530,556,1957,1964,2173,2174,2756,3014,3024,3220,3515,3624,3765}, --Magic Atk Boost
    [552] = S{556,1352,1964,3220,3515}, --Magic Def. Boost

    [554] = S{373,390,402,454,459,496,724,793,815,925,1660,1734,1869,1924,2579,3515,3878}, --Evasion Boost

    [555] = S{}, --Magic Acc. Boost
    [556] = S{3515}, --Magic Evasion Boost
    [611] = S{3515}, --Magic Evasion Boost
}
local spell_ids = {
    [33] = S{57,530}, --Haste
    [34] = S{249}, --Blaze Spikes
    [35] = S{250}, --Ice Spikes
    [36] = S{53}, --Blink
    [37] = S{54}, --Stoneskin
    [38] = S{251}, --Shock Spikes
    [39] = S{55}, --Aquaveil
    [40] = S{43,44,45,46,47,125,126,127,128,129}, --Protect
    [41] = S{48,49,50,51,52,130,131,132,133,134}, --Shell
    [66] = S{338,339,340}, --Copy Image (utsusemi)
    [83] = S{269,482}, --AGI Boost
    [94] = S{100}, --Enfire
    [95] = S{101}, --Enblizzard
    [96] = S{102}, --Enaero
    [97] = S{103}, --Enstone
    [98] = S{104}, --Enthunder
    [99] = S{105}, --Enwater
    [116] = S{106,107}, --Phalanx
    [122] = S{269,482}, --AGI Boost
    [170] = S{495}, --Regain
    [195] = S{378,379,380,381,382,383,384,385}, --Paeon
    [196] = S{386,387,388}, --Ballad
    [197] = S{389,390,391,392,393}, --Minne
    [198] = S{394,395,396,397,398}, --Minuet
    [199] = S{399,400}, --Madrigal
    [200] = S{401,402}, --Prelude
    [201] = S{403,404}, --Mambo
    [214] = S{417,419,420}, --March
    [227] = S{509}, --Store TP
    [228] = S{478}, --Embrava
    [274] = S{310}, --Enlight
    [277] = S{312}, --Enfire 2
    [278] = S{313}, --Enblizzard 2
    [279] = S{314}, --Enaero 2
    [280] = S{315}, -- Enstone 2
    [281] = S{316}, --Enthunder 2
    [282] = S{317}, --Ennwater 2
    [288] = S{311}, --Endark
    [432] = S{493}, --Multi-Strikes
    [545] = S{269,482}, --AGI Boost

}
local buff_ids = abil_ids:union(spell_ids)

windower.register_event('incoming chunk', function(id, data)
    if id == 0x28 then
        local ai = get_action_info(id, data)
        local actor = windower.ffxi.get_mob_by_id(ai.actor_id)
        local target = windower.ffxi.get_mob_by_target()
        if (actor ~= nil) and (actor.is_npc) and (target ~= nil) and (target.id == ai.actor_id) then
            for _,targ in pairs(ai.targets) do
                for _,tact in pairs(targ.actions) do
                    if start_ids:contains(tact.message_id) then
                        if processAction(tact.message_id, tact.param) then
                            return
                        end
                    end
                end
            end
        end
    end
end)

--[[
    Parse the given packet and construct a table to make its contents useful.
    Based on the 'incoming chunk' function in the Battlemod addon (thanks to Byrth / SnickySnacks)
    @param id packet ID
    @param data raw packet contents
    @return a table representing the given packet's data
--]]
function get_action_info(id, data)
    local pref = data:sub(1,4)
    local data = data:sub(5)
    if id == 0x28 then          -------------- ACTION PACKET ---------------
        local act = {}
        act.do_not_need = get_bit_packed(data,0,8)
        act.actor_id    = get_bit_packed(data,8,40)
        act.target_count= get_bit_packed(data,40,50)
        act.category    = get_bit_packed(data,50,54)
        act.param   = get_bit_packed(data,54,70)
        act.unknown = get_bit_packed(data,70,86)
        act.recast  = get_bit_packed(data,86,118)
        act.targets = {}
        local offset = 118
        for i = 1, act.target_count do
            act.targets[i] = {}
            act.targets[i].id = get_bit_packed(data,offset,offset+32)
            act.targets[i].action_count = get_bit_packed(data,offset+32,offset+36)
            offset = offset + 36
            act.targets[i].actions = {}
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n] = {}
                act.targets[i].actions[n].reaction  = get_bit_packed(data,offset,offset+5)
                act.targets[i].actions[n].animation = get_bit_packed(data,offset+5,offset+16)
                act.targets[i].actions[n].effect    = get_bit_packed(data,offset+16,offset+21)
                act.targets[i].actions[n].stagger   = get_bit_packed(data,offset+21,offset+27)
                act.targets[i].actions[n].param     = get_bit_packed(data,offset+27,offset+44)
                act.targets[i].actions[n].message_id    = get_bit_packed(data,offset+44,offset+54)
                act.targets[i].actions[n].unknown   = get_bit_packed(data,offset+54,offset+85)
                act.targets[i].actions[n].has_add_efct  = get_bit_packed(data,offset+85,offset+86)
                offset = offset + 86
                if act.targets[i].actions[n].has_add_efct == 1 then
                    act.targets[i].actions[n].has_add_efct      = true
                    act.targets[i].actions[n].add_efct_animation    = get_bit_packed(data,offset,offset+6)
                    act.targets[i].actions[n].add_efct_effect   = get_bit_packed(data,offset+6,offset+10)
                    act.targets[i].actions[n].add_efct_param    = get_bit_packed(data,offset+10,offset+27)
                    act.targets[i].actions[n].add_efct_message_id   = get_bit_packed(data,offset+27,offset+37)
                    offset = offset + 37
                else
                    act.targets[i].actions[n].has_add_efct      = false
                    act.targets[i].actions[n].add_efct_animation    = 0
                    act.targets[i].actions[n].add_efct_effect   = 0
                    act.targets[i].actions[n].add_efct_param    = 0
                    act.targets[i].actions[n].add_efct_message_id   = 0
                end
                act.targets[i].actions[n].has_spike_efct = get_bit_packed(data,offset,offset+1)
                offset = offset + 1
                if act.targets[i].actions[n].has_spike_efct == 1 then
                    act.targets[i].actions[n].has_spike_efct    = true
                    act.targets[i].actions[n].spike_efct_animation  = get_bit_packed(data,offset,offset+6)
                    act.targets[i].actions[n].spike_efct_effect = get_bit_packed(data,offset+6,offset+10)
                    act.targets[i].actions[n].spike_efct_param  = get_bit_packed(data,offset+10,offset+24)
                    act.targets[i].actions[n].spike_efct_message_id = get_bit_packed(data,offset+24,offset+34)
                    offset = offset + 34
                else
                    act.targets[i].actions[n].has_spike_efct    = false
                    act.targets[i].actions[n].spike_efct_animation  = 0
                    act.targets[i].actions[n].spike_efct_effect = 0
                    act.targets[i].actions[n].spike_efct_param  = 0
                    act.targets[i].actions[n].spike_efct_message_id = 0
                end
            end
        end
        return act
    elseif id == 0x29 then      ----------- ACTION MESSAGE ------------
        local am = {}
        am.actor_id = get_bit_packed(data,0,32)
        am.target_id    = get_bit_packed(data,32,64)
        am.param_1  = get_bit_packed(data,64,96)
        am.param_2  = get_bit_packed(data,96,106)   -- First 6 bits
        am.param_3  = get_bit_packed(data,106,128)  -- Rest
        am.actor_index  = get_bit_packed(data,128,144)
        am.target_index = get_bit_packed(data,144,160)
        am.message_id   = get_bit_packed(data,160,175)  -- Cut off the most significant bit, hopefully
        return am
    end
end

function get_bit_packed(dat_string,start,stop)
    --Copied from Battlemod; thanks to Byrth / SnickySnacks
    local newval = 0   
    local c_count = math.ceil(stop/8)
    while c_count >= math.ceil((start+1)/8) do
        local cur_val = dat_string:byte(c_count)
        local scal = 256
        if c_count == math.ceil(stop/8) then
            cur_val = cur_val%(2^((stop-1)%8+1))
        end
        if c_count == math.ceil((start+1)/8) then
            cur_val = math.floor(cur_val/(2^(start%8)))
            scal = 2^(8-start%8)
        end
        newval = newval*scal + cur_val
        c_count = c_count - 1
    end
    return newval
end

