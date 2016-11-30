-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

-- Load and initialize the include file.
include('Mote-Include.lua')
include('organizer-lib')

end

-- Setup vars that are user-independent.
function job_setup()
state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end


-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Magic Burst')
    state.IdleMode:options('Normal', 'PDT')
	state.Skillup = M(false, 'Boost Spell')


select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------

-- Precast Sets

-- Fast cast sets for spells
sets.precast.FC = {main="Grioavolr",sub="Vivid Strap +1",ammo="Sapience Orb",
head="Nahtirah Hat",neck="Orison Locket",ear1="Enhanter Earring +1",ear2="Loquacious Earring",
body="Shango Robe",hands="Gendewitha Gages",ring1="Prolix Ring",
back="Swith Cape +1",waist="Witful Belt",legs="Orvail Pants +1",feet="Regal Pumps"}

sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons"})

sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Serenity",sub="Vivid Strap +1",feet="Hygieia Clogs"})

sets.precast.FC.Curaga = sets.precast.FC.Cure

-- Precast sets to enhance JAs
sets.precast.JA.Benediction = {body="Piety Briault"}

-- Waltz set (chr and vit)
sets.precast.Waltz = {
head="Nahtirah Hat",ear1="Roundel Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",
back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


-- Weaponskill sets

-- Default set for any weaponskill that isn't any more specifically defined
gear.default.weaponskill_neck = "Asperity Necklace"
gear.default.weaponskill_waist = ""
sets.precast.WS = {
head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

sets.precast.WS['Flash Nova'] = {
head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


-- Midcast Sets

sets.midcast.FastRecast = {
head="Nahtirah Hat",ear2="Loquacious Earring",
body="Heka's Kalasiris",hands="Dynasty Mitts",ring1="Prolix Ring",
back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

-- Cure sets
gear.default.obi_waist = "Goading Belt"
gear.default.obi_back = "Mending Cape"

sets.midcast.CureSolace = {main="Serenity",sub="Vivid Strap +1",ammo="Incantor Stone",
head="Ebers Cap",neck="Orison Locket",ear1="Loquacious Earring",ear2="Glorious Earring",
body="Ebers Bliaut",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Medium's Sabots"}

sets.midcast.Cure = {main="Serenity",sub="Vivid Strap +1",ammo="Incantor Stone",
head="Ebers Cap",neck="Orison Locket",ear1="Loquacious Earring",ear2="Glorious Earring",
body="Heka's Kalasiris",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Medium's Sabots"}

sets.midcast.Curaga = {main="Serenity",sub="Vivid Strap +1",ammo="Incantor Stone",
head="Ebers Cap",neck="Orison Locket",ear1="Loquacious Earring",ear2="Glorious Earring",
body="Heka's Kalasiris",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Medium's Sabots"}

sets.midcast.CureMelee = {ammo="Incantor Stone",
head="Ebers Cap",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Orison Earring",
body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Medium's Sabots"}

sets.midcast.Cursna = {main="Beneficus",sub="Vivid Strap +1",
head="Ebers Cap",neck="Malison Medallion",
body="Ebers Bliaud",hands="Hieros Mittens",ring1="Ephedra Ring",ring2="Sirona's Ring",
back="Mending Cape",waist="Goading Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

sets.midcast.StatusRemoval = {
head="Ebers Cap",legs="Ebers Pantaloons"}

-- 110 total Enhancing Magic Skill; caps even without Light Arts
sets.midcast['Enhancing Magic'] = {main="Beneficus",sub="Vivid Strap +1",
head="Telchine cap",neck="Incanter's Torque",
body="Telchine Chasuble",hands="Dynasty Mitts",
back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Telchine pigaches"}

sets.midcast.Stoneskin = {
head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
body="Heka's Kalasiris",hands="Dynasty Mitts",
back="Swith Cape +1",waist="Siegel Sash",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

sets.midcast.Auspice = {hands="Dynasty Mitts",feet="Orison Duckbills +2"}

sets.midcast.BarElement = {main="Beneficus",sub="Genmei Shield",
head="Ebers Cap",neck="Incanter's Torque",
body="Ebers Bliaud",hands="Ebers Mitts",
back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +2"}

sets.midcast.Regen = {main="Bolelabunga",sub="Genmei Shield",
body="Telchine Chasuble",hands="Ebers Mitts",
legs="Theophany Pantaloons"}

sets.midcast.Protectra = {ring1="Sheltered Ring",feet="Piety Duckbills"}

sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Vivid Strap +1",
head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Vivid Strap +1",
head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills"}

-- Custom spell classes
sets.midcast.MndEnfeebles = {main="Marin Staff", sub="Mephitis Grip",
head="",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
body="Cohort Cloak",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills"}

sets.midcast.IntEnfeebles = {main="Marin Staff", sub="Mephitis Grip",
head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills"}


-- Sets to return to when not performing an action.

-- Resting sets
sets.resting = {main=gear.Staff.HMP,
body="Gendewitha Bliaut",hands="Serpentes Cuffs",
waist="Austerity Belt",legs="Assiduity Pants +1",feet="Chelona Boots +1"}


-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
sets.idle = {main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
head="Befouled Crown",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Loquacious Earring",
body="Witching Robe",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Vocane ring",
back="Solemnity Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

sets.idle.PDT = {main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Loquacious Earring",
body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
back="Solemnity Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Herald's Gaiters"}

sets.idle.Town = {main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
head="Ebers Cap",neck="Loricate Torque +1",ear1="Glorious Earring",ear2="Loquacious Earring",
body="Vrikodara Jupon",hands="Gendewitha Gages",ring1="Sheltered Ring",ring2="Paguroidea Ring",
back="Solemnity Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Incantor Stone",
head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Bloodgem Earring",ear2="Loquacious Earring",
body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
back="Solemnity Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes"}

-- Defense sets

sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
head="Ebers Cap",neck="Loricate Torque +1",
body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
back="Solemnity Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
head="Nahtirah Hat",neck="Loricate Torque +1",
body="Heka's Kalasiris",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
back="Tuilha Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

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
body="Heka's Kalasiris",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
back="Solemnity Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
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
-- function job_buff_change(buff, gain)
-- if state.Buff[buff] ~= nil then
-- state.Buff[buff] = gain
-- end
-- end

function job_buff_change(buff, gain)
	if state.Skillup.value then
		if not buffactive['STR Boost'] then
			if buff == 'STR Boost' and gain == false then
				send_command('input /ma "Boost-STR" <me>')
			end
		send_command('input /ma "Boost-STR" <me>')
		end
	end
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
elseif stateField == 'Reset' then
if state.OffenseMode == 'None' then
enable('main','sub')
end
end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
set_macro_page(4, 14)
end