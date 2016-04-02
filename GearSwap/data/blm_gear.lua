function job_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Mid', 'Death', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'IdleBurst')
  
  	MagicBurstIndex = 0
    state.MagicBurst = M(false, 'Magic Burst')
	state.TreasureHunter = M(false, 'TH')
	state.ConsMP = M(false, 'Conserve MP')
	
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
------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

    sets.precast.FC = {main="Grioavolr",sub="Vivid Strap",ammo="Sapience orb",
        head=gear.FC_head,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Helios gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet=gear.MB_feet}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})

	sets.precast.FC.Death = {main="Grioavolr",sub="Niobid strap",ammo="Psilomene",
		head=gear.MB_head,neck="Mizukage-no-Kubikazari",ear1="Barkarole earring", ear2="Friomisi earring",
		body="Amalric doublet",hands="Amalric gages",ring1="Mujin band",ring2="Locus ring",
		back="Bane Cape",waist="Eschan Stone", legs="Amalric slops",feet=gear.MB_feet}
		
	sets.precast.FC.Death.Aspir = {ammo="Pemphredo tathlum"}
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {head="Befouled crown",neck="Fotia gorget",
        body="Onca suit",hands=empty,ring1="Rajas Ring",
        back="Solemnity cape",waist="Fotia belt",legs=empty,feet=empty}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Nahtirah Hat",neck="Nodens gorget",ear1="loquacious earring", ear2="Moonshade earring",
		body="Amalric doublet", hands="Otomi gloves", ring1="Sangoma ring", ring2="Lebeche Ring",
		back="Bane cape", waist="Fucho-no-obi", legs="Amalric slops", feet="Medium's sabots"}


    ---- Midcast Sets ----

    sets.midcast.FastRecast = {ammo="Sapience orb",
        head=gear.nuke_head,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Helios gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}

    sets.midcast.Cure = {
        head="Telchine cap",neck="Incanter's Torque",ear1="Roundel earring",ear2="Beatific Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Solemnity cape",waist="Bishop's sash",legs="Telchine braconi",feet="Vanya clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {main="Grioavolr",sub="Fulcio grip",
	head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
      body="Telchine Chasuble",hands="Telchine gloves",
      back="Fi follet cape",waist="Olympus sash",legs="Telchine Braconi",feet="Telchine pigaches"}
    
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif"})

	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
		{ammo="Sapience orb",
		neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
		ring1="Prolix ring",
		back="Swith cape +1",waist="Ninurta's sash"})

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{feet=gear.merllegs_dt})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif",waist="Emphatikos Rope",legs="Shedir seraweels"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
		{waist="Siegel Sash",neck="Nodens gorget",legs="Shedir seraweels"})

    sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Amalric coif",neck="Incanter's torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body=gear.nuke_body,hands="Amalric gages",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
        back="Aurist's cape +1",waist="Luminary sash",legs="Psycloth lappas",feet="Medium's sabots"}
        
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { })	

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. earring",
        body="Shango Robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Archon Ring",
        back="Bane Cape",waist="Luminary sash",legs="Psycloth lappas",feet=gear.DA_feet}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{ring1="Evanescence Ring",
        waist="Fucho-no-obi",legs=gear.DA_legs})
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Lathi",sub="Arbuda Grip",ammo="Pemphredo tathlum",
        head="Amalric coif",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Niobid strap",ammo="Dosis tathlum",
        head=gear.nuke_head,neck="Saevus pendant +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=gear.nuke_body,hands="Amalric gages",ring1="Shiva ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Refoccilation Stone",legs=gear.nuke_legs,feet=gear.MB_feet}

	sets.midcast['Elemental Magic'].Mid = set_combine(sets.midcast['Elemental Magic'], 
		{ammo="Pemphredo tathlum",
		neck="Sanctity necklace",
		waist="Eschan Stone"})
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'].Mid, 
		{
		neck="Incanter's torque",ear2="Gwati earring",
		})


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

    sets.midcast.Impact = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo tathlum",
        head=empty,neck="Sanctity necklace",ear1="Gwati Earring",ear2="Barkarole earring",
        body="Twilight Cloak",hands="Amalric Gages",ring1="Weatherspoon Ring",ring2="Archon Ring",
        back="Bane cape",waist="Eschan Stone",legs=gear.nuke_legs,feet=gear.nuke_feet}



    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate torque +1",ear1="Gwati earring",ear2="Loquacious Earring",
        body="Telchine Chasuble",hands="Serpentes Cuffs",ring1="Lebeche Ring",ring2="Paguroidea Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assiduity pants +1",feet="Vanya clogs"}

	sets.magic_burst = {
		head=gear.MB_head,neck="Mizukage-no-Kubikazari",
		hands="Amalric gages", ring2="Mujin Band",
		back="Seshaw cape",legs=gear.MB_legs,feet=gear.MB_feet}

     sets.Obi = {back="Twilight Cape",waist='Hachirin-no-Obi'}
       
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Bolelabunga", sub="Genbu's shield",ammo="Impatiens",
        head="Befouled crown",neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Amalric doublet",hands="Serpentes cuffs",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Serpentes Sabots"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Bolelabunga", sub="Genmei shield",ammo="Sapience orb",
        head="Befouled crown",neck="Loricate torque +1",ear1="Infused earring",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Otomi gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Witful Belt",legs="Assiduity pants +1",feet="Battlecast Gaiters"}

	sets.idle.IdleBurst = {main="Lathi",sub="Niobid strap",ammo="Dosis Tathlum",
        head=gear.MB_head,neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=gear.nuke_body,hands="Amalric gages",ring1="Locus Ring",ring2="Mujin band",
        back="Bane Cape",waist="Eschan Stone",legs=gear.MB_legs,feet=gear.MB_feet}

	sets.idle.Death = {feet=gear.merlfeet_refresh}
	
    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Earth Staff", sub="Zuuxowu Grip",ammo="Impatiens",
        head="Befouled crown",neck="Loricate torque +1",ear1="Infused earring",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Amalric gages",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Witful Belt",legs="Hagondes Pants",feet="Battlecast Gaiters"}
    
    -- Town gear.
    sets.idle.Town = sets.idle
        
    -- Defense sets
	
	sets.TreasureHunter = {waist="Chaac Belt"}
	sets.ConsMP = {body="Spaekona's coat +1"}

    sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Sapience orb",
        head="Befouled crown",neck="Loricate torque +1",ear1="Infused earring",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Otomi gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {
        head="Nahtirah Hat",neck="Loricate torque +1",ear1="Sanare earring",
        body="Onca suit",hands=empty,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs=empty,feet=empty}

    sets.Kiting = {feet="Herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Befouled crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Onca suit",hands=empty,ring1="Rajas Ring",
        back="Repulse Mantle",waist="Ninurta's sash",legs=empty,feet=empty}
end
