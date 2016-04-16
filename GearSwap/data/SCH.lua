-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	
	include('organizer-lib')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


function user_setup()
	send_command('bind ^f10 gs c toggle MagicBurst')
	send_command('bind !f11 gs c cycle MagicalDefenseMode')

end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

        Non_Obi_Spells = S{
                        'Burn','Choke','Drown','Frost','Rasp','Shock','Impact','Anemohelix','Cryohelix',
                        'Geohelix','Hydrohelix','Ionohelix','Luminohelix','Noctohelix','Pyrohelix'}
 
        Cure_Spells = {"Cure","Cure II","Cure III","Cure IV"} -- Cure Degradation --
        Curaga_Spells = {"Curaga","Curaga II"} -- Curaga Degradation --
		
    state.OffenseMode:options('None', 'Locked')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT','Meva')
	
    state.MagicBurst = M(false, 'Magic Burst')

	gear.RegenCape = {name="Bookworm's Cape", augments={'INT+2','Helix eff. dur. +13','"Regen" potency+9',}}
	gear.HelixCape = {name="Bookworm's Cape", augments={'INT+4','MND+4','Helix eff. dur. +20',}}
	gear.NukeStaff = {name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}}
	gear.EnfeebStaff = {name="Akademos", augments={'Mag. Acc.+20','Enha.mag. skill +15','Enfb.mag. skill +15',}}

    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c toggle MagicBurst')
		
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
    select_default_macro_book()

	custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_unload()
    send_command('unbind !^`')
end


function init_gear_sets()
end
-- Define sets and vars used by this job file.

-------------------------------------------------------------------------
--Pretarget
-------------------------------------------------------------------------
function pretarget(spell, action, spellMap, eventArgs)
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english:ifind("Cure") and player.mp<actualCost(spell.mp_cost) then
		degrade_spell(spell, Cure_Spells)
	elseif spell.english:ifind("Curaga") and player.mp<actualCost(spell.mp_cost) then
		degrade_spell(spell, Curaga_Spells)
    end
end
-----------------------------------------------------------------
--Precast
------------------------------------------------------------------
function job_precast(spell, action, spellMap)
	if not midaction() then
	    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
			if string.find(spell.english,'Cur') and spell.english ~= "Cursna" then
				equip(sets.precast.FC.Cure)
			end
			if spell.english == "Impact" then
				equip(set_combine(sets.precast.FC,{body="Twilight Cloak"}))
			end
		end
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
		if (buffactive['Addendum: White'] or buffactive['Light Arts']) and spell.type == 'WhiteMagic' then
			equip(sets.precast.FC.Arts)
		end
		if (buffactive['Addendum: Black'] or buffactive['Dark Arts']) and spell.type == 'BlackMagic' then
			equip(sets.precast.FC.Arts)
		end
end

