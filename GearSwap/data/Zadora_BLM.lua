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
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', "Death")
  
    MagicBurstIndex = 0
    state.MagicBurst = M(false, 'Magic Burst')
    state.TreasureHunter = M(false, 'TH')
    state.ConsMP = M(false, 'Conserve MP')
    state.DeatCast = M(false, 'Death Mode')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    
    -- Additional local binds
 
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @` gs c toggle DeatCast')
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
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -1%','System: 1 ID: 1796 Val: 4','"Fast Cast"+6','Accuracy+16 Attack+16',}},
    body="Shango Robe",
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Channeler's Stone",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}


    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'Pet: Phys. dmg. taken -1%','System: 1 ID: 1796 Val: 4','"Fast Cast"+6','Accuracy+16 Attack+16',}},
    body="Shango Robe",
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Channeler's Stone",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",}

    sets.midcast.Cure = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Sapience Orb",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Heka's Kalasiris",
    hands="Bokwus Gloves",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Medium's Sabots", augments={'MP+35','MND+4','"Conserve MP"+3',}},
    neck="Incanter's Torque",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Sirona's Ring",
    right_ring="Prolix Ring",
    back="Solemnity Cape",}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Sapience Orb",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8',}},
    body={ name="Telchine Chas.", augments={'"Cure" potency +5%','Enh. Mag. eff. dur. +4',}},
    hands={ name="Telchine Gloves", augments={'"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +7',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
    neck="Incanter's Torque",
    waist="Siegel Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",}
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],
        {head="Amalric coif", waist="Gishdubar Sash"})


    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        {head="Amalric coif",waist="Siegel Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
        {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Medium's Sabots", augments={'MP+35','MND+4','"Conserve MP"+3',}},
    neck="Imbodla Necklace",
    waist="Luminary Sash",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Globidonta Ring",
    right_ring="Sangoma Ring",
    back={ name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +2','"Mag.Atk.Bns."+5',}},}
        
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { }) 

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Excelsis Ring",
    right_ring="Sangoma Ring",
    back={ name="Bane Cape", augments={'Elem. magic skill +8','Dark magic skill +10','"Mag.Atk.Bns."+1',}},}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{ring1="Evanescence Ring",
        waist="Fucho-no-obi"})
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {}

    --Death sets---
    sets.precast.JA['Alacrity'] = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Etiolation Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Sangoma Ring",
    back={ name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +2','"Mag.Atk.Bns."+5',}},
}


    sets.precast.FC['Death'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Ghastly Tathlum",
    head="Pixie Hairpin +1",
    body="Shango Robe",
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Refoccilation Stone",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Sangoma Ring",
    back={ name="Bane Cape", augments={'Elem. magic skill +8','Dark magic skill +10','"Mag.Atk.Bns."+1',}},}
    
    sets.midcast['Death'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Strobilus",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20','Magic burst mdg.+11%','CHR+10','"Mag.Atk.Bns."+11',}},
    feet={ name="Merlinic Crackows", augments={'Magic burst mdg.+11%','"Mag.Atk.Bns."+8',}},
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Etiolation Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Mujin Band",
    back="Twilight Cape",}

	--death specific MB set
    sets.midcast['Death'].MagicBurst = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Strobilus",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20','Magic burst mdg.+11%','CHR+10','"Mag.Atk.Bns."+11',}},
    feet={ name="Merlinic Crackows", augments={'Magic burst mdg.+11%','"Mag.Atk.Bns."+8',}},
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Etiolation Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Mujin Band",
    back="Twilight Cape",}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Drain" and "Aspir" potency +11','MND+2','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
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

	
    sets.midcast['Elemental Magic'].Resistant = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Imbodla Necklace",
    waist="Channeler's Stone",
    left_ear="Barkaro. Earring",
    right_ear="Strophadic Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +2','"Mag.Atk.Bns."+5',}},}


    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
        {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Drain" and "Aspir" potency +11','MND+2','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
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
    back="Toro Cape",})
	
		
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','INT+9','"Mag.Atk.Bns."+15',}},
    neck="Imbodla Necklace",
    waist="Channeler's Stone",
    left_ear="Barkaro. Earring",
    right_ear="Strophadic Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +2','"Mag.Atk.Bns."+5',}},}

    sets.midcast.Impact = {}





    sets.magic_burst = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Phys. dmg. taken -2%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+9%','MND+7','Mag. Acc.+2','"Mag.Atk.Bns."+14',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20','Magic burst mdg.+11%','CHR+10','"Mag.Atk.Bns."+11',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst mdg.+9%','Mag. Acc.+13',}},
    neck="Mizu. Kubikazari",
    waist="Refoccilation Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}
    
     
	 sets.Obi = {back="Twilight Cape",waist='Hachirin-no-Obi'}
       
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Assid. Pants +1",
    feet="Crier's Gaiters",
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Shiva Ring +1",
    back="Solemnity Cape",}

	    sets.DeatCastIdle = {
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Niobid Strap",
    ammo="Ghastly Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Fucho-no-Obi",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Sangoma Ring",
    back={ name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +2','"Mag.Atk.Bns."+5',}},
}
	
    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {}
    
    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {}
    
    -- Town gear.
    sets.idle.Town = set_combine(sets.idle,{feet="Herald's gaiters"})
        
    -- Defense sets
    
    sets.TreasureHunter = {waist="Chaac Belt"}
    sets.ConsMP = {body="Spaekona's coat +1"}

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
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
	equipSet = {}
                        if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' or spell.type == 'BardSong' then
                                equipSet = sets.midcast
                            if state.Death.value then
                                equipSet = equipSet['Death']
                                eventArgs.handled = true
                            end

                        elseif string.find(spell.english,'Cure') then
                                equipSet = equipSet.Cure
                        elseif string.find(spell.english,'Cura') then
                                equipSet = equipSet.Curaga
                        elseif string.find(spell.english,'Banish') then
                                equipSet = set_combine(equipSet.MndEnfeebles)
                        elseif spell.english == "Stoneskin" then
						  equipSet = equipSet.Stoneskin
                                if buffactive.Stoneskin then
                                        send_command('cancel stoneskin')
							end
                        elseif spell.english == "Sneak" then
                                if spell.target.name == player.name and buffactive['Sneak'] then
                                        send_command('cancel sneak')
                                end
                                equipSet = equipSet.Haste
                        elseif string.find(spell.english,'Utsusemi') then
                                if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                                        send_command('@wait 1.7;cancel Copy Image*')
                                end
                                equipSet = equipSet.Haste
                        elseif spell.english == 'Monomi: Ichi' then
                                if buffactive['Sneak'] then
                                        send_command('cancel sneak')
                                end
                                equipSet = equipSet.Haste
                    
                        else
                        if equipSet[spell.english] then
                                equipSet = equipSet[spell.english]
                        end
                        if equipSet[spell.skill] then
                                equipSet = equipSet[spell.skill]
                        end
                        if equipSet[spell.type] then
                                equipSet = equipSet[spell.type]
                        end
                        
                        if string.find(spell.english,'Cure')  and (world.weather_element == spell.element) or  (world.day_element == spell.element) then
                                equipSet = set_combine(equipSet,sets.Obi)
                        end    
                        if ((spell.english == 'Drain') or (spell.english == 'Aspir')) and ((world.day_element == spell.element) or (world.weather_element == spell.element)) then
                                equipSet = set_combine(equipSet,sets.Obi)
                        end  
			end
    if equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    equip(equipSet)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
	   if spell.skill == 'Elemental Magic' then
			if spell.element == world.day_element or spell.element == world.weather_element then
			equip(equipSet, sets.Obi)
			if string.find(spell.english,'helix') then
							equip(sets.midcast.Helix)
			end
		end
	   end
	if spell.skill == 'Elemental Magic' and state.ConsMP.value then
		equip(sets.ConsMP)
	end
    --Death specific MB rule
    if spell.english == 'Death' and state.Death.value and state.MagicBurst.value then
        equip(set_combine(sets.midcast['Death'],sets.MB_death))
    end

	if not spell.interrupted then
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

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        end
    elseif spell.skill == 'Enhancing Magic' then
            adjust_timers(spell, spellMap)
	end
end


-- Function to create custom buff-remaining timers with the Timers plugin,

-- keeping only the actual valid songs rather than spamming the default

-- buff remaining timers.

function adjust_timers(spell, spellMap)
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    local dur = calculate_duration(spell, spellName, spellMap)
         custom_timers[spell.name] = nil
         send_command('timers delete "'..spell.name..' ['..spell.target.name..']"')
         custom_timers[spell.name] = current_time + dur
         send_command('@wait 1;timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
end




-- Function to calculate the duration of a song based on the equipment used to cast it.

-- Called from adjust_timers(), which is only called on aftercast().

function calculate_duration(spell, spellName, spellMap)

    local mult = 1.00

	if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.09 end
	if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.09 end
	if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.09 end
	if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.09 end
	if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.08 end
	
	if player.equipment.Feet == 'Estq. Houseaux +2' then mult = mult + 0.20 end
	if player.equipment.Legs == 'Futhark Trousers' then mult = mult + 0.10 end
	if player.equipment.Legs == 'Futhark Trousers +1' then mult = mult + 0.20 end
	if player.equipment.Hands == 'Atrophy Gloves' then mult = mult + 0.15 end
	if player.equipment.Hands == 'Atrophy Gloves +1' then mult = mult + 0.16 end
	if player.equipment.Back == 'Estoqueur\'s Cape' then mult = mult + 0.10 end
	if player.equipment.Hands == 'Dynasty Mitts' then mult = mult + 0.05 end
	if player.equipment.Body == 'Shabti Cuirass' then mult = mult + 0.09 end
	if player.equipment.Body == 'Shabti Cuirass +1' then mult = mult + 0.10 end
	if player.equipment.Feet == 'Leth. Houseaux' then mult = mult + 0.25 end
	if player.equipment.Feet == 'Leth. Houseaux +1' then mult = mult + 0.30 end


	local base = 0

	if spell.name == 'Haste' then base = base + 180 end
	if spell.name == 'Stoneskin' then base = base + 300 end
	if string.find(spell.name,'Bar') then base = base + 480 end
	if spell.name == 'Blink' then base = base + 300 end
	if spell.name == 'Aquaveil' then base = base + 600 end
	if string.find(spell.name,'storm') then base = base + 180 end
	if spell.name == 'Auspice' then base = base + 180 end
	if string.find(spell.name,'Boost') then base = base + 300 end
	if spell.name == 'Phalanx' then base = base + 180 end
	if string.find(spell.name,'Protect') then base = base + 1800 end
	if string.find(spell.name,'Shell') then base = base + 1800 end
	if string.find(spell.name,'Refresh') then base = base + 150 end
	if string.find(spell.name,'Regen') then base = base + 60 end
	if spell.name == 'Adloquium' then base = base + 180 end
	if string.find(spell.name,'Animus') then base = base + 180 end
	if spell.name == 'Crusade' then base = base + 300 end
	if spell.name == 'Embrava' then base = base + 90 end
	if string.find(spell.name,'En') then base = base + 180 end
	if string.find(spell.name,'Flurry') then base = base + 180 end
	if spell.name == 'Foil' then base = base + 30 end
	if string.find(spell.name,'Gain') then base = base + 180 end
	if spell.name == 'Reprisal' then base = base + 60 end
	if string.find(spell.name,'Temper') then base = base + 180 end
	if string.find(spell.name,'Spikes') then base = base + 180 end

	if buffactive['Perpetuance'] then
		if player.equipment.Hands == 'Arbatel Bracers' then
			mult = mult*2.5
		elseif player.equipment.Hands == 'Arbatel Bracers +1' then
			mult = mult*2.55
		else
			mult = mult*2
		end
	end

	if buffactive['Composure'] then
		if spell.target.type == 'SELF' then
			mult = mult*3
		else
			mult = mult
		end
	end
			
			

    local totalDuration = math.floor(mult*base)

	--print(totalDuration)


    return totalDuration

end
-- Function to reset timers.

function reset_timers()

    for i,v in pairs(custom_timers) do

        send_command('timers delete "'..i..'"')

    end

    custom_timers = {}

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
        idleSet = set_combine(idleSet, sets.midcast['Death'])
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
    set_macro_page(1,1)
end

