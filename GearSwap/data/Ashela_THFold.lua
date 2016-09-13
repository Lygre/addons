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
state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
state.Buff['Trick Attack'] = buffactive['trick attack'] or false
state.Buff['Feint'] = buffactive['feint'] or false

-- TH mode handling
options.TreasureModes = {'None','Tag','SATA','Fulltime'}
state.TreasureMode = 'Tag'

tag_with_th = false	
tp_on_engage = 0
end


-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
-- Options: Override default values
options.OffenseModes = {'Normal', 'Acc', 'iLvl'}
options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
options.RangedModes = {'Normal', 'Acc'}
options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
options.IdleModes = {'Normal'}
options.RestingModes = {'Normal'}
options.PhysicalDefenseModes = {'Evasion', 'PDT'}
options.MagicalDefenseModes = {'MDT'}

state.RangedMode = 'Normal'
state.Defense_PhysicalMode = 'Evasion'

-- Additional local binds
send_command('bind ^` input /ja "Flee" <me>')
send_command('bind ^= gs c cycle treasuremode')
send_command('bind !- gs c cycle targetmode')

select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
if binds_on_unload then
binds_on_unload()
end

send_command('unbind ^`')
send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------

sets.TreasureHunter = {hands="Plunderer's Armlets +1", waist="Chaac Belt", feet="Skulker's Poulaines"}

-- Precast Sets

-- Precast sets to enhance JAs
sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet"}
sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet"}
sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
sets.precast.JA['Hide'] = {body="Rawhide Vest"}
sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Plunderer's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Skulker's Poulaines"}
sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}


sets.precast.JA['Sneak Attack'] = {ammo="Qirmiz Tathlum",
head="Pillager's Bonnet +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
body="Rawhide Vest",hands="Plunderer's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}

sets.precast.JA['Trick Attack'] = {ammo="Qirmiz Tathlum",
head="Pillager's Bonnet +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
body="Rawhide Vest",hands="Plunderer's Armlets +1",ring1="Stormsoul Ring",ring2="Epona's Ring",
back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}


-- Waltz set (chr and vit)
sets.precast.Waltz = {ammo="Sonia's Plectrum",
head="Whirlpool Mask",
body="Rawhide Vest",hands="Plunderer's Armlets +1",
back="Iximulew Cape",legs="Pillager's Culottes +1",feet="Rawhide Boots"}

-- Don't need any special gear for Healing Waltz.
sets.precast.Waltz['Healing Waltz'] = {}

-- Fast cast sets for spells

sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Leyline Gloves",ring1="Prolix Ring",legs="Enif Cosciales"}

sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


-- Ranged snapshot gear
sets.precast.RA = {head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}

       
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
gear.default.weaponskill_neck = "Asperity Necklace"
gear.default.weaponskill_waist = "Caudata Belt"
sets.precast.WS = {
    range="Raider's Bmrng.",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','System: 1 ID: 354 Val: 2',}},
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Rawhide Boots",
    neck="Maskirova Torque",
    waist="Grunfeld Rope",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Rajas Ring",
    right_ring="Rufescent Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},}


-- Specific weaponskill sets. Uses the base set if an appropriate WSMod version isn't found.
sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {head="Felistris Mask",waist=gear.ElementalBelt})
sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})

sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist=gear.ElementalBelt})
sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})

sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",neck="Rancor Collar",
ear1="Brutal Earring",ear2="Moonshade Earring"})
sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist=gear.ElementalBelt})
sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle",feet="Qaaxo Leggings"})
sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {waist=gear.ElementalBelt,feet="Qaaxo Leggings"})
sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="",feet="Qaaxo Leggings"})
sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1",feet="Qaaxo Leggings"})
sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",feet="Qaaxo Leggings"})

sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum", back="Letalis Mantle"})
sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {waist=gear.ElementalBelt})
sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})
sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})
sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})

sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {waist=gear.ElementalBelt})
sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})
sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})
sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
body="Rawhide Vest",legs="Pillager's Culottes +1"})

sets.precast.WS['Aeolian Edge'] = {ammo="Jukukik Feather",
head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
body="Rawhide Vest",hands="Plunderer's Armlets +1",ring1="Acumen Ring",ring2="Demon's Ring",
back="Toro Cape",waist="Chaac Belt",legs="Iuitl Tights",feet="Raider's Poulaines +2"}


