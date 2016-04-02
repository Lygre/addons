-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
	include('organizer-lib')

    -- Load and initialize the include file.
    include('Mote-Include.lua')


end

 
function user_setup()
                -- Default macro set/book
        set_macro_page(2, 2)
 
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Mid', 'Acc')
        state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
        state.CastingMode:options('Normal')
        state.IdleMode:options('Normal', 'Refresh', 'Reraise')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')
end
 
 function job_setup()
--    get_combat_weapon()
    gsList = S{'Montante +1'}
    gaxeList = S{'Chango'}
 end
-- Define sets and vars used by this job file.
function init_gear_sets()
                --------------------------------------
        -- Start defining the sets
        --------------------------------------
       
        -- Precast Sets
       
        -- Precast sets to enhance JAs

        sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1"}                    
        sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1"}     
        sets.precast.JA['Warcry'] = {head="Agoge Mask +1"}               
        sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
        sets.buff['Retaliation'] = {hands="Pummeler's Mufflers +1",feet="Boii Calligae +1"}
        sets.buff['Restraint'] = {hands="Boii Mufflers +1"}

        -- Waltz set (chr and vit)
        sets.precast.Waltz = {
                head="Outrider Mask",neck="Temperance Torque",ear1="Skald Breloque",ear2="Roundel Earring",
                body="Twilight Mail",hands="Outrider Mittens",ring2="Omega Ring",
                waist="Aristo Belt",feet="Chocaliztli Boots"}
               
        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {}
 
        -- Fast cast sets for spells
       
        sets.precast.FC = {ear2="Loquacious Earring"}
 
        -- sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
       
       
        -- Weaponskill sets
        -- Default set for any weaponskill that isn't any more specifically defined
        sets.precast.WS = {
}
 
        -- Specific weaponskill sets. Uses the base set if an appropriate WSMod version isn't found.
        sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Twilight Belt",legs="Byakko's Haidate"})
       
        -- Midcast Sets
        sets.midcast.FastRecast = {}
               
        -- Specific spells
        sets.midcast.Utsusemi = {}
               

       
        -- Sets to return to when not performing an action.
       
        -- Resting sets
        sets.resting = set_combine(sets.idle, {head="Twilight Helm"})
       
        -- Idle sets
        sets.idle = {
	ammo="Ginsen",
    head={ name="Yorium Barbuta", augments={'Accuracy+25','"Store TP"+5',}},
    body={ name="Souveran Cuirass", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet="Hermes' Sandals",
    neck="Loricate Torque +1",
    waist="Kentarch Belt",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring",
    right_ring="Pernicious Ring",
    back="Agema Cape",
}               
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
       

       
        -- Defense sets
        sets.defense.PDT = {}
 
        sets.defense.MDT = {}
 
        sets.Kiting = {feet="Hermes' Sandals"}
 
        -- Engaged sets
 
        -- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
        -- sets if more refined versions aren't defined.
        -- If you create a set with both offense and defense modes, the offense mode should be first.
        -- EG: sets.engaged.Dagger.Accuracy.Evasion


------------------Zadora's Additions------------------

		
--------------Weapon Skill Sets--------------------

    sets.precast.WS['Upheaval'] = {
    main="Chango",
    sub="Immolation Grip",
    ammo="Ginsen",
    head={ name="Valorous Mask", augments={'Accuracy+21 Attack+21','Sklchn.dmg.+3%','VIT+1','Accuracy+14','Attack+14',}},
    body={ name="Odyss. Chestplate", augments={'Accuracy+20','Weapon Skill Acc.+8','VIT+15',}},
    hands={ name="Odyssean Gauntlets", augments={'Weapon Skill Acc.+4','VIT+8','Attack+12',}},
    legs={ name="Odyssean Cuisses", augments={'Accuracy+19 Attack+19','"Dbl.Atk."+2','VIT+5','Accuracy+4','Attack+6',}},
    feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}	
    sets.precast.WS['Upheaval'].Mid = {}
    sets.precast.WS['Upheaval'].Acc = {}

    sets.precast.WS["Ukko's Fury"] = {ammo="Seething Bomblet",
    head="Boii Mask +1",
    body={ name="Argosy Hauberk", augments={'STR+10','DEX+10','Attack+15',}},
    hands={ name="Argosy Mufflers", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Argosy Breeches", augments={'STR+10','DEX+10','Attack+15',}},
    feet={ name="Loyalist Sabatons", augments={'STR+10','Attack+15','Phys. dmg. taken -3%','Haste+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Rufescent Ring",
    right_ring="Shukuyu Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}
    sets.precast.WS["Ukko's Fury"].Mid = {}
    sets.precast.WS["Ukko's Fury"].Acc = {}

    sets.precast.WS['Steel Cyclone'] = {ammo="Seething Bomblet",
    head="Boii Mask +1",
    body={ name="Argosy Hauberk", augments={'STR+10','DEX+10','Attack+15',}},
    hands={ name="Argosy Mufflers", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Argosy Breeches", augments={'STR+10','DEX+10','Attack+15',}},
    feet={ name="Loyalist Sabatons", augments={'STR+10','Attack+15','Phys. dmg. taken -3%','Haste+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Rufescent Ring",
    right_ring="Shukuyu Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}
    sets.precast.WS['Steel Cyclone'].Mid = {}
    sets.precast.WS['Steel Cyclone'].Acc = {}

    sets.precast.WS["King's Justice"] = {ammo="Seething Bomblet",
    head="Boii Mask +1",
    body={ name="Argosy Hauberk", augments={'STR+10','DEX+10','Attack+15',}},
    hands={ name="Argosy Mufflers", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Argosy Breeches", augments={'STR+10','DEX+10','Attack+15',}},
    feet={ name="Loyalist Sabatons", augments={'STR+10','Attack+15','Phys. dmg. taken -3%','Haste+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Rufescent Ring",
    right_ring="Shukuyu Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}
    sets.precast.WS["King's Justice"].Mid = {}
    sets.precast.WS["King's Justice"].Acc = {}



---------------Great Sword------------------------		
    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet",
    head={ name="Argosy Celata", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Argosy Hauberk", augments={'STR+10','DEX+10','Attack+15',}},
    hands={ name="Argosy Mufflers", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Argosy Breeches", augments={'STR+10','DEX+10','Attack+15',}},
    feet={ name="Argosy Sollerets", augments={'STR+10','DEX+10','Attack+15',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}	
    sets.precast.WS['Resolution'].Mid =	{}
    sets.precast.WS['Resolution'].Acc = {}
		
        -- Normal melee group
    sets.engaged = {ammo="Ginsen",
    head="Boii Mask +1",
    body={ name="Valorous Mail", augments={'Accuracy+26','"Store TP"+7','DEX+4',}},
    hands={ name="Valorous Mitts", augments={'Attack+17','"Dbl.Atk."+4','DEX+7','Accuracy+10',}},
    legs={ name="Argosy Breeches", augments={'STR+10','DEX+10','Attack+15',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+25','"Store TP"+6',}},
    neck="Asperity Necklace",
    waist="Dynamic Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Mauler's Mantle", augments={'DEX+4','STR+1','Accuracy+2','Crit. hit damage +2%',}},
}
    sets.engaged.Mid = {}
    sets.engaged.Acc = {}

    sets.engaged.GreatAxe = set_combine(sets.engaged,
        {})
    sets.engaged.GreatAxe.Mid = set_combine(sets.engaged.Mid,
        {})
    sets.engaged.GreatAxe.Acc = set_combine(sets.engaged.Acc,
        {})

    sets.engaged.GreatSword = set_combine(sets.engaged,
        {})
    sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid,
        {})
    sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc,
        {})



end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
 function job_precast(spell, action, spellMap, eventArgs)
     custom_aftermath_timers_precast(spell)
 end

 function job_aftercast(spell, action, spellMap, eventArgs)
    custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
 end

 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

--    get_combat_weapon()
    display_current_job_state(eventArgs)
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
        local defenseString = ''
        if state.Defense.Active then
                local defMode = state.Defense.PhysicalMode
                if state.Defense.Type == 'Magical' then
                        defMode = state.Defense.MagicalMode
                end
 
                defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
        end
 
        add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
                'Kiting: '..on_off_names[state.Kiting])
 
 
        eventArgs.handled = true
end

--function get_combat_weapon()
--    if gsList:contains(player.equipment.main) then
--        state.CombatWeapon:set("GreatSword")
--    elseif gaxeList:contains(player.equipment.main) then
--        state.CombatWeapon:set("GreatAxe")
--    else 
--        state.CombatWeapon:reset()
--    end
--end
--Deal with buff state variable eventually!!!!!!!!!!!!!!
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    -- body
end
--Custom Aftermath timer function called from job_aftercast
function custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local am_ws = "Upheaval"
        info.aftermath.weaponskill = am_ws
        info.aftermath.duration = 0
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == am_ws and player.equipment.main == 'Chango' then
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            if info.aftermath.level == 1 then
                info.aftermath.duration = 180
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 180
            else
                info.aftermath.duration = 180
            end
        end
    end
end

function custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and 
        info.aftermath and info.aftermath.weaponskill == spell.english and 
        info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end
---Make rule for Custom Day/Night gear!!!!!!!!!!!
--if world.time >= (18*60) or world.time <= (6*60) then
--return sets.NightSet
--else
--return sets.DaySet
--end