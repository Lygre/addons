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
	indi_duration = 310
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Magic Burst')
	state.IdleMode:options('Normal', 'PDT')
 
	state.MagicBurst = M(false, 'Magic Burst')
 
	gear.default.weaponskill_waist = "Fotia Belt"
 
	select_default_macro_book()
 
	custom_timers = {}
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
-- Options: Override default values
-- options.CastingModes = {'Normal', 'Resistant'}
-- options.OffenseModes = {'Normal','Staff','Club','StaffACC','ClubACC'}
-- options.DefenseModes = {'Normal'}
-- options.WeaponskillModes = {'Normal'}
-- options.IdleModes = {'Normal','Hybrid','PDT','petPDT'}
-- options.RestingModes = {'Normal'}
-- options.PhysicalDefenseModes = {'PDT'}
-- options.MagicalDefenseModes = {'MDT'}

-- state.Defense.PhysicalMode = 'PDT'

lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II', 'Stonera', 'Thundara', 'Fira', 'Blizzara', 'Aerora', 'Watera'}

-- Default macro set/book
set_macro_page(1, 6)
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------

-- Precast Sets

-- Precast sets to enhance JAs
sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic"}
sets.precast.JA['Bolster'] = {body="Bagua Tunic"}
sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines"}
sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}	

-- Fast cast sets for spells

sets.precast.FC = {main="Solstice",
	range="Dunna",
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	body="Shango Robe",
	hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
	legs="Geomancy Pants",
	feet="Regal Pumps",
	neck="Incanter's Torque",
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
	legs="Geomancy Pants",
	feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
	neck="Incanter's Torque",
	waist="Channeler's Stone",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Lifestream Cape"}

sets.precast.FC.Stoneskin = {}

sets.precast.StatusRemoval = {
	head="Nahtirah Hat",legs="Lengo Pants",ear2="Loquacious Earring",ring1="Prolix Ring",waist="Witful Belt",
}
	   
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {}


-- Midcast Sets

sets.midcast.FastRecast = {}

sets.midcast.Geomancy = {main="Solstice",
	range="Dunna",
	head="Azimuth Hood",
	body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
	hands="Geomancy Mitaines",
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

sets.midcast.StatusRemoval = {
head="",legs=""}

-- Cure potency =
sets.midcast.Cure = {main="Tamaxchi",
	range="Dunna",
	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	body="Shango Robe",
	hands="Weather. Cuffs",
	legs="Geomancy Pants",
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
sets.midcast['Enfeebling Magic'] = {}

sets.midcast.IntEnfeebles = {}

sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

sets.midcast['Dark Magic'] = {}

-- Elemental Magic sets are default for handling low-tier nukes.
sets.midcast.LowTierNuke = {}

sets.midcast.LowTierNuke.Resistant = {}

-- Custom classes for high-tier nukes.
sets.midcast.HighTierNuke = {}

sets.midcast.HighTierNuke.Resistant = {}

-- Sets to return to when not performing an action.

-- Resting sets
sets.resting = {head="Nahtirah Hat",neck="Wiglen Gorget",
body="Artsieq Jubbah",ring1="Sheltered Ring",ring2="Paguroidea Ring",
legs="Nares Trews",feet="Chelona Boots"}


-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

sets.idle.Town = {
	main="Bolelabunga",
	sub="Genbu's Shield",
	range="Dunna",
	head="Befouled Crown",
	body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
	hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
	legs="Assiduity Pants",
	feet="Geomancy Sandals",
	neck="Twilight Torque",
	waist="Fucho-no-Obi",
	left_ear="Etiolation Earring",
	right_ear="Sanare Earring",
	left_ring="Defending Ring",
	right_ring="Vocane Ring",
	back="Lifestream Cape"
}

sets.idle.Field = {main="Bolelabunga",
	range="Dunna",
	head="Befouled Crown",
	body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
	hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
	legs="Assiduity Pants",
	feet="Geomancy Sandals",
	neck="Incanter's Torque",
	waist="Isa Belt",
	left_ear="Digni. Earring",
	right_ear="Mendi. Earring",
	left_ring="Weather. Ring",
	right_ring="Sirona's Ring",
	back="Solemnity Cape",
}

sets.idle.Field.PDT = {}

sets.idle.Weak = {}

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
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

-- Custom spell mapping.
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

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
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

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	return idleSet
end

function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus,oldStatus)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if player.indi and not classes.CustomIdleGroups:contains('Indi')then
		classes.CustomIdleGroups:append('Indi')
		handle_equipping_gear(player.status)
	elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
		classes.CustomIdleGroups:clear()
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Called by the 'update' self-command.

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function select_default_macro_book()
	set_macro_page(3, 4)
end
