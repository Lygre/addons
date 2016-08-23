-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	include('organizer-lib')

	-- Load and initialize the include file.
	include('Mote-Include.lua')


end

-- Setup vars that are user-independent.
function job_setup()
state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end


-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()

	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT','MDT')
	state.PhysicalDefenseMode:options('PDT', 'Shield')
	state.Skillup = M(false, 'Boost Spell')
	
	state.AutoAga = M(false, 'Auto Curaga')
	Curaga_benchmark = 30
	Safe_benchmark = 70
	Sublimation_benchmark = 30
	Sublimation = 1

	Cures = S{'Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'}
	Curagas = S{'Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cura','Cura II','Cura III'}

	--get_current_strategem_count()
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------

-- Precast Sets

-- Fast cast sets for spells
sets.precast.FC = {    main="Grioavolr",sub="Clerisy Strap",ammo="Incantor Stone",
	head="Vanya Hood",
	body="Shango Robe",
	hands="Chironic Gloves",
	legs="Assiduity Pants",
	feet="Regal Pumps",
	neck="Orison Locket",
	waist="Channeler's Stone",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Serket Ring",
	right_ring="Weather. Ring",
	back="Swith Cape",}

sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
	main="Ababinili",
	sub="Clerisy Strap",
	legs="Ebers Pantaloons +1",
	feet="Vanya Clogs",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	right_ring="Weather. Ring",})

sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
	main="Ababinili",
	sub="Clerisy Strap",
	legs="Ebers Pantaloons +1",
	feet="Litany Clogs",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	right_ring="Weather. Ring",})

sets.precast.FC.Curaga = sets.precast.FC.Cure

-- Precast sets to enhance JAs
sets.precast.JA.Benediction = {body="Piety Briault"}

-- Waltz set (chr and vit)
sets.precast.Waltz = {
	head="Nahtirah Hat",ear1="Roundel Earring",
	body="Heka's Kalasiris",hands="Yaoyotl Gloves",
	back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

-- Midcast Sets

sets.midcast.FastRecast = sets.precast.FC

-- Cure sets
gear.default.obi_waist = "Goading Belt"
gear.default.obi_back = "Mending Cape"

sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",sub="Achaq Grip",ammo="Psilomene",
	head="Ebers cap +1",neck="Incanter's torque",ear1="Nourishing earring",ear2="Mendi. earring",
	body="Ebers Bliaud +1",hands="Weather. cuffs",ring1="Sirona's Ring",ring2="Weatherspoon Ring",
	back="Solemnity Cape",waist="Hachirin-no-obi",legs="Ebers Pantaloons +1",feet="Vanya clogs"}

sets.midcast.CureSolace = {ammo="Hydrocera",
	main="Queller Rod",
	sub="Sors shield",
	head="Vanya Hood",
	body="Ebers Bliaud +1",
	hands="Weather. Cuffs",
	legs="Ebers Pantaloons +1",
	feet="Vanya Clogs",
	neck="Phalaina Locket",
	waist="Luminary Sash",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Sirona's Ring",
	right_ring="Weather. Ring",
	back="Tempered Cape",}

sets.midcast.Cure = {
	main="Ababinili",
	sub="Achaq Grip",
	head="Vanya Hood",
	body="Ebers Bliaud +1",
	hands="Weather. Cuffs",
	legs="Ebers Pantaloons +1",
	feet="Vanya Clogs",
	neck="Phalaina Locket",
	waist="Luminary Sash",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Sirona's Ring",
	right_ring="Weather. Ring",
	back="Solemnity Cape",}

sets.midcast.Curaga = {
	main="Ababinili",
	sub="Achaq Grip",
	head="Vanya Hood",
	body="Ebers Bliaud +1",
	hands="Weather. Cuffs",
	legs="Ebers Pantaloons +1",
	feet="Vanya Clogs",
	neck="Phalaina Locket",
	waist="Luminary Sash",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Sirona's Ring",
	right_ring="Weather. Ring",
	back="Solemnity Cape",}

sets.midcast.CureMelee = {}

sets.midcast.Cursna = {}

sets.midcast.StatusRemoval = set_combine(sets.midcast.CureSolace,{main="Ababinili",sub="Clemency Grip",ammo="Incantor Stone",
	head="Ebers cap +1",legs="Ebers Pantaloons +1"})

