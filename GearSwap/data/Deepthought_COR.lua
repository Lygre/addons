-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
	gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
	
	Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
	for ranged weaponskills, but not actually meleeing.
	
	Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	include('organizer-lib')

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	-- Whether to use Luzaf's Ring
	state.LuzafRing = M(true, "Luzaf's Ring")
	state.HarvestMode = M(false, 'Harvest Mode')

	-- Whether a warning has been given for low ammo
	state.warned = M(false)
	
	organizer_items = {
		cards="Trump Card",
		cardcase="Trump card case",
		-- odium="Odium",
		jambiya="Surcouf's Jambiya",
		degen="Demersal Degen",

	}
	
	define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Ranged', 'Melee', 'Acc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')

	gear.RAbullet = "Titanium Bullet"
	gear.WSbullet = "Titanium Bullet"
	gear.MAbullet = "Orichalcum Bullet"
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 15

	
	send_command('bind ^` input /ja "Double-up" <me>')
	send_command('bind !` input /randomdeal')
	send_command('bind @` input /item "Super Revitalizer" <me>')
	send_command('bind ^F1 input /haste <stal>')
	send_command('bind !F1 input /wildcard')
	send_command('bind @F1 input /snakeeye')
	send_command('bind ^F2 input /Fold')


	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's frac +1"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}

	
	sets.precast.CorsairRoll = {range="Compensator",head="Lanun Tricorne +1",hands="Chasseur's gants +1",ring1="Barataria ring",
		back="Camulus's Mantle",legs="Desultor tassets"}
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's gants +1"})
	
	sets.precast.LuzafRing = {ring1="Barataria ring",ring2="Luzaf's Ring"}
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
	
	sets.precast.CorsairShot = {ammo=gear.MAbullet,
		head="Carmine Mask",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Infused earring",
		body="Rawhide Vest",hands="Pursuer's Cuffs",ring1="Etana Ring",ring2="Perception Ring",
		back="Toro Cape",waist="Eschan Stone",legs=gear.deep.cor.herclegs_mab,feet="Lanun Bottes +1" }
	sets.precast.CorsairShot.Resistant = {ammo=gear.QDbullet,
		head="Blood Mask",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Infused earring",
		body="Samnuha Coat",hands="Pursuer's Cuffs",ring1="Acumen Ring",ring2="Arvina Ringlet +1",
		back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.deep.cor.herclegs_mab,feet="Chasseur's bottes +1"}
	sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
		head="Carmine Mask",neck="Sanctity Necklace",ear1="Neritic Earring",ear2="Infused Earring",
		body="Meghanada Cuirie",hands="Pursuer's Cuffs",ring1="Vertigo Ring",ring2="Perception Ring",
		back="Gunslinger's Cape",waist="Yemaya Belt",legs=gear.deep.cor.herclegs_mab,feet="Meghanada Jambeaux +1"}
	
	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], 
		{ring2="Archon Ring"})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head=gear.adhemarhead_melee,
		body="Adhemar jacket",
		legs="Nahtirah Trousers"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body="",hands="",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Camulus's Mantle",waist="Ninurta's Sash",legs="Rawhide Trousers",feet="Carmine Greaves"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	sets.precast.RA = {ammo=gear.RAbullet,
		head="Aurore beret +1",
		body="Skopos Jerkin",hands="Lanun Gants +1",
		waist="Impulse Belt",legs="Nahtirah Trousers",feet="Meghanada Jambeaux +1"}

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating mantle",waist="Fotia Belt",legs="Samnuha tights",feet=gear.hercfeet}


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = sets.precast.WS

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Nahtirah Trousers"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Nahtirah Trousers"})

	sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
		head="Meghanada Visor +1",neck="Ocachi Gorget",ear1="Ishvara Earring",ear2="Neritic Earring",
		body="Meghanada Cuirie",hands="Meghanada Gloves +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Camulus's Mantle",waist="Yemaya Belt",legs="Meghanada Chausses +1",feet="Meghanada Jambeaux +1"}

	sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
		head="Meghanada Visor +1",neck="Sanctity Necklace",ear1="Ishvara Earring",ear2="Infused Earring",
		body="Meghanada Cuirie",hands="Meghanada Gloves +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Camulus's Mantle",waist="Yemaya Belt",legs="Meghanada Chausses +1",feet="Meghanada Jambeaux +1"}


	sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
		head="Laksamana's hat +1",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Infused earring",
		body="Samnuha coat",hands="Pursuer's cuffs",ring1="Acumen Ring",ring2="Arvina ringlet +1",
		back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Lanun Bottes +1"}
	
	sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
		head="Laksamana's Hat +1",neck="Sanctity necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Pursuer's cuffs",ring1="Archon Ring",ring2="Arvina ringlet +1",
		back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet=gear.hercfeet_mab }
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Haruspex Hat",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		waist="Ninurta's Sash",legs=gear.herclegs_dt,feet="Carmine Greaves +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, 
		{main="Chatoyant Staff",sub="Zuuxowu Grip",
		neck="Incanter's torque",ear1="Beatific Earring",
		ring1="Lebeche Ring",ring2="Haoma's Ring",
		back="Solemnity Cape",waist="Bishop's sash"})
		
	-- Ranged gear
	sets.midcast.RA = {ammo=gear.RAbullet,
		head=gear.adhemarhead_melee,neck="Ocachi Gorget",ear1="Neritic Earring",ear2="Enervating Earring",
		body="Laksamana's Frac +1",hands=gear.herchands,ring1="Rajas Ring",ring2="Petrov Ring",
		back="Gunslinger's Cape",waist="Yemaya Belt",legs=gear.herclegs_rng_racc,feet=gear.hercfeet}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {ammo=gear.RAbullet,
		head="Umbani cap",neck="Iqabi necklace",ear1="Clearview Earring",
		body="Chasseur's Frac +1",ring1="Hajduk Ring",ring2="Paqichikaji Ring",
		legs=gear.herclegs_rng_racc})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring1="Defending Ring",ring2="Defending Ring"}
	

	-- Idle sets
	sets.idle = {range="Compensator",ammo=gear.RAbullet,
		head="Rawhide Mask",neck="Loricate Torque +1",ear1="Flashward Earring",ear2="Infused Earring",
		body="Emet Harness",hands="Meghanada Gloves +1",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Camulus's Mantle",waist="Gishdubar sash",legs="Rawhide Trousers",feet="Meghanada Jambeaux +1" }
	
	sets.idle.PDT = {range="Compensator",ammo=gear.RAbullet,
		head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Infused Earring",
		body="Meghanada Cuirie",hands="Meghanada Gloves +1",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Solemnity Cape",waist="Gishdubar sash",legs="Meghanada Chausses +1",feet="Meghanada Jambeaux +1" }

	-- Defense sets
	sets.defense.PDT = {
		range="Compensator",ammo=gear.RAbullet,
		head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Infused Earring",
		body="Meghanada Cuirie",hands="Meghanada Gloves +1",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Solemnity Cape",waist="Gishdubar sash",legs="Meghanada Chausses +1",feet="Meghanada Jambeaux +1" }

	sets.defense.MDT = {
		head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Flashward Earring",ear2="Spellbreaker Earring",
		body="Meghanada Cuirie",hands="Meghanada Gloves +1",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Camulus's Mantle",waist="Gishdubar sash",legs="Meghanada Chausses +1",feet="Meghanada Jambeaux +1" }
	

	sets.Kiting = {feet="Skadi's Jambeaux +1",ring2=gear.DarkRing.PDT}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {range="Compensator",ammo=gear.RAbullet,
		head="Meghanada Visor +1",neck="Clotharius torque",ear1="Dominance Earring",ear2="Brutal Earring",
		body="Emet Harness",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Solemnity Cape",waist="Yemaya Belt",legs="Meghanada Chausses +1",feet="Herculean Boots" }
	
	sets.engaged.Acc = set_combine(sets.engaged,{ammo=gear.RAbullet,
		ear1="Dominance earring",ear2="Brutal Earring",
		body="Meghanada Cuirie",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Grounded Mantle +1",waist="Yemaya Belt",legs="Meghanada Chausses +1",feet="Herculean Boots"})

	sets.engaged.DW = {ammo=gear.RAbullet,
		head="Carmine Mask",neck="Clotharius Torque",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Rawhide Vest",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Camulus's Mantle",waist="Yemaya Belt",legs="Carmine Cuisses",feet="Herculean Boots"}
	
	sets.engaged.DW.Acc = {ammo=gear.RAbullet,
		head=gear.adhemarhead_melee,neck="Sanctity necklace",ear1="Telos earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Grounded Mantle +1",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.hercfeet_melee}

	  sets.Harvest = {body="Field Tunica",hands="Worker Gloves",legs="Field Hose",feet="Field Boots"}

	---sets.engaged.Ranged = {ammo=gear.RAbullet,
	   --- head="Lanun Tricorne +1",neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Volley Earring",
		---body="Laksamana's Frac +1",hands="Manibozho gloves",ring1="Rajas Ring",ring2="Petrov Ring",
		---back="Libeccio mantle",waist="Yemaya Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end

	-- gear sets
	if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
		equip(sets.precast.LuzafRing)
	elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
		classes.CustomClass = 'Acc'
	elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
		if sets.precast.FoldDoubleBust then
			equip(sets.precast.FoldDoubleBust)
			eventArgs.handled = true
		end
	end
end
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairShot' or spell.type == 'WeaponSkill' then	
		if world.day_element == spell.element or world.weather_element == spell.element then
			equip({waist="Hachirin-no-obi"})
		end
		--print(spell.element)
	end
end
function display_roll_info(spell)
	rollinfo = rolls[spell.english]
	local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

	if rollinfo then
		add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
		add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
	end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairRoll' and not spell.interrupted then
		display_roll_info(spell)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
	if buffactive['Transcendancy'] then
		return 'Brew'
	end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
		state.OffenseMode:set('Ranged')
	end
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		if player.equipment.sub then
			  state.CombatForm:set('DW')
		else
			state.CombatForm:reset()
		end
	end
end

function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'Melee' or newValue == 'Acc' then
			disable('main','sub','range')
		else
			enable('main','sub','range')
		end
	end
end

function customize_idle_set(idleSet)
	if state.HarvestMode.value then
		idleSet = set_combine(idleSet, sets.Harvest)
	end
	return idleSet
end
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local msg = ''
	
	msg = msg .. 'Off.: '..state.OffenseMode.current
	msg = msg .. ', Rng.: '..state.RangedMode.current
	msg = msg .. ', WS.: '..state.WeaponskillMode.current
	msg = msg .. ', QD.: '..state.CastingMode.current

	if state.DefenseMode.value ~= 'None' then
		local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
		msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
	end
	
	if state.Kiting.value then
		msg = msg .. ', Kiting'
	end
	
	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end

	if state.SelectNPCTargets.value then
		msg = msg .. ', Target NPCs'
	end

	msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
	
	add_to_chat(122, msg)

	eventArgs.handled = false
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
	rolls = {
		["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
		["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
		["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
		["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
		["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
		["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
		["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
		["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
		["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
		["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
		["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
		["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
		["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
		["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
		["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
		["Drachen Roll"]     = {lucky=4, unlucky=8, bonus="Pet Accuracy"},
		["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
		["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
		["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
		["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
		["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
		["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
		["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
		["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
		["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
		["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
		["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
		["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
		["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
		["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enhancing Magic effect duration"},
		["Runeist's Roll"] = {lucky=4, unlucky=8, bonus="Magic Evasion"},
	}
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.element == 'None' then
				-- physical weaponskills
				bullet_name = gear.WSbullet
			else
				-- magical weaponskills
				bullet_name = gear.MAbullet
			end
		else
			-- Ignore non-ranged weaponskills
			return
		end
	elseif spell.type == 'CorsairShot' then
		bullet_name = gear.QDbullet
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Triple Shot'] then
			bullet_min_count = 3
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
			add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
			return
		elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
	if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
		add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
		eventArgs.cancel = true
		return
	end
	
	-- Low ammo warning.
	if spell.type ~= 'CorsairShot' and state.warned.value == false
		and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
		local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
		--local border = string.repeat("*", #msg)
		local border = ""
		for i = 1, #msg do
			border = border .. "*"
		end
		
		add_to_chat(104, border)
		add_to_chat(104, msg)
		add_to_chat(104, border)

		state.warned:set()
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned:reset()
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 4)
end