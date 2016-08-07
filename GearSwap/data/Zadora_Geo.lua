function get_sets()
    mote_include_version = 2
    include('organizer-lib')
    include('Mote-Include.lua')
end
 
function job_setup()
    indi_timer = ''
    indi_duration = 310
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Magic Burst')
    state.IdleMode:options('Normal', 'PDT')
 
    state.MagicBurst = M(false, 'Magic Burst')
 
    gear.default.weaponskill_waist = "Fotia Belt"
 
    select_default_macro_book()
 
    custom_timers = {}
end
 
 organizer_items = {
  echos="Echo Drops",
  remedies="Remedy",
  holy="Holy Water",
  crepe="Pear Crepe"
}

-------------------------------------------------------------------------------
 
function init_gear_sets()
 
--------------------------[Job Ability sets]------------------------------
 
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1",back="Nantosuelta's Cape"}
    sets.precast.JA['Full Circle'] = {head="Azimuth hood +1",hands="Bagua Mitaines"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals"}
 
--------------------------[Fast Cast sets]------------------------------
 
    sets.precast.FC = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Chanter's Shield",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -1%','Pet: INT+5','"Fast Cast"+6','Accuracy+16 Attack+16',}},
    body="Shango Robe",
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    legs="Geo. Pants +1",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Channeler's Stone",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}},}
 
    sets.precast.FC.Stun = {}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",
        body="Heka's Kalasiris",
        legs="Doyen pants",feet="Vanya clogs"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Barkarole earring",
        hands="Bagua Mitaines"})
 
--------------------------[Weaponskill sets]------------------------------
 
    sets.precast.WS = {}
 
 
    sets.precast.WS['Flash Nova'] = {}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
--------------------------[Midcast sets]------------------------------
 
    sets.midcast.FastRecast = {sub="Chanter's Shield",
    range="Dunna",
    head={ name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -1%','Pet: INT+5','"Fast Cast"+6','Accuracy+16 Attack+16',}},
    body="Shango Robe",
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+2','"Fast Cast"+6',}},
    legs="Geo. Pants +1",
    feet={ name="Merlinic Crackows", augments={'MND+6','CHR+9','"Refresh"+1','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    neck="Voltsurge Torque",
    waist="Channeler's Stone",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}},
}
 
    sets.midcast.Stun = {}
 
--------------------------[Geomancy sets]------------------------------
 
    sets.midcast.Geomancy = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Azimuth Coat +1",
    hands="Azimuth Gloves +1",
    legs="Azimuth Tights +1",
    feet="Azimuth Gaiters +1",
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}}}
 
    sets.midcast.Geomancy.Indi = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Azimuth Coat +1",
    hands="Azimuth Gloves +1",
    legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
    feet="Azimuth Gaiters +1",
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}}}
 
