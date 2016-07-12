-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
	Custom commands:
	
	gs c step
		Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

	gs c step t
		Uses the currently configured step on the target, but forces use of <t>.
	
	
	Configuration commands:
	
	gs c cycle mainstep
		Cycles through the available steps to use as the primary step when using one of the above commands.
		
	gs c cycle altstep
		Cycles through the available steps to use for alternating with the configured main step.
		
	gs c toggle usealtstep
		Toggles whether or not to use an alternate step.
		
	gs c toggle selectsteptarget
		Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
	state.Buff['Striking Flourish'] = buffactive['Striking flourish'] or false

	state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
	state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
	state.UseAltStep = M(false, 'Use Alt Step')
	state.SelectStepTarget = M(false, 'Select Step Target')
	state.IgnoreTargetting = M(false, 'Ignore Targetting')

	state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
	state.SkillchainPending = M(false, 'Skillchain Pending')

	determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')


	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"

	-- Additional local binds
	send_command('bind ^= gs c cycle mainstep')
	send_command('bind != gs c cycle altstep')
	send_command('bind ^- gs c toggle selectsteptarget')
	send_command('bind !- gs c toggle usealtstep')
	send_command('bind ^` input /ja "Chocobo Jig" <me>')
	send_command('bind !` input /ja "Chocobo Jig II" <me>')

	organizer_items = {skinf="Skinflayer"}
	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind ^-')
	send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs

	sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"}

	sets.precast.JA['Trance'] = {head="Horos Tiara"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Horos Tiara",ear1="Roundel Earring",
		body="Maxixi Casaque",hands="Buremte Gloves",ring1="Asklepian Ring",
		back=gear.dnccape_tp,waist="Caudata Belt",legs="Samnuha Tights",feet="Rawhide Boots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Samba = {--[[head="Maxixi Tiara",]]back=gear.dnccape_tp}

	sets.precast.Jig = {legs="Horos Tights +1", feet="Maxixi Toe Shoes"}

	sets.precast.Step = {waist="Chaac Belt"}
	sets.precast.Step['Feather Step'] = {feet="Charis Shoes +2"}

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {ear1="Dignitary's Earring",ear2="Gwati Earring",
		body="Horos Casaque +1",hands="Buremte Gloves",ring1="Weatherspoon Ring", ring2="Sangoma Ring",
		waist="Chaac Belt",legs="Rawhide Trousers",feet=gear.hercfeet_acc} -- magic accuracy
	sets.precast.Flourish1['Desperate Flourish'] = {ammo="Charis Feather",
		head="Dampening Tam",neck="Combatant's Torque",
		body="Horos Casaque +1",hands="Buremte Gloves",ring1="Beeline Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet=gear.hercfeet_acc} -- acc gear

	sets.precast.Flourish2 = {}
	sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +1"}

	sets.precast.Flourish3 = {}
	sets.precast.Flourish3['Striking Flourish'] = {body="Maculele Casaque +1"}
	sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Sapience Orb",
		neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody, hands="Leyline Gloves",ring1="Rahab Ring", ring2="Weatherspoon Ring",
		legs="Rawhide Trousers" }

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Charis feather",
		head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Adhemar jacket",hands="Meghanada gloves +1",ring1="Rajas Ring",ring2="Petrov Ring",
		back=gear.dnccape_ws,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Falcon Eye", back=gear.dnccape_tp})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Houyi's Gorget",
		hands="Adhemar Wristbands",ring1="Stormsoul Ring",
		waist="Caudata Belt",legs="Samnuha Tights"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Falcon Eye", back=gear.dnccape_tp})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {waist=gear.ElementalBelt})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {hands="Adhemar Wristbands"})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {hands="Adhemar Wristbands"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Falcon Eye", back=gear.dnccape_tp})

	sets.precast.WS['Rudra\'s Storm'] = {ammo="Charis feather",
		head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Adhemar jacket",hands="Meghanada gloves +1",ring1="Rajas Ring",ring2="Petrov Ring",
		back=gear.dnccape_ws,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS["Rudra's Storm"], 
		{ammo="Falcon Eye"})

	sets.precast.WS['Aeolian Edge'] = {}
	
	sets.precast.Skillchain = {hands="Maculele Bangles +1"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head=gear.adhemarhead_melee,ear2="Loquacious Earring",
		body="Samnuha Coat",hands="Adhemar Wristbands",
		legs="Samnuha Tights",feet=gear.hercfeet_acc}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head=gear.adhemarhead_melee,neck="Combatant's Torque",ear2="Loquacious Earring",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Beeline Ring",
		back=gear.dnccape_tp,legs="Samnuha Tights",feet=gear.hercfeet_acc}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {neck="Loricate Torque +1",
		ring1="Defending Ring",ring2=gear.DarkRing.PDT}
	sets.ExtraRegen = {}
	

	-- Idle sets

	sets.idle = {ammo="Brigantia Pebble",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Samnuha Tights",feet="Skadi's Jambeaux +1"}

	sets.idle.Town = {main="Izhiikoh", sub="Sabebus",ammo="Charis Feather",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Bleating Mantle",waist="Reiki Yotai",legs="Samnuha Tights",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Weak = {ammo="Iron Gobbet",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Buremte Gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Samnuha Tights",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets

	sets.defense.Evasion = {
		head=gear.adhemarhead_melee,neck="Combatant's Torque",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2=gear.DarkRing.PDT,
		back=gear.dnccape_tp,waist="Flume Belt +1",legs="Samnuha Tights",feet=gear.hercfeet_acc}

	sets.defense.PDT = {ammo="Brigantia Pebble",
		head="Lithelimb cap",neck="Loricate Torque +1",ear1="Genmei Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Samnuha Tights",feet="Ahosi Leggings"}

	sets.defense.MDT = {ammo="Vanir Battery",
		head="Dampening Tam",neck="Warder's charm",ear1="Sanare Earring",ear2="Zennaroi Earring",
		body="Adhemar jacket",hands="Wayfarer Cuffs",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Engulfer Cape",waist="Flume Belt +1",legs="Samnuha Tights",feet="Ahosi Leggings"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Asperity necklace",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Reiki Yotai",legs="Meghanada chausses +1",feet=gear.hercfeet_melee}
	sets.engaged.Acc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Asperity necklace",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Maculele Casaque +1",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.Evasion = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Combatant's Torque",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.PDT = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.Evasion = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}

	-- Custom melee group: High Haste (2x March or Haste)
	sets.engaged.LowHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meghanada chausses +1",feet=gear.hercfeet_ta}
	sets.engaged.Acc.LowHaste = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.Evasion.LowHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Combatant's Torque",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.Evasion.LowHaste = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.PDT.LowHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.PDT.LowHaste = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
 
	-- Custom melee group: High Haste (2x March or Haste)
	sets.engaged.HighHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Reiki Yotai",legs="Meghanada chausses +1",feet=gear.hercfeet_melee }
	sets.engaged.Acc.HighHaste = {ammo="Ginsen",
		head="Meghanada visor +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.Evasion.HighHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Combatant's Torque",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.PDT.HighHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}

	-- Custom melee group: Max Haste (2x March + Haste)
	sets.engaged.MaxHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Hetairoi Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Windbuffet Belt +1",legs="Meghanada chausses +1",feet=gear.hercfeet_ta}
	sets.engaged.Acc.MaxHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet=gear.hercfeet_ta }
	sets.engaged.Evasion.MaxHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Combatant's Torque",ear1="Brutal Earring",ear2="Telos Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Telos Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}
	sets.engaged.PDT.MaxHaste = {ammo="Charis Feather",
		head=gear.adhemarhead_melee,neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Telos Earring",
		body="Adhemar jacket",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Solemnity Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.hercfeet_acc}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Telos Earring",
		body="Samnuha Coat",hands="Adhemar Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back=gear.dnccape_tp,waist="Olseni Belt",legs="Samnuha Tights",feet="Meghanada jambeaux +1"}



	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {legs="Horos Tights +1"}
	sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1"}
	sets.buff['Striking Flourish'] = {body="Maculele Casaque +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == "WeaponSkill" then
		if state.Buff['Climactic Flourish'] then
			equip(sets.buff['Climactic Flourish'])
		end
		if state.Buff['Striking Flourish'] then
			equip(sets.buff['Striking Flourish'])
		end
		if state.SkillchainPending.value == true then
			equip(sets.precast.Skillchain)
		end
	end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == "Wild Flourish" then
			state.SkillchainPending:set()
			send_command('wait 5;gs c unset SkillchainPending')
		elseif spell.type:lower() == "weaponskill" then
			state.SkillchainPending:toggle()
			send_command('wait 6;gs c unset SkillchainPending')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
		handle_equipping_gear(player.status)
	end
end


function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		determine_haste_group()
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
end


function customize_idle_set(idleSet)
	if player.hpp < 80 and not areas.Cities:contains(world.area) then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	return idleSet
end

function customize_melee_set(meleeSet)
	if state.DefenseMode.value ~= 'None' then
		if buffactive['saber dance'] then
			meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
		end
		if state.Buff['Climactic Flourish'] then
			meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
		end
		if state.Buff['Striking Flourish'] then
			meleeSet = set_combine(meleeSet, sets.buff['Striking Flourish'])
		end
	end
	
	return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
	if spell.type == 'Step' then
		if state.IgnoreTargetting.value == true then
			state.IgnoreTargetting:reset()
			eventArgs.handled = true
		end
		
		eventArgs.SelectNPCTargets = state.SelectStepTarget.value
	end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	if state.Kiting.value then
		msg = msg .. ', Kiting'
	end

	msg = msg .. ', ['..state.MainStep.current

	if state.UseAltStep.value == true then
		msg = msg .. '/'..state.AltStep.current
	end
	
	msg = msg .. ']'

	if state.SelectStepTarget.value == true then
		steps = steps..' (Targetted)'
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'step' then
		if cmdParams[2] == 't' then
			state.IgnoreTargetting:set()
		end

		local doStep = ''
		if state.UseAltStep.value == true then
			doStep = state[state.CurrentStep.current..'Step'].current
			state.CurrentStep:cycle()
		else
			doStep = state.MainStep.current
		end        
		
		send_command('@input /ja "'..doStep..'" <t>')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

	classes.CustomMeleeGroups:clear()
	--Low Haste; approx 15% haste; needs ~36% DW
	--High Haste; approx 30% haste; needs ~25% DW
	--Max Haste; 43.75% haste; needs ~5% DW

	if buffactive[604] then --[604] is the resource id for Mighty Guard
		if (buffactive.haste or buffactive.march == 2) then
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif buffactive.march == 1 then
			classes.CustomMeleeGroups:append('HighHaste')
		else 
			classes.CustomMeleeGroups:append('LowHaste')
		end
	elseif buffactive.march then
		if buffactive.haste then
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif buffactive.march == 2 then
			classes.CustomMeleeGroups:append('HighHaste')
		else
			classes.CustomMeleeGroups:append('LowHaste')
		end
	elseif buffactive.haste then
		if (buffactive.haste == 2 or buffactive.march) then
			classes.CustomMeleeGroups:append('MaxHaste')
		else
			classes.CustomMeleeGroups:append('HighHaste')
		end
	end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
	if spell.type == 'Step' then
		local allRecasts = windower.ffxi.get_ability_recasts()
		local prestoCooldown = allRecasts[236]
		local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
		
		if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
			cast_delay(1.1)
			send_command('@input /ja "Presto" <me>')
		end
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end

