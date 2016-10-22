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
function job_setup()
	state.Buff.Sentinel = buffactive.sentinel or false
	state.Buff.Cover = buffactive.cover or false
	state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal','Reraise')
	--Setting this to true causes the lua to change between aegis or ochain when MDT or PDT Defense modes are active, respectively
	state.ShieldMode = M{['description']='Shield Select', 'Aegis', 'Ochain'}
	-- state.ShieldMode:options('Aegis','Ochain')
	--
	update_defense_mode()

	send_command('bind ^!` gs c cycle ShieldMode')
	select_default_macro_book()
end

function user_unload()
	send_command('unbind ^!`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------
		sets.midcast.Enmity = {
	ammo="sapience orb",
	head="Loess Barbuta",
	body="Souveran Cuirass",
	hands="Souveran Handschuhs",
	legs="Souveran Diechlings",
	feet="Souveran Schuhs",
	neck="Unmoving Collar +1",
	waist="Creed Baudrier",
	left_ear="Friomisi Earring",
	right_ear="Cryptic Earring",
	left_ring="Apeile Ring",
	right_ring="Apeile Ring +1",
	back="Reiki Cloak",
}

	sets.precast.JA.Provoke = sets.midcast.Enmity
	sets.precast.JA.Warcry = sets.midcast.Enmity
	sets.precast.JA.Sentinel = sets.midcast.Enmity
	sets.precast.JA.Rampart = sets.midcast.Enmity
	sets.precast.JA.Fealty = sets.midcast.Enmity	
	sets.precast.JA.DivineEmblem = sets.midcast.Enmity
	sets.precast.JA.Palisade = sets.midcast.Enmity
	sets.precast.JA.Cover = sets.midcast.Enmity
	sets.precast.JA.Chivalry = sets.midcast.Enmity
   
   -- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
	sets.precast.JA['Holy Circle'] = {--[[feet="Reverence Leggings +1"]]}
	sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
	sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
	sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
	sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
	sets.precast.JA['Divine Emblem'] = {feet="Chevalier's Sabatons +1"}
	sets.precast.JA['Cover'] = {--[[head="Reverence Coronet +1"]]}

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = {
		--[[head="Reverence Coronet +1",
		body="Caballarius Surcoat +1",hands="Caballarius gauntlets",ring1="Globidonta Ring",
		back="Weard Mantle",legs="Caballarius breeches +1",feet="Whirlpool Greaves"]]}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {--[[ammo="Sonia's Plectrum",
		head="Reverence Coronet +1",
		body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"]]}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {waist="Chaac Belt"}
	sets.precast.Flourish1 = {waist="Chaac Belt"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
	ammo="sapience orb",
	head=gear.zadora.odhead_fc,
	body=gear.zadora.odbody_fc,
	hands="Leyline Gloves",
	legs=gear.zadora.odlegs_fc,
	feet=gear.zadora.odfeet_fc,
	neck="Voltsurge Torque",
	waist="Tempus Fugit",
	left_ear="Etiolation Earring",
	right_ear="Loquac. Earring",
	left_ring="Defending Ring",
	right_ring="Rahab Ring",
	back=gear.zadora.pldcape_fc,
	}

	

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	ammo="Ginsen",
	head="Ynglinga Sallet",
	body="Souveran Cuirass",
	hands="Flamma Manopolas +1",
	legs="Sulevi. Cuisses +1",
	feet="Sulev. Leggings +1",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Telos Earring",
	right_ear="Brutal Earring",
	left_ring="Rufescent Ring",
	right_ring="Hetairoi Ring",
	back=gear.zadora.pldcape_cure,
}

	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {feet="thereoid greaves"})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Digni. Earring",
		body="Jumalik Mail",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Archon Ring",
		back="Toro Cape",waist="Eschan Stone",legs="Souveran Diechlings",feet="Sulevia's Leggings +1"}
	
	sets.precast.WS['Atonement'] = set_combine(sets.precast.WS,{ammo="sapience orb",
		neck=gear.ElementalGorget,
		back="Fierabras's Mantle",waist=gear.ElementalBelt,})
	 
	
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {
	ammo="sapience orb",
	head="Souveran Schaller",
	body="Souveran Cuirass",
	hands="Leyline Gloves",
	legs=gear.zadora.odlegs_fc,
	feet="Souveran Schuhs",
	neck="Voltsurge Torque",
	waist="Tempus Fugit",
	left_ear="Trux Earring",
	right_ear="Brutal Earring",
	left_ring="Defending Ring",
	right_ring="Rahab Ring",
	back=gear.zadora.pldcape_fc,}

		

	sets.midcast.Phalanx = set_combine(sets.midcast.Enmity, {
	    head=gear.zadora.valhead_phalanx,
		hands="Souveran Handschuhs",
		feet="Souveran Schuhs",
		-- legs={ name="Yorium Cuisses", augments={'"Store TP"+6','Phalanx +3',}},
		back="Weard Mantle",})
	
	
	sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
	
	sets.midcast.Stun = sets.midcast.Flash
	
	sets.midcast.Cure = set_combine(sets.midcast.Enmity, {
	    head=gear.zadora.odhead_fc, neck="Phalaina Locket", ear2="Odnowa Earring",
		body="Souveran Cuirass",
		hands="Macabre gauntlets +1", 
		feet=gear.zadora.odfeet_cure,
		legs="Souveran Diechlings",
		back=gear.zadora.pldcape_cure})
	     
		
		
	sets.midcast.Diaga = set_combine(sets.midcast.Enmity, {})

	sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})

	sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque",waist="Olympus Sash"}
	
	sets.midcast.Protect = {ring1="Sheltered Ring"}
	sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	sets.resting = {neck="Creed Collar",
		ring1="Sheltered Ring",ring2="Paguroidea Ring",
		waist="Austerity Belt"}
	
  
	-- Idle sets
	sets.idle = {
	ammo="Homiliary",
	head="Loess Barbuta",
	body="Souveran Cuirass",
	hands="Souveran Handschuhs",
	legs="Souveran Diechlings",
	feet="Souveran Schuhs",
	neck="Sanctity Necklace",
	waist="Creed Baudrier",
	left_ear="Infused Earring",
	right_ear="Cryptic Earring",
	left_ring="Defending Ring",
	right_ring="Patricius Ring",
	back=gear.zadora.pldcape_cure,
	
}
	sets.idle.Town = {
	ammo="Homiliary",
	head="Loess Barbuta",
	body="Souveran Cuirass",
	hands="Souveran Handschuhs",
	legs="Souveran Diechlings",
	feet="Souveran Schuhs",
	neck="Sanctity Necklace",
	waist="Creed Baudrier",
	left_ear="Infused Earring",
	right_ear="Cryptic Earring",
	left_ring="Defending Ring",
	right_ring="Patricius Ring",
	back=gear.zadora.pldcape_cure,
}
	
	sets.idle.Weak = {
	ammo="Homiliary",
	head="Loess Barbuta",
	body="Souveran Cuirass",
	hands="Souveran Handschuhs",
	legs="Souveran Diechlings",
	feet="Souveran Schuhs",
	neck="Sanctity Necklace",
	waist="Creed Baudrier",
	left_ear="Infused Earring",
	right_ear="Cryptic Earring",
	left_ring="Defending Ring",
	right_ring="Patricius Ring",
	back=gear.zadora.pldcape_cure,
	}
	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	sets.idle.Reraise = set_combine(sets.idle,sets.Reraise)
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}


	--------------------------------------
	-- Defense sets
	--------------------------------------
	
	-- Extra defense sets.  Apply these on top of melee or defense sets.
	-- sets.Knockback = {back="Repulse Mantle"}
	-- sets.MP = {neck="Creed Collar",waist="Flume Belt +1"}
	-- sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt +1",back="Repulse Mantle"}
	
	-- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
	-- when activating or changing defense mode:
	sets.PhysicalShield = {sub="Ochain"} -- Ochain
	sets.MagicalShield = {sub="Aegis"} -- Aegis

	-- Basic defense sets.
		
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Souveran Cuirass",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2="Fortified Ring",
		back=gear.zadora.pldcape_cure,legs="Sulevia's Cuisses +1",feet="Souveran Schuhs"}
	-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
	-- Shellra V can provide 75/256, which would need another 53/256 in gear.
	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Souveran Cuirass",hands="Souveran Handschuhs",ring1="Defending Ring",ring2="Shadow Ring",
		back=gear.zadora.pldcape_cure,waist="Creed Baudrier",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	
	sets.engaged = {
	ammo="Hasty Pinion +1",
	head="Flamma Zucchetto +1",
	body="Valorous Mail",
	hands="Flamma Manopolas +1",
	legs="Sulevi. Cuisses +1",
	feet="Flamma Gambieras +1",
	neck="Creed Collar",
	waist="Kentarch Belt",
	left_ear="Telos Earring",
	right_ear="Cessance Earring",
	left_ring="Defending Ring",
	right_ring="Fortified Ring",
	back="Weard Mantle",
}

	sets.engaged.Acc = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gorney Haubert +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Weard Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

	sets.engaged.DW = {ammo="Ginsen",
		head="Otomi Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Gorney Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Cetl Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

	sets.engaged.DW.Acc = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Gorney Haubert +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Weard Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

	sets.engaged.PDT = set_combine(sets.engaged, {neck="Loricate Torque +1",ring1="Defending Ring"})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {neck="Loricate Torque +1",ring1="Defending Ring"})
	sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
	sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

	sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {neck="Loricate Torque +1",ring1="Defending Ring"})
	sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {neck="Loricate Torque +1",ring1="Defending Ring"})
	sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
	sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Doom = {ring2="Saida Ring"}
	sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- function job_midcast(spell, action, spellMap, eventArgs)
