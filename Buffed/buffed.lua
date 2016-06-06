_addon.name = 'Buffed'
_addon.author = 'Lygre'
_addon.version = '1.00'

require('luau')
packets = require('packets')
texts = require('texts')

defaults = {}
defaults.pos = {}
defaults.pos.x = 600
defaults.pos.y = 300
defaults.text = {}
defaults.text.font = 'Courier New'
defaults.text.size = 10
defaults.flags = {}
defaults.flags.bold = true
defaults.flags.draggable = false
defaults.bg = {}
defaults.bg.alpha = 128

settings = config.load(defaults)
box = texts.new('${current_string}', settings)
box:show()

frame_time = 0
debuffed_mobs = {}


buffs = {
    [33] = S{569,1782,1851,1952,3024,3093,3132,3220,3664,3978,57,530}, --Haste
    [34] = S{632,1789,3024,3522,249}, --BlazeSpikes
    [35] = S{878,250}, --Icespikes
    [36] = S{1255,1722,53}, --Blink 
    [38] = S{889,1239,1358,1537,251}, --ShockSpikes
    [37] = S{448,853,1744,1897,2077,2097,3024,3522,54}, --Stoneskin
    [39] = S{3014,55}, --Aquaveil
    [40] = S{908,43,44,45,46,47,125,126,127,128,129}, --Protect
    [41] = S{423,503,908,1590,3474,3862,48,49,50,51,52,130,131,132,133,134}, --Shell
    [42] = [539] = S{304,324,418,461,1674,1875,2579}, --Regen
    [43] = [541] = S{525}, --Refresh
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
    [66] = S{338,339,340}, --Copy Image
    [68] = S{633,1072,1079,1428,1512,1514,1516,2227}, --Warcry
    [80] = [119] = [542] = S{266,479}, --STR Boost
    [81] = [120] = [543] = S{267,480}, --DEX Boost
    [82] = [121] = [544] = S{268,481}, --VIT Boost
    [83] = [122] = [545] = S{285,1564,269,482}, --AGI Boost
    [84] = [123] = [546] = S{270,483}, --INT Boost
    [85] = [124] = [547] = S{271,484}, --MND Boost
    [86] = [125] = [548] = S{272,485}, --CHR Boost
    [90] = [533] = S{1734,1924,2756}, --Accuracy Boost
    [91] = [549] = S{356,481,1336,2173,2174,2423,2756,2945,3014,3024,3220,3515,3975}, --Attack Boost
    [92] = [554] = S{373,390,402,454,459,496,724,793,815,925,1660,1734,1869,1924,2579,3515,3878}, --Evasion Boost
    [93] = [550] = S{346,384,391,445,453,608,614,619,674,752,753,754,774,775,776,794,807,1050,1060,1078,1382,1583,1592,1648,1783,
        1860,1868,2226,3220,3483,3515,3864,3926,3971}, --Defense Boost
    [94] = S{823,3207,100}, --Enfire
    [95] = S{824,3208,101}, --Enblizzard
    [96] = S{825,3209,102}, --Enaero
    [97] = S{826,3210,103}, --Enstone
    [98] = S{827,887,3211,104}, --Enthunder
    [99] = S{828,3212,105}, --Enwater
    [116] = S{546,1703,106,107}, --Phalanx
    [150] = S{1504,1831}, --Physical Shield
    [151] = S{553,1141}, --Arrow Shield
    [152] = S{471,522,555,1143,1239,1505,1537,1829}, --Magic Shield
    [153] = S{650,1176,1186,4040}, --Damage Spikes
    [163] = S{}, --Azure Lore
    [169] = S{}, --Potency
    [170] = S{2579,495}, --Regain
    [172] = S{2756}, --Intension
    [173] = S{}, --Dread Spikes
    [190] = [551] = S{530,556,1957,1964,2173,2174,2756,3014,3024,3220,3515,3624,3765}, --Magic Atk Boost
    [191] = [552] = S{556,1352,1964,3220,3515}, --Magic Def. Boost
    [195] = S{378,379,380,381,382,383,384,385}, --Paeon
    [196] = S{386,387,388}, --Ballad
    [197] = S{389,390,391,392,393}, --Minne
    [198] = S{394,395,396,397,398}, --Minuet
    [199] = S{399,400}, --Madrigal
    [200] = S{401,402}, --Prelude
    [201] = S{403,404}, --Mambo
    [214] = S{417,419,420}, --March
    [222] = S{}, --Scherzo
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
    [487] = S{}, --Endrain
    [488] = S{}, --Enaspir
    [490] = S{}, --Brazen Rush
    [501] = S{}, --Yaegasumi
    [522] = S{3479}, --Elemental Sforzo
    [523] = S{3103,3985}, --Ignis
    [524] = S{3104,3986}, --Gelus
    [525] = S{3105,3987}, --Flabra
    [526] = S{3106,3988}, --Tellus
    [527] = S{3107,3989}, --Sulpor
    [528] = S{3108,3990}, --Unda
    [529] = S{3109,3991}, --Lux
    [530] = S{3110,3992}, --Tenebrae
    [555] = S{}, --Magic Acc. Boost
    [556] = [611] = S{3515}, --Magic Evasion Boost
}

