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
	state.CastingMode:options('Normal', 'Mid', 'Resistant', 'CMP', 'DeatMB')
	state.IdleMode:options('Normal', 'PDT')
  
	MagicBurstIndex = 0
	state.MagicBurst = M(false, 'Magic Burst')
	state.ConsMP = M(false, 'Conserve MP')
	state.DeatCast = M(false, 'Death Mode')
	element_table = L{'Earth','Wind','Ice','Fire','Water','Lightning'}
	state.AOE = M(false, 'AOE')

	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	degrade_array = {
		['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
		['Firega'] = {'Firaga','Firaga II','Firaga III','Firaja'},
		['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
		['Icega'] = {'Blizzaga','Blizzaga II','Blizzaga III','Blizzaja'},
		['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
		['Windga'] = {'Aeroga','Aeroga II','Aeroga III','Aeroja'},
		['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
		['Earthga'] = {'Stonega','Stonega II','Stonega III','Stoneja'},
		['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
		['Lightningga'] = {'Thundaga','Thundaga II','Thundaga III','Thundaja'},
		['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V','Water VI'},
		['Waterga'] = {'Waterga','Waterga II','Waterga III','Waterja'},
		['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
		['Sleepgas'] = {'Sleepga','Sleepga II'}
	}
	-- Additional local binds
	send_command('bind ^` gs c toggle MagicBurst')
	send_command('bind !` gs c toggle ConsMP')
	send_command('bind @` gs c toggle DeatCast')


	organizer_items = {aeonic="Khatvanga"}
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
	sets.precast.JA['Mana Wall'] = {back="Taranus's cape",feet="Wicce Sabots +1"}

	sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
	
	-- equip to maximize HP (for Tarus) and minimize MP loss before using convert
	sets.precast.JA.Convert = {}


	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grio_enhancing,sub="Clerisy Strap",ammo="Sapience orb",
		head=gear.merlhead_fc,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Helios gloves",ring1="Rahab Ring",ring2="Weatherspoon Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet=gear.merlfeet_fc }

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	--sets.precast.FC['Enhancing Magic'].DeatMB = sets.precast.FC.DeatMB

	sets.precast.FC['Enfeebling Magic'] = sets.precast.FC
	--sets.precast.FC['Enfeebling Magic'].DeatMB = sets.precast.FC.DeatMB
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})
	--sets.precast.FC['Elemental Magic'].DeatMB = sets.precast.FC.DeatMB

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})
	--sets.precast.FC['Healing Magic'].DeatMB = sets.precast.FC.DeatMB

	--Death sets
	sets.DeatCastIdle = {
		main=gear.grio_death,         --82
		sub="Niobid strap",   		-- 20
		ammo="Psilomene",           -- 45
		head="Amalric coif",        -- 121
		neck="Dualism Collar",    -- 45
		ear1="Etiolation earring",  -- 50
		ear2="Influx earring",      -- 55 
		body="Amalric doublet",     -- 133
		hands="Amalric gages",      -- 86
		ring1="Mephitas's ring",    -- 100
		ring2="Sangoma Ring",       -- 70
		back="Bane Cape",           -- 90
		waist="Shinjutsu-no-obi",   -- 80 
		legs="Amalric slops",       -- 160
		feet=gear.merlfeet_refresh  -- 20
}               ---Total +MP: 1157
	
	sets.precast.FC.DeatMB = {		--MP 		--FC
		main=gear.grio_death,           --82		--4
		sub="Niobid Strap",        	-- 20		
		ammo="Psilomene",           -- 45
		head="Amalric coif",        -- 121		--10
		neck="Voltsurge torque",    -- 20		--4
		ear1="Etiolation earring",      -- 50 		--1
		ear2="Loquacious earring",  -- 30		--2
		body="Amalric doublet",     -- 133		--3
		hands="Helios gloves",      -- 44		--4
		ring1="Rahab Ring",         -- 30		--2
		ring2="Weatherspoon ring",			--5
		back="Bane Cape",           -- 90		--4
		waist="Witful Belt", 				--3
		legs="Psycloth lappas",     -- 109		--7
		feet=gear.amalricfeet_death        -- 86	--5
}		--[[Total: +860 = ~2214]]

	sets.midcast['Death'] = { 
		main=gear.grio_death,	--82
		sub="Niobid strap",         -- 20
		ammo="Psilomene",           -- 45
		head="Pixie hairpin +1",    -- 120
		neck="Sanctity necklace",    --35
		ear1="Barkarole earring",   -- 25
		ear2="Friomisi Earring",
		body="Amalric doublet", 	--133
		hands="Amalric gages",      -- 86
		ring1="Mephitas's ring",    -- 100
		ring2="Archon Ring",
		back="Taranus's Cape",      -- 60
		waist="Shinjutsu-no-obi",   -- 80
		legs="Amalric slops",       -- 160
		feet=gear.merlfeet_mb       -- 20
	}
									--[[Total: +723 (783 with gages aug change)]]
		--death specific MB set
	sets.MB_death = { 
		main=gear.grio_death,	--82
		sub="Niobid strap",		--20
		ammo="Psilomene",		--45
		head="Pixie hairpin +1", 	--120
		--neck="Mizu. Kubikazari", 
		ear1="Barkarole earring", 	--25
		--ear2="Static Earring",
		body=gear.merlbody_mb, 	--67
		hands="Amalric gages",	--86
		ring1="Mujin Band",
		--ring2="Archon Ring",
		back="Taranus's Cape", 	--60
		--waist="Hachirin-no-obi", 
		legs=gear.merllegs_mb, 	--44
		feet=gear.merlfeet_mb 	--20
	} --[[Combined midcast+mb total: +684 = ~2038]]
			
	sets.precast.FC.Curaga = sets.precast.FC.Cure

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {head="Befouled crown",neck="Fotia gorget",
		body="Onca suit",hands=empty,ring1="Rajas Ring",
		back="Solemnity cape",waist="Fotia belt",legs=empty,feet=empty}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Pixie Hairpin +1",neck="Nodens gorget",ear1="loquacious earring", ear2="Moonshade earring",
		body="Amalric doublet", hands="Otomi gloves", ring1="Sangoma ring", ring2="Lebeche Ring",
		back="Bane cape", waist="Fucho-no-obi", legs="Amalric slops", feet="Medium's sabots"}


	---- Midcast Sets ----
	--sets.midcast.DeatMB = sets.precast.FC['Death']

	sets.midcast.FastRecast = {ammo="Sapience orb",
		head=gear.merlhead_nuke,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body="Shango Robe",hands="Helios gloves",ring1="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet=gear.merlfeet_fc }

	sets.midcast['Healing Magic'] = {head="Telchine cap",neck="Incanter's Torque",ear1="Mendicant's earring",ear2="Beatific Earring",
		body="Vrikodara jupon",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Haoma's Ring",
		back="Solemnity cape",waist="Bishop's sash",legs="Telchine braconi",feet="Vanya clogs"}


	sets.midcast['Enhancing Magic'] = {main=gear.grio_enhancing,sub="Fulcio grip",
		head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
		body="Telchine Chasuble",hands="Telchine gloves",
		legs="Telchine Braconi",feet="Telchine pigaches"}

	sets.midcast['Enhancing Magic'].Refresh = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif",waist="Gishdubar sash"})

	sets.midcast['Enhancing Magic'].Haste = set_combine(sets.midcast['Enhancing Magic'], 
		{ammo="Sapience orb",
		neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
		ring1="Prolix ring",
		back="Swith cape +1",waist="Ninurta's sash"})

	sets.midcast['Enhancing Magic'].Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{feet=gear.merllegs_dt})

	sets.midcast['Enhancing Magic'].Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif",waist="Emphatikos Rope",legs="Shedir seraweels"})

	sets.midcast['Enhancing Magic'].Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
		{waist="Siegel Sash",neck="Nodens gorget",legs="Shedir seraweels"})

	sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo tathlum",
		head="Amalric coif",neck="Incanter's torque",ear1="Gwati Earring",ear2="Digni. Earring",
		body=gear.merlbody_nuke,hands="Amalric gages",ring1="Globidonta Ring",ring2="Weatherspoon Ring",
		back="Aurist's cape +1",waist="Luminary sash",legs="Psycloth lappas",feet="Medium's sabots"}	
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { })	

	sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
		head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. earring",
		body="Shango Robe",hands="Amalric gages",ring1="Evanescence Ring",ring2="Archon Ring",
		back="Bane Cape",waist="Luminary sash",legs="Psycloth lappas",feet=gear.merlfeet_da }

	sets.midcast.Drains = set_combine(sets.midcast['Dark Magic'],
		{body=gear.merlbody_da,
		waist="Fucho-no-obi",legs=gear.merllegs_da })
	sets.midcast.Aspirs = sets.midcast.Drains
	sets.midcast['Dark Magic'].Stun = {main=gear.grio_death,sub="Arbuda Grip",ammo="Sapience orb",
		head=gear.merlhead_fc,neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
		body="Shango Robe",hands="Helios gloves",ring1="Rahab Ring",ring2="Weatherspoon Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet=gear.merlfeet_fc }

	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {main="Lathi",sub="Niobid strap",ammo="Pemphredo tathlum",
		head=gear.merlhead_nuke,neck="Saevus pendant +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body=gear.merlbody_nuke,hands="Amalric gages",ring1="Shiva ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Refoccilation Stone",legs=gear.merllegs_nuke,feet=gear.merlfeet_mb }

	sets.midcast['Elemental Magic'].Mid = set_combine(sets.midcast['Elemental Magic'], 
		{ammo="Pemphredo tathlum",
		neck="Sanctity necklace",
		waist="Eschan Stone"})
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'].Mid, 
		{
		neck="Incanter's torque",ear2="Gwati earring",
		})
	sets.midcast['Elemental Magic'].CMP = set_combine(sets.midcast['Elemental Magic'], 
		{
		neck="Incanter's torque",ear2="Gwati earring",
		body="Vedic Coat",legs=gear.merllegs_cmp,feet=gear.amalricfeet_consmp
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
	sets.midcast['Elemental Magic'].HighTierNuke.CMP = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, 
		{
		neck="Incanter's Torque",ear2="Gwati earring",
		body="Vedic Coat",
		back="Bane Cape",legs=gear.merllegs_cmp,feet=gear.amalricfeet_consmp})

	sets.midcast.Impact = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo tathlum",
		head=empty,neck="Sanctity necklace",ear1="Gwati Earring",ear2="Barkarole earring",
		body="Twilight Cloak",hands="Amalric Gages",ring1="Weatherspoon Ring",ring2="Archon Ring",
		back="Bane cape",waist="Eschan Stone",legs=gear.merllegs_nuke,feet=gear.merlfeet_refresh }

	--Death Midcast subtables
	sets.midcast['Enhancing Magic'].DeatMB = set_combine(sets.precast.FC.DeatMB,sets.midcast['Enhancing Magic'],
		{ammo="Psilomene",
		neck="Dualism Collar",ear1="Etiolation earring",ear2="Influx Earring",
		ring1="Mephitas's Ring",ring2="Rahab Ring",
		back="Bane Cape",waist="Shinjutsu-no-obi"})
	
	sets.midcast['Enfeebling Magic'].DeatMB = set_combine(sets.precast.FC.DeatMB,
		{ammo="Elis tome",
		 neck="Sanctity necklace",ear1="Gwati Earring",ear2="Barkarole Earring",
		 body=gear.merlbody_nuke,hands="Amalric Gages",ring1="Sangoma Ring",
		 back="Aurist's cape +1",waist="Luminary Sash",feet="Medium's sabots"})
	
	sets.midcast['Dark Magic'].DeatMB =  set_combine(sets.precast.FC.DeatMB,
		{head="Pixie Hairpin +1",neck="Sanctity Necklace",ear2="Barkarole Earring",
		body=gear.merlbody_da,hands="Amalric gages", ring1="Evanescence Ring",ring2="Archon Ring",
		back="Bane Cape",waist="Fucho-no-obi",legs=gear.merllegs_da,feet=gear.merlfeet_da })
	sets.midcast.Aspirs.DeatMB = set_combine(sets.precast.FC.DeatMB,
		{head="Pixie Hairpin +1",neck="Sanctity Necklace",ear2="Barkarole Earring",
		body=gear.merlbody_da,hands="Amalric gages", ring1="Evanescence Ring",ring2="Archon Ring",
		back="Bane Cape",waist="Fucho-no-obi",legs=gear.merllegs_da,feet=gear.merlfeet_da })

	sets.midcast['Healing Magic'].DeatMB = set_combine(sets.precast.FC.DeatMB,
		{neck="Nodens Gorget",ear1="Influx Earring",ear2="Mendicant's earring",
		hands="Telchine Gloves",ring2="Lebeche Ring",
		back="Tempered Cape +1",waist="Luminary Sash",feet="Telchine Pigaches"})
	
	sets.midcast.FastRecast.DeatMB = sets.precast.FC.DeatMB


	-- Minimal damage gear for procs.
	--[[sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
		head="Nahtirah Hat",neck="Loricate torque +1",ear1="Gwati earring",ear2="Loquacious Earring",
		body="Telchine Chasuble",hands="Telchine gloves",ring1="Lebeche Ring",ring2="Paguroidea Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Assiduity pants +1",feet="Vanya clogs"}]]

	sets.magic_burst = {
		head=gear.merlhead_mb,neck="Mizukage-no-Kubikazari",
		hands="Amalric gages", ring2="Mujin Band",
		back="Seshaw cape",legs=gear.merllegs_mb,feet=gear.merlfeet_mb }

	 sets.Obi = {waist='Hachirin-no-Obi'}
	   
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	
	-- Normal refresh idle set
	sets.idle = {main="Bolelabunga", sub="Genmei shield",ammo="Sapience orb",
		head="Befouled crown",neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Amalric doublet",hands="Amalric gages",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Slipor sash",legs="Assiduity pants +1",feet=gear.merlfeet_refresh }

	-- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = {main="Bolelabunga", sub="Genmei shield",ammo="Sapience orb",
		head="Befouled crown",neck="Loricate torque +1",ear1="Genmei earring",ear2="Impregnable Earring",
		body="Vrikodara jupon",hands=gear.merlhands_pdt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity cape",waist="Slipor sash",legs="Assiduity pants +1",feet=gear.merlfeet_dt }


	
	-- Idle mode scopes:
	-- Idle mode when weak.
	sets.idle.Weak = {main="Earth Staff", sub="Thrace Strap",ammo="Psilomene",
		head="Befouled crown",neck="Loricate torque +1",ear1="Infused earring",ear2="Loquacious Earring",
		body="Vrikodara jupon",hands="Amalric gages",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity cape",waist="Witful Belt",legs="Hagondes Pants",feet=gear.merlfeet_dt }
	
	-- Town gear.
	sets.idle.Town = sets.idle
		
	-- Defense sets
	
	sets.TreasureHunter = {waist="Chaac Belt"}
	sets.ConsMP = {body="Spaekona's coat +1"}

	sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Sapience orb",
		head="Blistering Sallet",neck="Loricate torque +1",ear1="Infused earring",ear2="Loquacious Earring",
		body="Vrikodara jupon",hands=gear.merlhands_pdt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity cape",waist="Slipor sash",legs=gear.merllegs_dt,feet=gear.merlfeet_dt }

	sets.defense.MDT = {ammo="Vanir battery",
		head=gear.merlhead_mb,neck="Loricate torque +1",ear1="Sanare earring",ear2="Zennaroi earring",
		body="Amalric doublet",hands="Telchine gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Slipor sash",legs=gear.merllegs_phalanx,feet=gear.merlfeet_dt }

	sets.Kiting = {feet="Herald's gaiters"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.buff['Mana Wall'] = {back="Taranus's cape",feet="Wicce Sabots +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	--!!!!!Commented out until I make rule to handle engaged set during death mode (will use customize_melee_set)
	
	--[[sets.engaged = {
		head="Blistering sallet",neck="Loricate torque +1",ear1="Telos Earring",ear2="Zennaroi Earring",
		body="Vrikodara jupon",hands="Gazu bracelet +1",ring1="Defending Ring",ring2="Cacoethic ring",
		back="Aurist's cape +1",waist="Ninurta's sash",legs="Telchine braconi",feet="Battlecast gaiters"}]]

end
---------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, action, spellMap, eventArgs)
	enable('feet','back')
	if state.DeatCast.value then
		if spell.action_type == 'Magic' then
			classes.CustomClass = 'DeatMB'
		end
	elseif spell.type == 'BlackMagic' and spell.target.type == 'MONSTER' then
		refine_various_spells(spell, action, spellMap, eventArgs)
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if state.DeatCast.value then
		return
	elseif spell.english == "Impact" then
		equip({head=empty,body="Twilight Cloak"})
	elseif spellMap == 'Cure' or spellMap == 'Curaga' then
		gear.default.obi_waist = "Hachirin-no-obi"
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if state.DeatCast.value then
		if spell.action_type == 'Magic' then
			if spell.english == 'Death' then
				equip(sets.midcast['Death'])
			else
				classes.CustomClass = 'DeatMB'
				state.CastingMode:set('DeatMB')
			end
		end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' and state.MagicBurst.value then
		if state.DeatCast.value then
			if spell.english == 'Death' then
				equip(sets.MB_death)
			elseif spell.skill == 'Elemental Magic' then
				equip(sets.magic_burst)
			end
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
end

function job_aftercast(spell, action, spellMap, eventArgs)
	-- Lock feet after using Mana Wall.
	if buffactive['Mana Wall'] and not state.DeatCast.value then
		enable('feet','back')
		equip(sets.buff['Mana Wall'])
		disable('feet','back')
	--[[elseif spell.skill == 'Enhancing Magic' then
		adjust_timers(spell, spellMap)]]
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

function nuke(spell, action, spellMap, eventArgs)
	if player.target.type == 'MONSTER' then
		if state.AOE.value then
			send_command('input /ma "'..degrade_array[element_table:append('ga')][#degrade_array[element_table:append('ga')]]..'" '..tostring(player.target.name))
		else
			send_command('input /ma "'..degrade_array[element_table][#degrade_array[element_table]]..'" '..tostring(player.target.name))
		end
	else 
		add_to_chat(5,'A Monster is not targetted.')
	end
end

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'element' then
		if commandArgs[2] then
			if element_table:contains(commandArgs[2]) then
				element_table = commandArgs[2]
				add_to_chat(5, 'Current Nuke element ['..element_table..']')
			else
				add_to_chat(5,'Incorrect Element value')
				return
			end
		else
			add_to_chat(5,'No element specified')
		end
	elseif commandArgs[1] == 'nuke' then
		nuke()
	end
end


function refine_various_spells(spell, action, spellMap, eventArgs)
	local aspirs = S{'Aspir','Aspir II','Aspir III'}
	local sleeps = S{'Sleep','Sleep II'}
	local sleepgas = S{'Sleepga','Sleepga II'}

	local newSpell = spell.english
	local spell_recasts = windower.ffxi.get_spell_recasts()
	local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

	local spell_index

	if spell_recasts[spell.recast_id] > 0 then
		if spell.skill == 'Elemental Magic' then
			local ele = tostring(spell.element):append('ga')
			--local ele2 = string.sub(ele,1,-2)
			if table.find(degrade_array[ele],spell.name) then
				spell_index = table.find(degrade_array[ele],spell.name)
				if spell_index > 1 then
					newSpell = degrade_array[ele][spell_index - 1]
					add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..newSpell..' instead.')
					send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
					eventArgs.cancel = true
				end
			else 
				spell_index = table.find(degrade_array[spell.element],spell.name)
				if spell_index > 1 then
					newSpell = degrade_array[spell.element][spell_index - 1]
					add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..newSpell..' instead.')
					send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
					eventArgs.cancel = true
				end
			end
		elseif aspirs:contains(spell.name) then
			spell_index = table.find(degrade_array['Aspirs'],spell.name)
			if spell_index > 1 then
				newSpell = degrade_array['Aspirs'][spell_index - 1]
				add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..newSpell..' instead.')
				send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
				eventArgs.cancel = true
			end
		elseif sleepgas:contains(spell.name) then
			spell_index = table.find(degrade_array['Sleepgas'],spell.name)
			if spell_index > 1 then
				newSpell = degrade_array['Sleepgas'][spell_index - 1]
				add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..newSpell..' instead.')
				send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
				eventArgs.cancel = true
			end
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
		enable('feet','back')
		handle_equipping_gear(player.status)
	end
	if buff == "Commitment" and not gain then
		equip({ring2="Capacity Ring"})
		if player.equipment.right_ring == "Capacity Ring" then
			disable("ring2")
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
	if stateField == 'Death Mode' then
		if newValue == true then
			state.OffenseMode:set('Normal')
			predeathcastmode = state.CastingMode.value
			--state.CastingMode:set('DeatMB')
			--[[Insert 'equip(<set consisting of Death weapon and sub, to have them automatically lock when changing into Death mode>)']]
		elseif newValue == false then
			state.CastingMode:set(predeathcastmode)
		end
	end            
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
--[[function job_update(cmdParams, eventArgs)
   -- if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
	 --                  buffactive['addendum: white'] or buffactive['addendum: black']) then
	   -- if state.IdleMode.value == 'Stun' then
		 --   send_command('@input /ja "Dark Arts" <me>')
		--else
		  --  send_command('@input /ja "Light Arts" <me>')
		--end
	--end

	update_active_strategems()
	update_sublimation()
end]]
function display_current_job_state(eventArgs)
	eventArgs.handled = true
	local msg = ''
	
	if state.OffenseMode.value ~= 'None' then
		msg = msg .. 'Melee: ['..state.OffenseMode.value..']'

		if state.CombatForm.has_value then
			msg = msg .. ' (' .. state.CombatForm.value .. ')'
		end
		msg = msg .. ', '
	end
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end

	msg = msg .. 'Casting ['..state.CastingMode.value..'], Idle ['..state.IdleMode.value..']'

	if state.MagicBurst.value == true then
		msg = msg .. ', Magic Burst: On'
	end
	if state.ConsMP.value == true then
		msg = msg .. ', Conserve MP: On'
	end
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	if state.Kiting.value == true then
		msg = msg .. ', Kiting'
	end

	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end

	if state.SelectNPCTargets.value == true then
		msg = msg .. ', Target NPCs'
	end

	add_to_chat(122, msg)
end

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
	if state.DeatCast.value then
		idleSet = set_combine(idleSet, sets.DeatCastIdle)
	end
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	if not state.DeatCast and buffactive['Mana Wall'] then
		idleSet = set_combine(idleSet, sets.buff['Mana Wall'])
	end
	return idleSet
end

--[[function job_status_change(newStatus, oldStatus, eventArgs)
end
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
end]]

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 19)
end