-- 	-- If DefenseMode is active, apply that gear over midcast
-- 	-- choices.  Precast is allowed through for fast cast on
-- 	-- spells, but we want to return to def gear before there's
-- 	-- time for anything to hit us.
-- 	-- Exclude Job Abilities from this restriction, as we probably want
-- 	-- the enhanced effect of whatever item of gear applies to them,
-- 	-- and only one item should be swapped out.
-- 	if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
-- 		handle_equipping_gear(player.status)
-- 		eventArgs.handled = true
-- 	end
-- end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
	if field == 'Shield Select' then
		handle_equipping_gear(player.status)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_defense_mode()
	handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	
	if state.ShieldMode.value == 'Aegis' then
		idleSet = set_combine(idleSet, sets.MagicalShield)
	elseif state.ShieldMode.value == 'Ochain' then
		idleSet = set_combine(idleSet, sets.PhysicalShield)
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	if state.CombatForm.value ~= 'DW' then
		if state.ShieldMode.value == 'Aegis' then
			meleeSet = set_combine(meleeSet, sets.MagicalShield)
		elseif state.ShieldMode.value == 'Ochain' then
			meleeSet = set_combine(meleeSet, sets.PhysicalShield)
		end
	end
	return meleeSet
end

function customize_defense_set(defenseSet)
	--Because of this, make any extra defense mode sets to be defined by only the gear to be combined with correct DEF mode set.	
	if state.Buff.Doom then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	
	if state.ShieldMode.value == 'Aegis' then
		defenseSet = set_combine(defenseSet, sets.MagicalShield)
	elseif state.ShieldMode.value == 'Ochain' then
		defenseSet = set_combine(defenseSet, sets.PhysicalShield)
	end
	
	return defenseSet
end


function display_current_job_state(eventArgs)
	local msg = 'Melee'
	
	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end
	
	msg = msg .. ': '
	
	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ', WS: ' .. state.WeaponskillMode.value
	
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	if state.ShieldMode.value then 
		msg = msg .. ' Shield:['..state.ShieldMode.value..']'
	end
	-- if state.EquipShield.value == true then
		-- msg = msg .. ', Force Equip Shield'
	-- end
	
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

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
	-- if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
	-- 	classes.CustomDefenseGroups:append('Kheshig Blade')
	-- end
	
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		if player.equipment.sub and (not player.equipment.sub:contains('Shield')) and
		   player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
			state.CombatForm:set('DW')
		else
			state.CombatForm:reset()
		end
	end
end 


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
		set_macro_page(6, 7)
end