-----------------------------------------------------------------------
--Midcast
-------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)
    equipSet = {}
                if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' or spell.type == 'BardSong' then
                    equipSet = sets.midcast
				elseif string.find(spell.english,'helix') then
					equipSet = equipSet.Helix
                        elseif string.find(spell.english,'Cure') then
                            equipSet = equipSet.Cure
							if spell.target.name == player.name then
								equipSet = equipSet.SelfCure
							end
                        elseif string.find(spell.english,'Cura') then
                            equipSet = equipSet.Curaga
                        elseif string.find(spell.english,'Banish') then
                            equipSet = set_combine(equipSet.MndEnfeebles)
                        elseif spell.english == "Stoneskin" then
							equipSet = equipSet.Stoneskin
                            if buffactive.Stoneskin then
                                send_command('cancel stoneskin')
							end
                        elseif spell.english == "Sneak" then
                            if spell.target.name == player.name and buffactive['Sneak'] then
                                send_command('cancel sneak')
                            end
                            equipSet = equipSet.Haste
                        elseif string.find(spell.english,'Utsusemi') then
                            if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                                send_command('@wait 1.7;cancel Copy Image*')
                            end
                            equipSet = equipSet.Haste
                        elseif spell.english == 'Monomi: Ichi' then
                            if buffactive['Sneak'] then
                                send_command('@wait 1.7;cancel sneak')
                            end
                            equipSet = equipSet.Haste
                        else
                        if equipSet[spell.english] then
                                equipSet = equipSet[spell.english]
                        end
                        if equipSet[spell.skill] then
                                equipSet = equipSet[spell.skill]
                        end
                        if equipSet[spell.type] then
                                equipSet = equipSet[spell.type]
                        end
                        
                        if string.find(spell.english,'Cure')  and (world.weather_element == spell.element) or  (world.day_element == spell.element) then
                                equipSet = set_combine(equipSet,sets.Obi)
                        end    
                        if ((spell.english == 'Drain') or (spell.english == 'Aspir')) and ((world.day_element == spell.element) or (world.weather_element == spell.element)) then
                                equipSet = set_combine(equipSet,sets.Obi)
                        end  
			end
    if equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    equip(equipSet)
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
	apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
	   if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' then
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip(sets.Obi)
			if string.find(spell.english,'helix') then
				if state.MagicBurst.value then
					equip(set_combine(sets.magic_burst,{back=gear.HelixCape}))
				end
			elseif state.MagicBurst.value then
				equip(sets.magic_burst) 
			end
		elseif state.MagicBurst.value then
			equip(sets.magic_burst) 
		end
	   end
	   if string.find(spell.english,'Cur') and spell.target.name == player.name then
	   	equip(sets.midcast.SelfCure)
	   end
	end
	if not spell.interrupted then
		if spell.english == "Sleep II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Break" then -- Break Countdown --
			send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Poison II" then
			send_command('wait 90;input /echo Poison Effect: [WEARING OFF IN 30 SEC.];wait 20;input /echo Poison Effect: [WEARING OFF IN 10 SEC.]')
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
     if not spell.interrupted then
         if spell.skill == 'Elemental Magic' then
            ---state.MagicBurst:reset()
  		elseif spell.skill == 'Enhancing Magic' then
            	--adjust_timers(spell, spellMap)
    		end
	end
	handle_equipping_gear(player.status)
end
function job_post_aftercast(spell, action, spellMap, eventArgs)
---auto_sublimation()
end

-- Function to create custom buff-remaining timers with the Timers plugin,

-- keeping only the actual valid songs rather than spamming the default

-- buff remaining timers.

