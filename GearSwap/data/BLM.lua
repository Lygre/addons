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


	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	
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

	sets.precast.FC = {}
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Enfeebling Magic'] = sets.precast.FC
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})

	-- Default FC set when Death Mode is on and no matching DeatMB subtable is found for specific spell
	sets.precast.FC.DeatMB = {}
	-- Other Magic Type Death Mode FC subtables 
	sets.precast.FC['Enhancing Magic'].DeatMB = sets.precast.FC.DeatMB
	sets.precast.FC['Enfeebling Magic'].DeatMB = sets.precast.FC.DeatMB
	sets.precast.FC['Elemental Magic'].DeatMB = sets.precast.FC.DeatMB
	sets.precast.FC['Healing Magic'].DeatMB = sets.precast.FC.DeatMB

	--Death sets
	sets.DeatCastIdle = {}	
	sets.precast.FC['Death'] = {}
	sets.midcast['Death'] = {}
	sets.MB_death = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {}

	---- Midcast Sets ----
	--sets.midcast.DeatMB = sets.precast.FC['Death']

	sets.midcast.FastRecast = {}

	sets.midcast['Healing Magic'] = {}

	sets.midcast['Enhancing Magic'] = {}

	sets.midcast['Enhancing Magic'].Refresh = {}
	sets.midcast['Enhancing Magic'].Haste = {}
	sets.midcast['Enhancing Magic'].Phalanx = {}
	sets.midcast['Enhancing Magic'].Aquaveil = {}
	sets.midcast['Enhancing Magic'].Stoneskin = {}

	sets.midcast['Enfeebling Magic'] = {}	
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { })	
	sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

	sets.midcast['Dark Magic'] = {}
	sets.midcast['Dark Magic'].Drain = {}
	sets.midcast['Dark Magic'].Aspir = sets.midcast['Dark Magic'].Drain
	sets.midcast['Dark Magic'].Stun = {}

	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].Mid = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'].Mid, {})
	sets.midcast['Elemental Magic'].CMP = set_combine(sets.midcast['Elemental Magic'].Mid, {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Mid = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke.Mid, {})
	sets.midcast['Elemental Magic'].HighTierNuke.CMP = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {})

	sets.midcast.Impact = {head=empty,body="Twilight Cloak"}

	--Death Midcast subtables
	sets.midcast.FastRecast.DeatMB = sets.precast.FC.DeatMB
	sets.midcast['Enhancing Magic'].DeatMB = sets.precast.FC.DeatMB
	sets.midcast['Enfeebling Magic'].DeatMB = sets.precast.FC.DeatMB
	sets.midcast['Dark Magic'].DeatMB =  sets.precast.FC.DeatMB
	sets.midcast['Healing Magic'].DeatMB = set_combine(sets.precast.FC.DeatMB, {})
	sets.midcast['Dark Magic'].Aspir.DeatMB = set_combine(sets.precast.FC.DeatMB, {})

	--Set to be overlaid on top of the default midcast set for the spell you're casting when Magic Burst mode is toggled on
	sets.magic_burst = {}

	--Set to be equipped when Day/Weather match current spell element
	sets.Obi = {waist='Hachirin-no-Obi'}

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	-- Normal refresh idle set
	sets.idle = { }

	-- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = {}
	
	-- Town gear.
	sets.idle.Town = sets.idle
			
	sets.TreasureHunter = {waist="Chaac Belt"}

	-- Set for Conserve MP toggle, puts AF body on
	sets.ConsMP = {body="Spaekona's coat +1"}

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

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
	-- May want to keep this an empty set if you engage to use Myrkr
	sets.engaged = {}

end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, action, spellMap, eventArgs)
	enable('feet','back')
	if state.DeatCast.value then
		if spell.type == 'Magic' then
			if spell.english == "Death" then
				equip(sets.precast.FC['Death'])
			else 
				state.CastingMode:set('DeatMB')
				classes.CustomClass = 'DeatMB'
			end
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
				state.CastingMode:set('DeatMB')
				classes.CustomClass = 'DeatMB'
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


function refine_various_spells(spell, action, spellMap, eventArgs)
	local aspirs = S{'Aspir','Aspir II','Aspir III'}
	local sleeps = S{'Sleep','Sleep II'}
	local sleepgas = S{'Sleepga','Sleepga II'}

	local degrade_array = {
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
			state.CastingMode:set('DeatMB')
			--[[Insert 'equip(<set consisting of Death weapon and sub, to have them automatically lock when changing into Death mode>)']]
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