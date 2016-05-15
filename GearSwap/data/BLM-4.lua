-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function job_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Mid', 'Resistant', 'Proc', 'HighMP')
    state.IdleMode:options('Normal', 'PDT', 'HighMP')
  
  	MagicBurstIndex = 0
    state.MagicBurst = M(false, 'Magic Burst')
	state.TreasureHunter = M(false, 'TH')
	state.ConsMP = M(false, 'Conserve MP')
    state.Death = M(false, 'Death Mode')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    
    -- Additional local binds
    send_command('bind ^` input //gs disable back;input /equip back "Mecistopins Mantle"')
    send_command('bind @` gs c toggle MagicBurst')

	custom_timers = {}

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --Precast Sets
    sets.precast.FC = { main=gear.death_staff,sub="Niobid strap",ammo="Sapience Orb",
        head="Amalric Coif", neck="Orunmila's torque", ear1="Etiolation earring", ear2="Loquacious earring",
        body="Zendik Robe", hands="Otomi gloves",ring1="Mephitas's ring +1",ring2="Mephitas's ring",
        back="Bane Cape", waist="Witful Belt", legs="Psycloth lappas", feet="Amalric Nails" }

    sets.precast.FC.HighMP = { main=gear.death_staff,sub="Niobid strap",ammo="Psilomene",
        head="Amalric Coif", neck="Orunmila's torque", ear1="Etiolation earring", ear2="Loquacious earring",
        body="Zendik Robe", hands="Otomi gloves",ring1="Mephitas's ring +1",ring2="Mephitas's ring",
        back="Bane Cape", waist="Shinjutsu-no-obi +1", legs="Psycloth lappas", feet="Amalric Nails" }
     
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})

    sets.precast.WS['Myrkr'] = {ammo="Psilomene",
        head="Nahtirah Hat",neck="Nodens gorget",ear1="loquacious earring", ear2="Moonshade earring",
        body="Amalric doublet", hands="Otomi gloves", ring1="Sangoma ring", ring2="Lebeche Ring",
        back="Bane cape", waist="Fucho-no-obi", legs="Amalric slops", feet="Medium's sabots"}

    ---Midcast Sets
    --BLM Midcast sets
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.WhateverHead,
        neck="Mizu. Kubikazari",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Spae. Coat +1",
        hands="Amalric Gages",
        ring1="Mujin Band",
        ring2="Fenrir Ring +1",
        back="Seshaw Cape",
        waist="Eschan Stone",
        legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+27','Magic burst mdg.+8%','CHR+10',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+9%',}}}

    sets.midcast['Elemental Magic'].Mid = set_combine(sets.midcast['Elemental Magic'], 
        {ammo="Pemphredo tathlum",
        neck="Sanctity necklace",
        waist="Eschan Stone"})
    
    sets.midcast['Elemental Magic'].Resistant = {
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+8 "Mag.Atk.Bns."+8','Magic burst mdg.+9%','MND+10','"Mag.Atk.Bns."+11',}},
        neck="Mizu. Kubikazari",
        ear1="Friomisi Earring",
        ear2="Gwati Earring",
        body="Spae. Coat +1",
        hands="Amalric Gages",
        ring1="Mephitas's Ring +1",
        ring2="Fenrir Ring +1",
        back="Seshaw Cape",
        waist="Eschan Stone",
        legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+27','Magic burst mdg.+8%','CHR+10',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+9%',}}}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
        {ammo="Pemphredo tathlum",
        back="Toro Cape"})
    sets.midcast['Elemental Magic'].HighTierNuke.Mid = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, 
        {neck="Sanctity Necklace",
        waist="Eschan Stone"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke.Mid, 
        {
        neck="Incanter's Torque",ear2="Gwati earring",
        back="Bane Cape"})
    --Dark magic and etc midcast sets
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genbu's shield",ammo="Pemphredo tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter earring +1",
        body="Shango Robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Archon Ring",
        back="Bane Cape",waist="Eschan stone",legs="Psycloth lappas",feet=gear.DA_feet}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{ring1="Evanescence Ring",
        waist="Fucho-no-obi"})
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Aspir.HighMP = { main=gear.death_staff,sub="Niobid strap",ammo="Psilomene",
        head="Pixie hairpin +1", neck="Mizu. Kubikazari", ear1="Barkarole earring", ear2="Static Earring",
        body=gear.MB_body, hands="Amalric gages",ring1="Mujin Band",ring2="Archon Ring",
        back="Taranus's Cape", waist="Hachirin-no-obi", legs="Amalric slops", feet=gear.MB_feet }

    sets.midcast.Stun = {main="Lathi",sub="Arbuda Grip",ammo="Pemphredo tathlum",
        head="Amalric coif",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Zendik Robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Prolix Ring",
        back="Perimede Cape",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}

    sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Amalric coif",neck="Incanter's torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body=gear.merlbody_nuke,hands="Amalric gages",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
        back="Aurist's cape +1",waist="Luminary sash",legs="Psycloth lappas",feet="Medium's sabots"}
        
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { }) 

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    --WHM Midcast sets
    sets.midcast.Cure = {
        head="Telchine cap",neck="Incanter's Torque",ear1="Roundel earring",ear2="Beatific Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Solemnity cape",waist="Bishop's sash",legs="Telchine braconi",feet="Vanya clogs"}
 
    sets.midcast['Enhancing Magic'] = {
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+8 "Mag.Atk.Bns."+8','Magic burst mdg.+9%','MND+10','"Mag.Atk.Bns."+11',}},
        neck="Dualism Collar +1",
        ear1="Etiolation earring",
        ear2="Influx earring",
        body="Amalric Doublet",
        hands="Otomi Gloves",
        ring1="Mujin Band",
        ring2="Defending Ring",
        back="Solemnity Cape",
        waist="Gishdubar Sash",
        legs="Assiduity pants +1",
        feet="Herald's gaiters"}

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],
        {head="Amalric coif",waist="Gishdubar sash"})

    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
        {ammo="Sapience orb",
        neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
        ring1="Prolix ring",
        back="Swith cape +1",waist="Ninurta's sash"})

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
        {feet=gear.merllegs_dt})

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        {head="Amalric coif",waist="Emphatikos Rope",legs="Shedir seraweels"})

    sets.midcast.Stoneskin = {
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+8 "Mag.Atk.Bns."+8','Magic burst mdg.+9%','MND+10','"Mag.Atk.Bns."+11',}},
        neck="Nodens Gorget",
        ear1="Etiolation earring",
        ear2="Influx Earring",
        body="Amalric Doublet",
        hands="Otomi Gloves",
        ring1="Mephitas's Ring +1",
        ring2="Defending Ring",
        back="Solemnity Cape",
        waist="Siegal Sash",
        legs="Doyan Pants",
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+9%',}}}


    --Death sets
    sets.precast.FC['Death'] = { main=gear.death_staff,sub="Niobid strap",ammo="Psilomene",
        head="Amalric Coif", neck="Orunmila's torque", ear1="Etiolation earring", ear2="Loquacious earring",
        body="Zendik Robe", hands="Otomi gloves",ring1="Mephitas's ring +1",ring2="Mephitas's ring",
        back="Bane Cape", waist="Shinjutsu-no-obi +1", legs="Psycloth lappas", feet="Amalric Nails" }
     
    sets.midcast['Death'] = { main=gear.death_staff,sub="Niobid strap",ammo="Psilomene",
        head="Pixie hairpin +1", neck="Mizu. Kubikazari", ear1="Barkarole earring", ear2="Static Earring",
        body=gear.MB_body, hands="Amalric gages",ring1="Mujin Band",ring2="Archon Ring",
        back="Taranus's Cape", waist="Hachirin-no-obi", legs="Amalric slops", feet=gear.MB_feet }
        --death specific MB set
    sets.MB_death = { main=gear.death_staff,sub="Niobid strap",ammo="Psilomene",
        head="Pixie hairpin +1", neck="Mizu. Kubikazari", ear1="Barkarole earring", ear2="Static Earring",
        body=gear.MB_body, hands="Amalric gages",ring1="Mujin Band",ring2="Archon Ring",
        back="Taranus's Cape", waist="Hachirin-no-obi", legs="Amalric slops", feet=gear.MB_feet }

    ------Utility sets
    sets.magic_burst = {neck="Mizu. Kubikazari",ear2="Static Earring",
        body=gear.MB_body, hands="Amalric gages", ring1="Mujin band",
        back="Taranus's cape",feet=gear.MB_feet }

    sets.idle = {}

end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Impact" then
        equip({head=empty,body="Twilight Cloak"})
	end
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Hachirin-no-obi"
    elseif spell.skill == 'Elemental Magic' then
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
	if state.Death.value then
		equip(sets.precast.FC['Death'])
        eventArgs.handled = true
	end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if state.Death.value then
        equip(sets.midcast['Death'])
        eventArgs.handled = true
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BlackMagic' and state.MagicBurst.value then
        if spell.english == 'Death' and state.Death.value then
            equip(set_combine(sets.midcast['Death'],sets.MB_death))
        else
            equip(sets.magic_burst)
        end
    end
	if spell.element == world.day_element or spell.element == world.weather_element then
		if string.find(spell.english,'helix') then
			equip(sets.midcast.Helix)
        else 
            equip(sets.Obi)
		end
    end
	if spell.skill == 'Elemental Magic' and state.ConsMP.value then
		equip(sets.ConsMP)
	end
    --Death specific MB rule

end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        end
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
            send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Break" then -- Break Countdown --
            send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Paralyze" then -- Paralyze Countdown --
            send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Slow" then -- Slow Countdown --
            send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')                                
        end
    end
end




-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
	if buff == "Commitment" and not gain then
		equip({ring2="Capacity Ring"})
		if player.equipment.right_ring == "Capacity Ring" then
			disable("ring2")
			send_command('@wait 9; input /item "Capacity Ring" <me>;')
		else
			enable("ring2")
		end
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Death.value then
        idleSet = set_combine(idleSet, sets.precast.FC['Death'])
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

function job_status_change(newStatus, oldStatus, eventArgs)
end
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end