--------------------------[Some White Magic sets]------------------------------
 
    sets.midcast.Cure = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Heka's Kalasiris",
    hands="Telchine gloves",
    legs="Geo. Pants +1",
    feet={ name="Medium's Sabots", augments={'MP+35','MND+4','"Conserve MP"+3',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Sirona's Ring",
    back="Solemnity Cape",}
     
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast['Enhancing Magic'] = {
        main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8',}},
    body={ name="Telchine Chas.", augments={'"Cure" potency +5%','Enh. Mag. eff. dur. +4',}},
    hands={ name="Telchine Gloves", augments={'"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +7',}},
    legs={ name=gear.tellegs_enh, augments={'Enh. Mag. eff. dur. +8',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Sirona's Ring",
    back="Solemnity Cape",}
     
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",sub="Genmei shield"})
     
    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
        {})
 
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric coif"})
 
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        {head="Amalric coif", waist=""})   
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
 
--------------------------[Black Magic sets & Magic burst set]------------------------------
 
    sets.midcast['Dark Magic'] = {main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
    sub="Chanter's Shield",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands="Azimuth Gloves +1",
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Excelsis Ring",
    right_ring="Sangoma Ring",
    back="Izdubar Mantle",}
 
    sets.midcast['Drain'] = {main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
    sub="Chanter's Shield",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands="Azimuth Gloves +1",
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Excelsis Ring",
    right_ring="Sangoma Ring",
    back="Izdubar Mantle",}
 
    sets.midcast['Aspir'] = sets.midcast['Drain']
 
    sets.midcast['Enfeebling Magic'] = {main={ name="Grioavolr", augments={'Magic burst mdg.+3%','INT+17','Mag. Acc.+19','"Mag.Atk.Bns."+20','Magic Damage +6',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands="Azimuth Gloves +1",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Medium's Sabots", augments={'MP+35','MND+4','"Conserve MP"+3',}},
    neck="Imbodla Necklace",
    waist="Luminary Sash",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Globidonta Ring",
    right_ring="Sangoma Ring",
    back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Pet: "Regen"+10',}},
}

    sets.midcast['Elemental Magic'] = {main={ name="Grioavolr", augments={'Magic burst mdg.+3%','INT+17','Mag. Acc.+19','"Mag.Atk.Bns."+20','Magic Damage +6',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Refoccilation Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}
 
    sets.midcast['Elemental Magic'].Resistant = {main={ name="Grioavolr", augments={'Magic burst mdg.+3%','INT+17','Mag. Acc.+19','"Mag.Atk.Bns."+20','Magic Damage +6',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}
 
    sets.midcast.Impact = {}
 
    sets.magic_burst = {main={ name="Grioavolr", augments={'Magic burst mdg.+3%','INT+17','Mag. Acc.+19','"Mag.Atk.Bns."+20','Magic Damage +6',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+24','Magic burst mdg.+10%','INT+5',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20','Magic burst mdg.+11%','CHR+10','"Mag.Atk.Bns."+11',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Mizu. Kubikazari",
    waist="Refoccilation Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}

	sets.midcast['Elemental Magic'].MagicBurst =sets.magic_burst		
--------------------------[Idle sets]------------------------------
 
    sets.resting = {}
 
    sets.idle = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    legs="Assid. Pants +1",
    feet="Geo. Sandals +1",
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back="Solemnity Cape",}
 
    sets.idle.PDT = {main="Mafic Cudgel",
    sub="Genmei Shield",
    range="Dunna",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body="Vrikodara Jupon",
    hands="Geo. Mitaines +1",
    legs="Assid. Pants +1",
    feet="Azimuth Gaiters +1",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Solemnity Cape",
}
 
    sets.idle.Town = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Befouled Crown",
    body="Councilor's Garb",
    hands="Geo. Mitaines +1",
    legs="Assid. Pants +1",
    feet="Crier's Gaiters",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Rahab Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}},
}
 
    sets.idle.Weak = {}
 
-------------------------[When Luopan is present]-----------------------------------    
 
    sets.idle.Pet = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    hands="Geo. Mitaines +1",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
    neck="Twilight Torque",
    waist="Isa Belt",
    left_ear="Handler's Earring",
    right_ear="Handler's Earring +1",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back="Nantosuelta's Cape"}
 
    sets.idle.PDT.Pet = set_combine(sets.idle.Pet, 
        {body="Vrikodara jupon",
        legs="Psycloth lappas"})
 
--------------------------[When Indicolure spell is active]------------------------------    
 
    sets.idle.Indi = set_combine(sets.idle, {neck="Loricate torque +1"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {feet="Azimuth gaiters +1"})
 
--------------------------[Defense Sets]------------------------------    
 
    sets.defense.PDT = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Befouled Crown",
    body="Vrikodara jupon",
    hands="Geo. Mitaines +1",
    legs="Assid. Pants +1",
    feet="Azimuth gaiters +1",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Rahab Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}},
}
 
    sets.defense.MDT = {}
 
--------------------------[Misc. sets]------------------------------    
 
    sets.Kiting = {feet=""}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
--------------------------[Engaged set(s)]------------------------------    
 
    sets.engaged = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head={ name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -1%','Pet: INT+5','"Fast Cast"+6','Accuracy+16 Attack+16',}},
    body="Onca Suit",
    neck="Loricate Torque +1",
    waist="Eschan Stone",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Excelsis Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -2%',}},
}
 
end
 
--------------------------[Job functions]------------------------------    
 
--------------------------[Standard events]------------------------------    
 
function job_precast(spell, action, spellMap, eventArgs)
if spell.english == "Impact" then
                                equip(set_combine(sets.precast.FC,{head=empty,body="Twilight Cloak"}))
                    end
end
function job_post_midcast(spell, action, spellMap, eventArts)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')

        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    if spell.skill == 'Elemental Magic' then
            ---state.MagicBurst:reset()
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
 
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range','ammo')
        else
            enable('main','sub','range','ammo')
        end
    end
end
 
--------------------------[Maps Indi- spells and enfeebles]------------------------------    
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end
 
-----------------------------------------------------------------------------------   
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------    
 
function select_default_macro_book()
    set_macro_page(3, 4)
end
 
--------------------------[Custom Buff timers]------------------------------    

 