--[[function adjust_timers(spell, spellMap)
    local current_time = os.time()
    local temp_timer_list = {}
    local dur = calculate_duration(spell, spellName, spellMap)
         custom_timers[spell.name] = nil
         send_command('timers delete "'..spell.name..' ['..spell.target.name..']"')
         custom_timers[spell.name] = current_time + dur
         send_command('@wait 1;timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
end

function calculate_duration(spell, spellName, spellMap)

    local mult = 1.00

	if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.09 end
	if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.09 end
	if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.09 end
	if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.09 end
	if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.10 end
	
	if player.equipment.Feet == 'Estq. Houseaux +2' then mult = mult + 0.20 end
	if player.equipment.Legs == 'Futhark Trousers' then mult = mult + 0.10 end
	if player.equipment.Legs == 'Futhark Trousers +1' then mult = mult + 0.20 end
	if player.equipment.Hands == 'Atrophy Gloves' then mult = mult + 0.15 end
	if player.equipment.Hands == 'Atrophy Gloves +1' then mult = mult + 0.16 end
	if player.equipment.Back == 'Estoqueur\'s Cape' then mult = mult + 0.10 end
	if player.equipment.Hands == 'Dynasty Mitts' then mult = mult + 0.05 end
	if player.equipment.Body == 'Shabti Cuirass' then mult = mult + 0.09 end
	if player.equipment.Body == 'Shabti Cuirass +1' then mult = mult + 0.10 end
	if player.equipment.Feet == 'Leth. Houseaux' then mult = mult + 0.25 end
	if player.equipment.Feet == 'Leth. Houseaux +1' then mult = mult + 0.30 end
	if player.equipment.Head == 'Erilaz Galea' then mult = mult + 0.10 end
	if player.equipment.Head == 'Erilaz Galea +1' then mult = mult + 0.15 end

	local base = 0

	if spell.name == 'Haste' then base = base + 180 end
	if spell.name:startswith("Bar") then base = base + 480 end
	if spell.name == 'Aquaveil' then base = base + 600 end
	if string.find(spell.english,'storm') then base = base + 180 end
	if spell.name == 'Auspice' then base = base + 180 end
	if spell.name:startswith("Boost") then base = base + 300 end
	if spell.name == 'Phalanx' then base = base + 180 end
	if spell.name:startswith("Refresh") then base = base + 150 end
	if spell.name:startswith("Regen") then 
		base = base + 60
		if buffactive['Light arts'] and player.main_job == 'SCH' then
			base = base*2+60
		-----the *2 here is the additional 60sec from Light Arts job points maxed
		-----+48 is from light arts, +12 more from telchine chas.
		elseif player.main_job == 'WHM' then
			base = base + 60
			if player.equipment.Hands == 'Ebers Mitts' then 
				base = base +  20
			elseif player.equipment.Hands == 'Ebers Mitts +1' then 
				base = base + 22
			end
			if player.equipment.Legs == 'Theo. Pantaloons' or player.equipment.Legs == 'Theo. Pant. +1' then
				base = base + 18
			end
		end
	end
	if spell.name == 'Adloquium' then base = base + 180 end
	if spell.name:startswith("Animus") then base = base + 180 end
	if spell.name == 'Crusade' then base = base + 300 end
	if spell.name == 'Embrava' then base = base + 90 end
	if spell.name:startswith("En") then base = base + 180 end
	if spell.name:startswith("Flurry") then base = base + 180 end
	if spell.name == 'Foil' then base = base + 30 end
	if spell.name:startswith("Gain") then base = base + 180 end
	if spell.name == 'Reprisal' then base = base + 60 end
	if spell.name:startswith("Temper") then base = base + 180 end
	if string.find(spell.english,'Spikes') then base = base + 180 end

	if buffactive['Perpetuance'] then
		if player.equipment.Hands == 'Arbatel Bracers' then
			mult = mult*2.5
		elseif player.equipment.Hands == 'Arbatel Bracers +1' then
			mult = mult*2.55
		else
			mult = mult*2
		end
	end

	if buffactive['Composure'] then
		if spell.target.type == 'SELF' then
			mult = mult*3
		else
			mult = mult
		end
	end			
    local totalDuration = math.floor(mult*base)

	--print(totalDuration)

    return totalDuration
end

function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end]]

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

function auto_sublimation()
	local abil_recasts = windower.ffxi.get_ability_recasts()
	if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
		if not (buffactive['Invisible'] or buffactive['Weakness']) then
			if abil_recasts[234] == 0 then
				send_command('@wait 2;input /ja "Sublimation" <me>')
			end
		end
	elseif buffactive['Sublimation: Complete'] then
		if (player.max_mp - player.mp) > 500 and abil_recasts[234] == 0 then
				send_command('@wait 2;input /ja "Sublimation" <me>')
		end
	end			
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Locked' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            elseif spell.english == 'Frazzle' or spell.english == 'Distract' then
				return 'SpecialEnfeebles'
			else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' or state.IdleMode.value == 'MDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
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
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true

    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end


-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if (spellMap == 'Cure' or spellMap == 'Curaga') and (buffactive['Light Arts'] or buffactive['Addendum: White']) then
		if state.Buff.Rapture then
        		equip(sets.buff['Rapture'])
		end
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' and not state.MagicBurst.value then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
	
	local currentStrats = get_current_strategem_count()
	local newStratCount = currentStrats - 1
	if currentStrats > 0 then
		add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
	else
		add_to_chat(122, '***Out of stratagems! Cancelling...***')
		return
	end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    --[[local maxStrategems = (player.main_job_level + 10) / 20]]
	local maxStrategems = 5
	
    local fullRechargeTime = 5*33

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 18)
end