hierarchy = {
    [23] = 1, --Dia
    [24] = 3, --Dia II
    [25] = 5, --Dia III
    [230] = 2, --Bio
    [231] = 4, --Bio II
    [232] = 6, --Bio III
}

function apply_dot(target, spell)
    if not debuffed_mobs[target] then
        debuffed_mobs[target] = {}
    end

    local priority = 0
    local current = debuffed_mobs[target][134] or debuffed_mobs[target][135]
    if current then
        priority = hierarchy[current]
    end

    if hierarchy[spell] > priority then
        if T{23,24,25}:contains(spell) then
            debuffed_mobs[target][134] = spell
            debuffed_mobs[target][135] = nil
        elseif T{230,231,232}:contains(spell) then
            debuffed_mobs[target][134] = nil
            debuffed_mobs[target][135] = spell
        end
    end
end

--[[function apply_helix(target, spell)
    if not debuffed_mobs[target] then
        debuffed_mobs[target] = {}
    end
    debuffed_mobs[target][186] = {name = spell, timer = os.clock() + 230}
end]]

function show_bio(debuff_table)
    if debuff_table then
        if debuff_table[134] and debuff_table[134] == 25 then
            return false
        elseif debuff_table[135] and (debuff_table[135] == 231 or debuff_table[135] == 232) then
            return false
        end
    end
    return true
end

function update_box()
    local current_string = ''
    local player = windower.ffxi.get_player()
    local target = windower.ffxi.get_mob_by_target('t')

    if target and target.valid_target and target.is_npc and (target.claim_id ~= 0 or target.spawn_type == 16) then
        local debuff_table = debuffed_mobs[target.id]

        current_string = 'Debuffed ['..target.name..']\n'
        if debuff_table then
            for effect, spell in pairs(debuff_table) do
                if spell then
                    if type(spell) == 'table' then
                        current_string = current_string..'\n'..res.spells[spell.name].en
                        current_string = current_string..' : '..string.format('%.0f',spell.timer - os.clock())
                    else
                        current_string = current_string..'\n'..res.spells[spell].en
                    end
                end
            end
        end

        if player and player.status == 1 then
            current_string = current_string..'\\cs(255,0,0)'
            if show_bio(debuff_table) then
                current_string = current_string..'\nBio'
            end
        end
    end

    box.current_string = current_string
end

function inc_action(act)
    if act.category == 7 then
        if T{186,194,205,230,266,280}:contains(act.targets[1].actions[1].message) then
            local effect = act.targets[1].actions[1].param
            local target = act.targets[1].id
            local spell = act.param

            if not buffed_mobs[target] then
                buffed_mobs[target] = {}
            end

            if buffs[effect] and buffs[effect]:contains(spell) then
                buffed_mobs[target][effect] = spell
            end
        end
    end
end

function inc_action_message(arr)
    if T{6,20,113,406,605,646}:contains(arr.message_id) then
        debuffed_mobs[arr.target_id] = nil
    elseif T{204,206}:contains(arr.message_id) then
        if debuffed_mobs[arr.target_id] then
            debuffed_mobs[arr.target_id][arr.param_1] = nil
        end
    end
end

windower.register_event('incoming chunk', function(id, data)
    if id == 0x028 then
        inc_action(windower.packets.parse_action(data))
    elseif id == 0x029 then
        local arr = {}
        arr.target_id = data:unpack('I',0x09)
        arr.param_1 = data:unpack('I',0x0D)
        arr.message_id = data:unpack('H',0x19)%32768
        
        inc_action_message(arr)
    end
end)
-----------------------------------
function check_target_id(packet) --checks to see if player is one of the targets
    for i,v in pairs(packet) do
        if string.match(i, 'Target %d+ ID') then
            if windower.ffxi.get_player().id == v then
                return true
            end
        end
    end
    return false
end

function check_target_action(packet)
    for i,v in pairs(packet) do
        if string.match(i, 'Target %d+ Action %d+ Param') and gaze_attacks[v] then
            return true
        end
    end
    return false
end

windower.register_event('incoming chunk', function(id, data, modified, injected, blocked)
    if id == 0x028 then
        local packet = packets.parse('incoming', data)
        if windower.ffxi.get_mob_by_target('t')then
            if packet['Category'] == 7 and check_target_id(packet) and settings.gaze_watch and not gaze then
                if check_target_action(packet) then
                    gaze = true
                    trigered_actor = packet['Actor']
                    windower.ffxi.turn(windower.ffxi.get_mob_by_id(packet['Actor']).facing)
                end
            elseif packet['Actor'] == trigered_actor and packet['Category'] == 11 and settings.gaze_watch and gaze then
                if gaze_attacks[packet['Param']] then
                    gaze = false
                    trigered_actor = 0
                    windower.ffxi.turn:schedule(1,windower.ffxi.get_mob_by_target('t').facing+math.pi)
                end
            end
        end
    end
end)
-------------------
windower.register_event('prerender', function()
    local curr = os.clock()
    if curr > frame_time + .1 then
        frame_time = curr
        update_box()
    end
end)

windower.register_event('logout','zone change', function()
    debuffed_mobs = {}
end)