-- 110 total Enhancing Magic Skill; caps even without Light Arts
sets.midcast['Enhancing Magic'] = {main="Beneficus",sub="Vivid Strap +1",
	head="Umuthi Hat",neck="Incanter's Torque",
	body="Manasa Chasuble",hands="Chironic Gloves",
	back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +2"}

sets.midcast.Stoneskin = {}

sets.midcast.Auspice = {hands="Chironic Gloves",feet="Orison Duckbills +2"}

sets.midcast.BarElement = {}

sets.midcast.Regen = {
	main="Bolelabunga",
	head="Vanya Hood",
	body={ name="Piety Briault", augments={'Enhances "Benediction" effect',}},
	hands="Weather. Cuffs",
	legs="Ebers Pantaloons +1",
	feet="Vanya Clogs",
	neck="Orison Locket",
	waist="Channeler's Stone",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Sirona's Ring",
	right_ring="Weather. Ring",
	back="Swith Cape",}

sets.midcast.Protectra = {ring1="Sheltered Ring",feet="Piety Duckbills"}

sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


sets.midcast['Divine Magic'] = {}

sets.midcast['Dark Magic'] = {}

-- Custom spell classes
sets.midcast.MndEnfeebles = {}

sets.midcast.IntEnfeebles = {}


-- Sets to return to when not performing an action.

-- Resting sets
sets.resting = {}


-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
sets.idle = {
	main="Bolelabunga",
	sub="Sors shield",
	head="Befouled Crown",
	body="Ebers Bliaud +1",
	hands="Chironic Gloves",
	legs="Assiduity Pants",
	feet="Inspirited Boots",
	neck="Orison Locket",
	waist="Luminary Sash",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Serket Ring",
	right_ring="Weather. Ring",
	back="Solemnity Cape",
}

sets.idle.PDT = {main="Bolelabunga", sub="Genbu Shield",ammo="Incantor Stone",
	head="Nahtirah Hat",neck="Twilight Torque",ear1="Glorious Earring",ear2="Loquacious Earring",
	body="Piety Briault",hands="Chironic gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
	back="Umbra Cape",waist="Witful Belt",legs="Assiduity pants",feet="Herald's Gaiters"}

sets.idle.Town = {
	main="Bolelabunga",
	head="Befouled Crown",
	body="Ebers Bliaud +1",
	hands="Chironic Gloves",
	legs="Assiduity Pants",
	feet="Herald's Gaiters",
	neck="Orison Locket",
	waist="Luminary Sash",
	left_ear="Nourish. Earring",
	right_ear="Mendi. Earring",
	left_ring="Serket Ring",
	right_ring="Weather. Ring",
	back="Solemnity Cape",}

sets.idle.Weak = {}

-- Defense sets

--[[sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
	head="Ebers cap +1",neck="Twilight Torque",
	body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
	back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
	head="Nahtirah Hat",neck="Twilight Torque",
	body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
	back="Tempered Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}]]

sets.Kiting = {feet="Herald's Gaiters"}

sets.latent_refresh = {waist="Fucho-no-obi"}

-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.
-- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Basic set for if no TP weapon is defined.
sets.engaged = {
	head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
	body="Heka's Kalasiris",hands="Chironic Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
	back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
sets.buff['Divine Caress'] = {hands="Orison Mitts +2",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.english == "Paralyna" and buffactive.Paralyzed then
	-- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
		eventArgs.handled = true
	end
	if spell.skill == 'Healing Magic' then
		gear.default.obi_back = "Mending Cape"
	else
		gear.default.obi_back = "Toro Cape"
	end
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Healing Magic' then
		if Cures:contains(spell.name) then
			if  world.day =='Lightsday' or  world.weather_element == 'Light'  or buffactive == 'Aurorastorm' then
				equip(sets.midcast.CureWithLightWeather)
			elseif buffactive['Afflatus Solace'] then
				equip(sets.midcast.CureSolace)
			end
		end
		if Curagas:contains(spell.name) then
			if  world.day =='Lightsday' or  world.weather_element == 'Light'  or buffactive == 'Aurorastorm' then
				equip(sets.midcast.CureWithLightWeather)
			else
				equip(sets.midcast.Curaga)
			end
		end
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.buff['Divine Caress'])
	end
end


-- Return true if we handled the aftercast work. Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
			return "CureMelee"
		elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
			return "CureSolace"
		elseif spell.skill == "Enfeebling Magic" then
			if spell.type == "WhiteMagic" then
				return "MndEnfeebles"
			else
				return "IntEnfeebles"
			end
		end
	end
end


function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	return idleSet
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
-- function job_update(cmdParams, eventArgs)
-- if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
-- local needsArts =
-- player.sub_job:lower() == 'sch' and
-- not buffactive['Light Arts'] and
-- not buffactive['Addendum: White'] and
-- not buffactive['Dark Arts'] and
-- not buffactive['Addendum: Black']

-- if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
-- if needsArts then
-- send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
-- else
-- send_command('@input /ja "Afflatus Solace" <me>')
-- end
-- end
-- end
-- end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'OffenseMode' then
		if newValue == 'Normal' then
			disable('main','sub')
		else
			enable('main','sub')
		end
	end
end

-- Function to display the current relevant user state when doing an update.
-- -- Return true if display was handled, and you don't want the default info shown.
-- function display_current_job_state(eventArgs)
-- local defenseString = ''
-- if state.Defense.Active then
-- local defMode = state.Defense.PhysicalMode
-- if state.Defense.Type == 'Magical' then
-- defMode = state.Defense.MagicalMode
-- end

-- defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
-- end

-- local meleeString = ''
-- if state.OffenseMode == 'Normal' then
-- meleeString = 'Melee: Weapons locked, '
-- end

-- add_to_chat(122,'Casting ['..state.CastingMode..'], '..meleeString..'Idle ['..state.IdleMode..'], '..defenseString..
-- 'Kiting: '..on_off_names[state.Kiting])

-- eventArgs.handled = true
-- end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
-- Default macro set/book
	set_macro_page(3,5)
end