-- Midcast Sets

sets.midcast.FastRecast = {
head="Whirlpool Mask",ear2="Loquacious Earring",
body="Rawhide Vest",hands="Plunderer's Armlets +1",
back="Fravashi Mantle",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

-- Specific spells
sets.midcast.Utsusemi = {
head="Whirlpool Mask",neck="Ej Necklace",ear2="Loquacious Earring",
body="Rawhide Vest",hands="Plunderer's Armlets +1",ring1="Beeline Ring",
back="Fravashi Mantle",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

-- Ranged gear
sets.midcast.RA = {
head="Whirlpool Mask",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Hajduk Ring",
back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

sets.midcast.RA.Acc = {
head="Pillager's Bonnet +1",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
body="Iuitl Vest",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Hajduk Ring",
back="Libeccio Mantle",waist="Aquiline Belt",legs="Thurandaut Tights +1",feet="Pillager's Poulaines +1"}

sets.midcast.RA.TH = set_combine(sets.midcast.RA, sets.TreasureHunter)

sets.midcast.RA.TH.Acc = set_combine(sets.midcast.RA.Acc, sets.TreasureHunter)

-- Sets to return to when not performing an action.

-- Resting sets
sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
ring1="Sheltered Ring",ring2="Paguroidea Ring"}


-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

sets.idle = {range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Trotter Boots",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}

sets.idle.Town = {range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Trotter Boots",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}

sets.idle.Weak = {range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Jute Boots +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}

sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}

-- Defense sets

sets.defense.Evasion = {
head="Pillager's Bonnet +1",neck="Ej Necklace",
body="Emet Harness",hands="Plunderer's Armlets +1",ring1="Beeline Ring",ring2="Dark Ring",
back="Fravashi Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

sets.defense.PDT = {ammo="Iron Gobbet",
head="Pillager's Bonnet +1",neck="Twilight Torque",
body="Iuitl Vest",hands="Plunderer's Armlets +1",ring1="Beeline Ring",ring2="Dark Ring",
back="Iximulew Cape",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}

sets.defense.MDT = {ammo="Demonry Stone",
head="Pillager's Bonnet +1",neck="Twilight Torque",
body="Rawhide Vest",hands="Plunderer's Armlets +1",ring1="Dark Ring",ring2="Shadow Ring",
back="Engulfer Cape",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}

sets.Kiting = {feet="Skadi's Jambeaux +1"}

-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.
-- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Normal melee group
sets.engaged = {
    
    range="Raider's Bmrng.",
    head="Adhemar Bonnet",
    body="Adhemar Jacket",
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Rawhide Boots",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}
sets.engaged.Acc = {
   
    range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Taeon Boots", augments={'"Triple Atk."+1',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}
sets.engaged.Evasion = {
    
    range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Taeon Boots", augments={'"Triple Atk."+1',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}
sets.engaged.Acc.Evasion = {
    
    range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Taeon Boots", augments={'"Triple Atk."+1',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}
sets.engaged.PDT = {
    
    range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Taeon Boots", augments={'"Triple Atk."+1',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}
sets.engaged.Acc.PDT = {
    main={ name="Taming Sari", augments={'STR+9','DEX+8','DMG:+14',}},
    sub={ name="Taming Sari", augments={'STR+5','DEX+6','DMG:+10',}},
    range="Raider's Bmrng.",
    head="Skormoth Mask",
    body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}},
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Taeon Boots", augments={'"Triple Atk."+1',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back={ name="Canny Cape", augments={'DEX+1','AGI+2','"Dual Wield"+4','Crit. hit damage +2%',}},
}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
if spell.type == 'Waltz' then
refine_waltz(spell, action, spellMap, eventArgs)
elseif spell.action_type == 'Ranged Attack' then
if state.TreasureMode ~= 'None' then
classes.CustomClass = 'TH'
end
end

if state.Buff[spell.english] ~= nil then
state.Buff[spell.english] = true
end
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
if spell.type == 'Step' or spell.type == 'Flourish1' then
if state.TreasureMode ~= 'None' then
equip(sets.TreasureHunter)
end
elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
equip(sets.TreasureHunter)
end
end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
if state.Buff[spell.english] ~= nil then
state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
end

-- Update the state of certain buff JAs if the action wasn't interrupted.
if not spell.interrupted then
-- Don't let aftercast revert gear set for SA/TA/Feint
if S{'Sneak Attack', 'Trick Attack', 'Feint'}:contains(spell.english) then
eventArgs.handled = true
end

-- If this wasn't an action that would have used up SATA/Feint, make sure to put gear back on.
if spell.type ~= 'WeaponSkill' and spell.type ~= 'Step' then
-- If SA/TA/Feint are active, put appropriate gear back on (including TH gear).
if state.Buff['Sneak Attack'] then
equip(sets.precast.JA['Sneak Attack'])
if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
equip(sets.TreasureHunter)
end
eventArgs.handled = true
elseif state.Buff['Trick Attack'] then
equip(sets.precast.JA['Trick Attack'])
if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
equip(sets.TreasureHunter)
end
eventArgs.handled = true
elseif state.Buff['Feint'] then
equip(sets.precast.JA['Feint'])
if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
equip(sets.TreasureHunter)
end
eventArgs.handled = true
end
end

if spell.target and spell.target.type == 'Enemy' then
tag_with_th = false
tp_on_engage = 0
elseif (spell.type == 'Waltz' or spell.type == 'Samba') and tag_with_th then
-- Update current TP if we spend TP before we actually hit the mob
tp_on_engage = player.tp
end
end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets construction.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
local wsmode = ''
if state.Buff['Sneak Attack'] then
wsmode = 'SA'
end
if state.Buff['Trick Attack'] then
wsmode = wsmode .. 'TA'
end

if wsmode ~= '' then
return wsmode
end
end

function customize_idle_set(idleSet)
if player.hpp < 80 then
idleSet = set_combine(idleSet, sets.ExtraRegen)
end

return idleSet
end

function customize_melee_set(meleeSet)
if state.TreasureMode == 'Fulltime' or tag_with_th then
meleeSet = set_combine(meleeSet, sets.TreasureHunter)
end

return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
check_range_lock()

-- If engaging, put on TH gear.
-- If disengaging, turn off TH tagging.
if newStatus == 'Engaged' and state.TreasureMode ~= 'None' then
equip(sets.TreasureHunter)
tag_with_th = true
tp_on_engage = player.tp
send_command('wait 3;gs c update th')
elseif oldStatus == 'Engaged' then
tag_with_th = false
tp_on_engage = 0
end

-- If SA/TA/Feint are active, don't change gear sets
if satafeint_active() then
eventArgs.handled = true
end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
if state.Buff[buff] ~= nil then
state.Buff[buff] = gain

if not satafeint_active() then
handle_equipping_gear(player.status)
end
end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
check_range_lock()

if state.TreasureMode == 'None' then
tag_with_th = false
tp_on_engage = 0
elseif tag_with_th and player.tp ~= tp_on_engage then
tag_with_th = false
tp_on_engage = 0
elseif cmdParams[1] == 'th' and player.status == 'Engaged' then
send_command('wait 3;gs c update th')
end

-- Update the current state of state.Buff, in case buff_change failed
-- to update the value.
state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
state.Buff['Trick Attack'] = buffactive['trick attack'] or false
state.Buff['Feint'] = buffactive['feint'] or false

-- Don't allow normal gear equips if SA/TA/Feint is active.
if satafeint_active() then
eventArgs.handled = true
end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
local defenseString = ''
if state.Defense.Active then
local defMode = state.Defense.PhysicalMode
if state.Defense.Type == 'Magical' then
defMode = state.Defense.MagicalMode
end

defenseString = 'Defense: '..state.Defense.Type..' '..defMode..' '
end

add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..' WS: '..state.WeaponskillMode..' '..
defenseString..'Kiting: '..on_off_names[state.Kiting]..' TH: '..state.TreasureMode)

eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
if player.equipment.range ~= 'empty' then
disable('range', 'ammo')
else
enable('range', 'ammo')
end
end

-- Function to indicate if any buffs have been activated that we don't want to equip gear over.
function satafeint_active()
return state.Buff['Sneak Attack'] or state.Buff['Trick Attack'] or state.Buff['Feint']
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
-- Default macro set/book
if player.sub_job == 'DNC' then
set_macro_page(2, 5)
elseif player.sub_job == 'WAR' then
set_macro_page(3, 5)
elseif player.sub_job == 'NIN' then
set_macro_page(4, 5)
else
set_macro_page(2, 5)
end
end

