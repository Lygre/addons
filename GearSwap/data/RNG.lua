-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
include('organizer-lib')


	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc','STP','Crit')
	state.WeaponskillMode:options('Normal', 'Acc')
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -4%',}}

	SnapBoots = {name="Taeon Boots", augments={'"Snapshot"+5','"Snapshot"+3',}}
	MidBoots = { name="Taeon Boots", augments={'Rng.Acc.+15 Rng.Atk.+15','Crit.hit rate+3','Crit.hit damage+3%',}}
	gear.melee_feet = {name="Taeon Boots", augments={'Accuracy+23','"Dual Wield"+5','DEX+2',}}	

	gear.melee_head = {name="Taeon Chapeau", augments={'Accuracy+17 Attack+17','"Triple Atk."+2','STR+10',}}

	gear.hercfeet = {name="Herculean Boots", augments={'Rng.Acc.+21 Rng.Atk.+21','Crit. hit damage +2%','STR+3','Rng.Acc.+5','Rng.Atk.+12',}}
	gear.herchands = {name="Herculean Gloves", augments={'Rng.Acc.+24 Rng.Atk.+24','DEX+10','Rng.Acc.+3','Rng.Atk.+7',}}
	gear.herclegs = {name="Herculean Trousers", augments={'Rng.Acc.+15 Rng.Atk.+15','Crit. hit damage +3%','DEX+8','Rng.Acc.+9',}}
	gear.herclegs_racc = {name="Herculean Trousers", augments={'Rng.Acc.+28','Crit.hit rate+3','DEX+11',}}
	

	DefaultAmmo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Achiyalabopa bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Achiyalabopa bullet"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {waist="Chaac Belt",hands="Amini Glovelettes +1"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Haruspex Hat",neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		hands="Leyline gloves",ring1="Prolix Ring",ring2="Lebeche ring",
		}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Amini gapette +1",
		body="Amini Caban +1",hands="Iuitl Wristbands",back="Lutian Cape",
		waist="Impulse Belt",legs="Nahtirah Trousers",feet=SnapBoots}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS.Melee = {
		head="Adhemar Bonnet",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Zennaroi Earring",
		body="Adhemar Jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves" }

	sets.precast.WS.Melee.Acc = set_combine(sets.precast.WS.Melee, {
		head=gear.melee_head,
		ring2="Begrudging Ring",
		back="Grounded Mantle +1",feet=gear.melee_feet})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	sets.precast.WS.Ranged = {
		head="Adhemar bonnet",neck="Fotia gorget",ear1="Moonshade Earring",ear2="Neritic Earring",
		body="Amini Caban +1",hands="Amini glovelettes +1",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Lutian Cape",waist="Fotia Belt",legs=gear.herclegs,feet=gear.hercfeet }

    sets.precast.WS['Last Stand'] = {
        head="Adhemar bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Neritic Earring",
        body="Amini Caban +1",hands="Kobo Kote",ring1="Shiva Ring +1",ring2="Petrov Ring",
        back="Lutian Cape",waist="Fotia Belt",legs=gear.herclegs,feet="Amini Bottillons +1"}

sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS.Ranged, 
	{ear2="Enervating Earring",
	hands=gear.herchands,
	back="Rancorous mantle",feet="Thereoid greaves"})
	
	sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'],
		{feet=gear.hercfeet})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Orion Beret +1",ear1="Loquacious Earring",
		ring1="Prolix Ring",
		waist="Ninurta's sash",legs="Orion Braccae +1",feet="Orion Socks +1"}

	sets.midcast.Utsusemi = {}

	-- Ranged sets

	sets.midcast.RA = {
		head="Arcadian Beret +1",neck="Ocachi Gorget",ear1="Neritic earring",ear2="Enervating Earring",
		body="Amini Caban +1",hands="Amini glovelettes +1",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Thereoid greaves"}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Amini gapette +1",neck="Iqabi necklace",
		hands="Kobo kote",ring1="Paqichikaji ring",ring2="Hajduk Ring",
		legs=gear.herclegs,feet=gear.hercfeet})

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{
		back="Rancorous Mantle",legs=gear.herclegs,feet=gear.hercfeet})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {hands="Amini glovelettes +1"})

	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc, {hands="Amini glovelettes +1",feet="Amini bottillons +1"})

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {feet="Thereoid greaves"})

	sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc)
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ring1="Sheltered Ring",ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
		head="Genmei Kabuto",neck="Loricate torque +1",ear1="Infused Earring",ear2="Genmei Earring",
		body="Kirin's Osode",hands="Kobo Kote",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Orion socks +1"}

	sets.idle.Town = {
		range="Annihilator",ammo="Achiyalabopa bullet",
		head="Genmei Kabuto",neck="Loricate torque +1",ear1="Infused Earring",ear2="Genmei Earring",
		body="Kirin's Osode",hands="Kobo Kote",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
		back="Lutian Cape",waist="Yemaya Belt",legs="Amini Brague +1",feet="Orion socks +1"}

	-- Defense sets
	sets.defense.PDT = {
		head="Genmei Kabuto",neck="Loricate torque +1",ear1="Infused earring",ear2="Genmei earring",
		body="Adhemar jacket",hands="Umuthi gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity cape",waist="Flume Belt",legs=gear.herclegs,feet=gear.hercfeet}

	sets.defense.MDT = {
		head="Adhemar bonnet",neck="Loricate torque +1",ear1="Zennaroi earring",ear2="Sanare earring",
		body="Abnoba kaftan",hands="Floral gauntlets",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity cape",waist="Flume Belt",legs=gear.herclegs,feet=gear.hercfeet}

	sets.Kiting = {feet="Orion socks +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="adhemar bonnet",neck="Asperity necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Abnoba kaftan", hands="Floral gauntlets", ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Samnuha tights",feet=gear.hercfeet}

	sets.engaged.Acc = set_combine(sets.engaged, {
		head=gear.melee_head,neck="Iqabi necklace",
		body="Adhemar jacket", hands="Floral gauntlets",ring2="Petrov Ring",
		back="Grounded Mantle +1",waist="Kentarch Belt"})

	sets.engaged.DW = {
		head=gear.melee_head,neck="Asperity necklace",ear1="Eabani Earring",ear2="Suppanomimi",
		body="Adhemar jacket", hands="Floral gauntlets", ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Patentia Sash",legs="Samnuha tights",feet=gear.melee_feet}

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		neck="Iqabi Necklace",
		ring2="Petrov Ring",
		back="Grounded Mantle +1"})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end
