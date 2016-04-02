
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

        Non_Obi_Spells = S{
                        'Burn','Choke','Drown','Frost','Rasp','Shock','Impact','Anemohelix','Cryohelix',
                        'Geohelix','Hydrohelix','Ionohelix','Luminohelix','Noctohelix','Pyrohelix'}
 
        Cure_Spells = {"Cure","Cure II","Cure III","Cure IV"} -- Cure Degradation --
        Curaga_Spells = {"Curaga","Curaga II"} -- Curaga Degradation --
		
    state.OffenseMode:options('None', 'Locked')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT','Meva')
	
    state.MagicBurst = M(false, 'Magic Burst')

	gear.RegenCape = {name="Bookworm's Cape", augments={'INT+2','Helix eff. dur. +13','"Regen" potency+9',}}
	gear.HelixCape = {name="Bookworm's Cape", augments={'INT+4','MND+4','Helix eff. dur. +20',}}
	gear.NukeStaff = {name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}}
	gear.EnfeebStaff = {name="Akademos", augments={'Mag. Acc.+20','Enha.mag. skill +15','Enfb.mag. skill +15',}}

    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c toggle MagicBurst')
		
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
    select_default_macro_book()

	custom_timers = {}
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +1"}


    -- Fast cast sets for spells

    sets.precast.FC = {main="Grioavolr",sub="Arbuda grip",ammo="Sapience orb",
        head=gear.FC_head,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="loquacious Earring",
        body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Perimede cape",waist="Witful Belt",legs="Psycloth lappas",feet="Pedagogy loafers +1"}
	
	--main="Apamajas II",sub="Arbuda grip", 
    sets.precast.FC.Stun = {ammo="Sapience orb",
        head=gear.FC_head,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="loquacious Earring",
        body="Shango Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Pedagogy loafers +1"}

    sets.precast.FC.Arts = {feet="Academic's loafers +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Enhancing Magic'].Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat",waist="Siegel Sash",legs="Doyen pants"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Barkarole earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, 
		{body="Heka's Kalasiris",legs="Doyen Pants"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	sets.precast.WS = {
        head="Befouled crown",neck="Fotia gorget",
        body="Onca suit",hands=empty,
        back="Aurist's cape +1",waist="Fotia Belt",legs=empty,feet=empty}
    
	sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Kaykaus Mitra",neck="Nodens gorget",ear1="loquacious earring", ear2="Moonshade earring",
		body="Amalric doublet", hands="Kaykaus cuffs", ring1="Sangoma ring", ring2="Lebeche Ring",
		back="Aurist's cape +1", waist="Fucho-no-obi", legs="Amalric slops", feet="Arbatel loafers +1"}



    -- Midcast Sets 

    sets.midcast.FastRecast = {ammo="Sapience orb",
        head=gear.FC_head,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Pedagogy loafers +1"}

    sets.midcast.Cure = {ammo="Psilomene",
        head="Kaykaus mitra",neck="Incanter's Torque",ear1="Calamitous Earring",ear2="Gwati Earring",
        body="Kaykaus bliaut",hands="Telchine gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered cape +1",waist="Bishop's sash",legs="Chironic Hose",feet="Vanya clogs"}

    sets.midcast.CureWithLightWeather = {main="Chatoyant staff",sub="Arbuda grip",ammo="Psilomene",
        head="Kaykaus mitra",neck="Incanter's Torque",ear1="Calamitous Earring",ear2="Gwati earring",
        body="Kaykaus bliaut",hands="Kaykaus cuffs",ring1="Lebeche Ring",ring2="Sirona's Ring",
        back="Twilight cape",waist="Hachirin-no-obi",legs="Chironic Hose",feet="Vanya clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.SelfCure = set_combine(sets.midcast.Cure, {hands=gear.chirhands_sc,waist="Gishdubar Sash",ring1="Kunaji Ring",ring2="Asklepian Ring"})
 
    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,{
        head="Kaykaus mitra",neck="Malison Medallion",ear1="Calamitous Earring",
        body="Pedagogy gown +1",hands="Hieros Mittens",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered cape +1",waist="Ninurta's sash",legs="Chironic hose",feet="Vanya clogs"})

    sets.midcast['Enhancing Magic'] = {main="Grioavolr",sub="Fulcio grip",ammo="Savant's Treatise",
        head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa earring",
        body="Telchine Chas.",hands="Telchine gloves",
	   back="Fi follet cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.midcast.Storm = sets.midcast['Enhancing Magic']
	   
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",sub="Genmei Shield",
		head="Arbatel Bonnet +1",
		back=gear.RegenCape})
	
	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
		{ammo="Sapience orb",
		neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
		ring1="Prolix ring",ring2="Weatherspoon ring",
		back="Swith cape +1",waist="Ninurta's sash"})

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{legs="Shedir seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif",waist="Gishdubar sash"})

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{legs=gear.merllegs_phalanx})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{head="Chironic hat",
		waist="Emphatikos Rope",legs="Shedir seraweels"})	

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",neck="Nodens Gorget",legs="Shedir seraweels"})


    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],{ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],{ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main=gear.EnfeebStaff,sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Chironic hat",neck="Incanter's torque",ear1="Barkarole Earring",ear2="Digni. Earring",
        body=gear.chirbody,hands="Kaykaus cuffs",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
        back="Aurist's cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's sabots"}

	sets.midcast.MndEnfeebles.Resistant = {main=gear.EnfeebStaff,sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Chironic hat",neck="Incanter's torque",ear1="Barkarole Earring",ear2="Digni. Earring",
        body=gear.chirbody,hands="Kaykaus cuffs",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
        back="Aurist's cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's sabots"}

    sets.midcast.IntEnfeebles = {main=gear.EnfeebStaff,sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Chironic hat",neck="Incanter's torque",ear1="Barkarole Earring",ear2="Digni. Earring",
        body=gear.chirbody,hands="Kaykaus cuffs",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Aurist's cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's sabots"}

    sets.midcast.IntEnfeebles.Resistant = {main=gear.EnfeebStaff,sub="Mephitis Grip",ammo="Pemphredo tathlum",
        head="Chironic hat",neck="Incanter's torque",ear1="Digni. Earring",ear2="Barkarole Earring",
        body=gear.chirbody,hands="Kaykaus cuffs",ring1="Shiva Ring +1",ring2="Weatherspoon Ring",
        back="Aurist's cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's sabots"}


    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Shango robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.HelixCape,waist="Eschan Stone",legs="Pedagogy pants +1",feet=gear.DA_feet}

    sets.midcast.Kaustra = {main="Rubicundity",sub="Genmei shield",range=empty,ammo="Pemphredo tathlum",
        head="Pixie Hairpin +1",neck="Incanter's torque",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=gear.nuke_body,hands="Amalric gages",ring1="Shiva Ring +1",ring2="Archon Ring",
        back=gear.HelixCape,waist="Refoccilation Stone",legs=gear.nuke_legs,feet=gear.MB_feet}

	

    sets.midcast.Drain = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Shango robe",hands=gear.DA_hands,ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.HelixCape,waist="Fucho-no-obi",legs=gear.DA_legs,feet=gear.DA_feet}

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Grioavolr",sub="Arbuda Grip",ammo="Hasty Pinion +1",
        head=gear.FC_head,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="loquacious Earring",
        body=gear.nuke_body,hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Evanescence Ring",
        back="Swith cape +1",waist="Ninurta's sash",legs="Psycloth lappas",feet="Pedagogy loafers +1"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Grioavolr"})
	
	sets.midcast.Helix = {main=gear.NukeStaff,sub="Thrace Strap",ammo="Dosis Tathlum",
		head=gear.nuke_head, neck="Saevus pendant +1", ear1="Friomisi Earring", ear2="Barkarole earring",
		body=gear.nuke_body, hands=gear.nuke_hands, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back=gear.HelixCape, waist="Refoccilation Stone", legs=gear.nuke_legs, feet=gear.MB_feet }

	sets.midcast.Helix.Resistant = {main=gear.NukeStaff,sub="Thrace Strap",ammo="Pemphredo Tathlum",
		head=gear.nuke_head, neck="Sanctity Necklace", ear1="Friomisi Earring", ear2="Barkarole earring",
		body=gear.nuke_body, hands=gear.nuke_hands, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back=gear.HelixCape, waist="Eschan Stone", legs=gear.nuke_legs, feet=gear.MB_feet }

	sets.midcast['Luminohelix II'] = set_combine(sets.midcast.Helix, {ring1="Weatherspoon Ring"})
	
	sets.midcast['Noctohelix II'] = set_combine(sets.midcast.Helix, {head="Pixie Hairpin +1",ring1="Archon Ring"})

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main=gear.NukeStaff,sub="Zuuxowu grip",ammo="Dosis Tathlum",
        head=gear.nuke_head,neck="Saevus pendant +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=gear.nuke_body,hands=gear.nuke_hands,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.HelixCape,waist="Refoccilation Stone",legs=gear.nuke_legs,feet=gear.MB_feet}

    sets.midcast['Elemental Magic'].Resistant = {main=gear.NukeStaff,sub="Niobid strap",ammo="Pemphredo tathlum",
        head=gear.nuke_head,neck="Sanctity necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=gear.nuke_body,hands=gear.macc_hands,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.HelixCape,waist="Eschan Stone",legs=gear.nuke_legs,feet=gear.MB_feet}

    

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
		{sub="Thrace strap",ammo="Pemphredo tathlum",
		})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, 
		{})

	sets.magic_burst = {main=gear.NukeStaff,
		head=gear.MB_head,
		hands="Amalric gages", ring1="Mujin Band", 
		back="Seshaw cape",legs=gear.MB_legs,feet=gear.MB_feet}



    sets.midcast.Impact = {main=gear.EnfeebStaff,sub="Thrace strap",ammo="Pemphredo tathlum",
        head=empty,neck="Incanter's torque",ear1="Barkarole Earring",ear2="Gwati Earring",
        body="Twilight Cloak",hands=gear.macc_hands,ring1="Weatherspoon Ring",ring2="Archon Ring",
        back=gear.HelixCape,waist="Eschan Stone",legs=gear.nuke_legs,feet=gear.MB_feet}


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled crown",
        body="Amalric doublet",legs="Assiduity pants +1"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {main=gear.NukeStaff,sub="Niobid strap",ammo="Homiliary",
        head="Arbatel bonnet +1",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Infused Earring",
        body=gear.nuke_body,hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs="Assiduity pants +1",feet="Herald's gaiters"}

    sets.idle.Field = {main="Bolelabunga",sub="Genmei shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Amalric doublet",hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs="Assiduity pants +1",feet="Arbatel loafers +1"}

    sets.idle.Field.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs="Assiduity pants +1",feet=gear.merlfeet_refresh }

	sets.idle.Field.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Vrikodara Jupon",hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity cape",waist="Slipor Sash",legs="Assiduity pants +1",feet="Vanya clogs"}


    sets.idle.Field.Stun = {main="Akademos",sub="Mephitis Grip",ammo="Sapience orb",
        head="Amalric coif",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assiduity pants +1",feet="Pedagogy loafers +1"}

    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs="Assiduity pants +1",feet=gear.merlfeet_refresh }

    -- Defense sets
	--42% discounting main/sub
    sets.defense.PDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Brigantia Pebble",
        head="Chironic hat",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands="Gendewitha Gages +1",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs=gear.merllegs_dt,feet="Battlecast gaiters"}
	--35% discounting main/sub
    sets.defense.MDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Vanir Battery",
        head="Chironic hat",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Vrikodara Jupon",hands=gear.macc_hands,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity cape",waist="Slipor Sash",legs=gear.merllegs_phalanx,feet="Vanya clogs"}
    
	sets.defense.Meva = set_combine(sets.defense.MDT,{head="Chironic hat",ear2="Dominance Earring"})

    sets.Kiting = {feet="Herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head="Befouled Crown",neck="Loricate torque +1",
        body="Vrikodara jupon",hands=gear.chirhands_sc,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs=gear.merllegs_dt,feet="Battlecast gaiters" }


    -- Elemental Obi/Twilight Cape --
	sets.Obi = {main=gear.NukeStaff,
		back="Twilight Cape",waist='Hachirin-no-Obi'}
       
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel bracers +1"}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers +1"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers +1"}

    sets.buff['Klimaform'] = {feet="Arbatel loafers +1"}

    sets.buff.FullSublimation = {head="Academic's Mortarboard +1", body="Pedagogy Gown +1", ear1="Savant's Earring"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard +1", body="Pedagogy Gown +1", ear1="Savant's Earring"}

end