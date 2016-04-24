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


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Crit')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
    state.MagicBurst = M(false, 'Magic Burst')


	organizer_items = {
		mainkt={name="Kanaria", augments={'STR+3','Accuracy+15','Attack+15','DMG:+18',}},
		subkt="Achiuchikapu",
		selftools="Shikanofuda",
		debufftools="Chonofuda",
		nuketools="Inoshishinofuda",
		cpring="Capacity Ring"
		
		}
		
    select_default_macro_book()

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
		back="Yokaze Mantle",waist="Chaac Belt"
	}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience orb",
		head=gear.fc_thead,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		waist="Ninurta's sash",legs=gear.fc_tlegs,feet=gear.hercfeet_fc}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Snapshot for ranged
    sets.precast.RA = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Yetshila",
        head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Telos earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands="Adhemar wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha tights",feet=gear.tp_tfeet}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, 
		{ammo="Amar Cluster",
		head=gear.adhemarhead_melee,
		body="adhemar jacket",
			back="Grounded Mantle +1",legs="Hattori hakama +1"}) 

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Ifrit's ring +1",ring2="Ifrit's ring +1",
		hands="Kobo Kote",
		back="Rancorous Mantle"})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS,
        {ear1="Brutal Earring",ear2="Moonshade Earring",
		hands="Kobo Kote",ring1="Ifrit's ring +1",ring2="Ifrit's ring +1",
		back="Rancorous Mantle"})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
        {head=gear.adhemarhead_melee,
		body="Adhemar jacket",hands="Kobo Kote",
		back="Rancorous Mantle",legs="Samnuha tights"})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'],
        {head="Ryuo somen",
		body="Reiki Osode",hands="Floral gauntlets"})


    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {})


    sets.precast.WS['Aeolian Edge'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Sapience Orb",
        head=gear.herchead_pup,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Grounded mantle +1",waist="Ninurta's sash",legs=gear.fc_tlegs,feet="Amm greaves"}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back="Andartia's Mantle",feet="Hattori Kyahan"})

	sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {neck="Incanter's torque"})	

    sets.midcast.ElementalNinjutsu = {ammo="Pemphredo tathlum",
        head=gear.fc_thead,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Gwati Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Hachiya Kyahan"}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, 
		{ear1="Enchanter earring +1",
		ring2="Weatherspoon Ring",
        back="Yokaze Mantle"})

    sets.midcast.NinjutsuDebuff = set_combine(sets.midcast.ElementalNinjutsu,{
        neck="Incanter's Torque",ear1="Enchanter earring +1",
        ring1="Weatherspoon Ring",ring2="Sangoma Ring",
        waist="Eschan Stone",feet="Hachiya Kyahan"})

    sets.midcast.RA = {}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets
    sets.idle = {ammo="Amar cluster",
        head="Skormoth Mask",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Reiki osode",hands="Macabre gauntlets",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="Samnuha tights",feet="Amm greaves"}

    sets.idle.Town = {ammo="Yetshila",
        head="Ryuo somen",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Genmei Earring",
        body="Reiki osode",hands="Leyline gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Yokaze Mantle",waist="Flume Belt +1",legs="Samnuha tights",feet="Hachiya Kyahan"}
    
    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.Evasion = {}
	
    sets.defense.PDT = {ammo="Amar Cluster",
        head="Genmei kabuto",neck="Loricate torque +1",ear1="Genmei Earring",ear2="Impregnable Earring",
        body="Reiki osode",hands="Macabre gauntlets",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume belt +1",legs="Samnuha tights",feet="Amm greaves"}

    sets.defense.MDT = {ammo="Amar Cluster",
        head="Skormoth mask",neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Onca suit",hands=empty,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume belt +1",legs=empty,feet=empty}


    sets.Kiting = {ring2="Hachiya Kyahan"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Reiki Yotai",legs="Samnuha tights",feet=gear.tp_tfeet}
    sets.engaged.Acc = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Reiki yotai",legs="Samnuha tights",feet=gear.tp_tfeet}
    sets.engaged.PDT = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Agitator's collar",ear1="Impregnable earring",ear2="Genmei Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Flume belt +1",legs="Samnuha tights",feet="Amm Greaves"}
    sets.engaged.Acc.PDT = {ammo="Happo Shuriken",
		head="Ryuo somen",neck="Combatant's torque",ear1="impregnable earring",ear2="Genmei Earring",
		body="Reiki osode",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
		back="Agema cape",waist="Reiki yotai",legs="Samnuha tights",feet=gear.hercfeet_melee}

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {ammo="Happo Shuriken",
        head=gear.adhemarhead_melee,neck="Asperity necklace",ear1="Brutal earring",ear2="Telos Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet="Thereoid greaves"}
    sets.engaged.Acc.HighHaste = {ammo="Happo Shuriken",
        head="Ryuo Somen",neck="Combatant's torque",ear1="Brutal earring",ear2="Telos Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Reiki yotai",legs="Samnuha tights",feet=gear.hercfeet_melee}
    sets.engaged.PDT.HighHaste = {ammo="Happo Shuriken",
        head="ryuo somen",neck="agitator's collar",ear1="genmei earring",ear2="impregnable Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending ring",
        back="agema Cape",waist="Flume belt +1",legs="Samnuha tights",feet="Amm Greaves"}
    sets.engaged.Acc.PDT.HighHaste = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Combatant's torque",ear1="Genmei earring",ear2="Telos Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Agema cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Lissome necklace",ear1="Suppanomimi",ear2="Telos earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee}
    sets.engaged.Acc.EmbravaHaste = {ammo="Happo Shuriken",
        head="ryuo somen",neck="Lissome Necklace",ear1="Zennaroi earring",ear2="Telos Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Olseni Belt",legs="Samnuha tights",feet=gear.hercfeet_melee}
    sets.engaged.PDT.EmbravaHaste = {ammo="Happo Shuriken",
        head="ryuo somen",neck="agitator's collar",ear1="Suppanomimi",ear2="Genmei Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Agema cape",waist="Flume belt +1",legs="Samnuha tights",feet="Amm Greaves"}
    sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Combatant's torque",ear1="Suppanomimi",ear2="Telos Earring",
        body="Reiki osode",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Agema cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {ammo="Happo Shuriken",
        head=gear.adhemarhead_melee,neck="Lissome necklace",ear1="Suppanomimi",ear2="Telos earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.hercfeet_acc }
    sets.engaged.Acc.MaxHaste = {ammo="Happo Shuriken",
        head=gear.adhemarhead_melee,neck="Lissome Necklace",ear1="Zennaroi earring",ear2="Telos Earring",
        body="Reiki osode",hands="Adhemar wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Olseni Belt",legs="Samnuha tights",feet=gear.hercfeet_acc }
    sets.engaged.PDT.MaxHaste = {ammo="Happo Shuriken",
        head="ryuo somen",neck="agitator's collar",ear1="Suppanomimi",ear2="Genmei Earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Agema cape",waist="Flume belt +1",legs="Samnuha tights",feet="Amm Greaves"}
    sets.engaged.Acc.PDT.MaxHaste = {ammo="Happo Shuriken",
        head="Ryuo somen",neck="Combatant's torque",ear1="Suppanomimi",ear2="Telos Earring",
        body="Reiki osode",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Defending Ring",
        back="Agema cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi +1"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {legs="Hattori hakama +1"}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
	--[[if state.buff.Yonin then
		meleeSet = set_combine(meleeSet, sets.buff.Yonin)
	end]]
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste == 1 and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.haste == 2 then
		classes.CustomMeleeGroups:append('MaxHaste')
    end
end




-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 7)
    else
        set_macro_page(1, 7)
    end
end
