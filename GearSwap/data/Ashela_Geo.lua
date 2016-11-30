-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
-- Load and initialize the include file.
	mote_include_version = 2
	include('organizer-lib')
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	indi_timer = ''
	indi_duration = 270
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Magic Burst')
	state.IdleMode:options('Normal', 'PDT')
 
	state.MagicBurst = M(false, 'Magic Burst')
 
	gear.default.weaponskill_waist = "Fotia Belt"
 
	select_default_macro_book()
 
	custom_timers = {}
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.


-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------

-- Precast Sets

-- Precast sets to enhance JAs
sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1",back="Nantosuelta's Cape"}
sets.precast.JA['Bolster'] = {body="Bagua Tunic"}
sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}	
sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines"}

-- Fast cast sets for spells

sets.precast.FC = {main="Solstice",
	range="Dunna",
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	body="Shango Robe",
	hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
	legs="Geomancy Pants +1",
	feet="Regal Pumps",
	neck="Voltsurge Torque",
	waist="Channeler's Stone",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Lifestream Cape"}

sets.precast.FC.Cure = {main="Solstice",
	range="Dunna",
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	body="Shango Robe",
	hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
	legs="Geomancy Pants +1",
	feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
	neck="Voltsurge Torque",
	waist="Channeler's Stone",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Lifestream Cape"}

sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,{})

sets.precast.StatusRemoval = set_combine(sets.precast.FC,{
	head="Vanya Hood",ear2="Loquacious Earring",ring1="Prolix Ring",waist="Witful Belt",
})
	   
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {}


-- Midcast Sets

sets.midcast.FastRecast = {}

sets.midcast.Geomancy = {main="Solstice",
	range="Dunna",
	ammo=empty,
	head="Azimuth Hood +1",
	body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
	hands="Geomancy Mitaines +1",
	legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
	feet="Geomancy Sandals",
	neck="Incanter's Torque",
	waist="Channeler's Stone",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Lifestream Cape"
}
	sets.midcast.Geomancy.Indi = {main="Solstice",
	sub="Genmei Shield",
	range="Dunna",
	ammo=empty,
	head="Azimuth Hood +1",
	body="Bagua Tunic",
	hands="Geomancy Mitaines +1",
	legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
	feet="Azimuth gaiters +1",
	neck="Incanter's Torque",
	waist="Fucho-no-Obi",
	left_ear="Gwati Earring",
	right_ear="Etiolation Earring",
	left_ring="Defending Ring",
	right_ring="Prolix Ring",
	back="Lifestream Cape"}

sets.midcast.StatusRemoval = {}

-- Cure potency =
sets.midcast.Cure = {main="Tamaxchi",
	range="Dunna",
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	body="Shango Robe",
	hands="Weather. Cuffs",
	legs="Geomancy Pants +1",
	feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
	neck="Incanter's Torque",
	waist="Channeler's Stone",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Solemnity Cape",}

sets.midcast.Stoneskin = {}

sets.midcast.Protectra = {ring1="Sheltered Ring"}

sets.midcast.Shellra = {ring1="Sheltered Ring"}

-- Custom Spell Classes
sets.midcast['Enfeebling Magic'] = {
	main="Solstice",sub="Genmei Shield",range="Dunna",ammo=empty,
	head="Befouled Crown",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
	body="Shango Robe",hands="Amalric Gages",ring1="Weatherspoon Ring",ring2="Shiva Ring",
	back="Lifestream Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet="Bagua Sandals +1"
}

sets.midcast.IntEnfeebles = sets.midcast['Enfeebling Magic']

sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

sets.midcast['Dark Magic'] = sets.midcast['Enfeebling Magic']

-- Sets to return to when not performing an action.

-- Resting sets
sets.resting = {head="Nahtirah Hat",neck="Wiglen Gorget",
body="Artsieq Jubbah",ring1="Sheltered Ring",ring2="Paguroidea Ring",
legs="Nares Trews",feet="Chelona Boots"}


-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Bolelabunga",
		sub="Genmei Shield",
		range="Dunna",
		ammo=empty,
		head="Befouled Crown",
		body="Amalric Doublet",
		hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
		legs="Assiduity Pants +1",
		feet="Geo. Sandals",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Sanare Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back="Solemnity Cape"}



	sets.idle.PDT = {}

	sets.idle.Pet = {main="Solstice",
		sub="Genmei Shield",
		range="Dunna",
		ammo=empty,
		head="Azimuth Hood +1",
		body="Amalric Doublet",
		hands="Bagua Mitaines",
		legs="Assiduity Pants +1",
		feet="Bagua Sandals +1",
		neck="Loricate Torque +1",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back="Nantosuelta's Cape"}

	sets.idle.PDT.Pet = set_combine(sets.idle.Pet, 
		{legs="Psycloth lappas"})

	sets.idle.Indi = set_combine(sets.idle, {neck="Loricate torque +1"})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {feet="Azimuth gaiters +1"})


-- Defense sets

sets.defense.PDT = {}

sets.defense.MDT = {}

sets.Kiting = {feet="Geomancy Sandals"}

-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.
-- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Normal melee group
sets.engaged = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
--------------------------[Job functions]------------------------------    
 
--------------------------[Standard events]------------------------------    
 
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if midaction() then
			eventArgs.cancel = true
			windower.add_to_chat(3,'Midaction--cancelling: '..spell.english..'')				
			return
		end
		if spell.english == "Impact" then
			equip(set_combine(sets.precast.FC,{head=empty,body="Twilight Cloak"}))
		end
	elseif spell.action_type == 'Ability' then
		if midaction() then
			eventArgs.cancel = true
			windower.add_to_chat(3,'Midaction--cancelling: '..spell.english..'')				
			return
		end
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
		eventArgs.handled = true
	end
end

function job_post_midcast(spell, action, spellMap, eventArts)
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and spell.english ~= 'Impact' then
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
 
----------------------