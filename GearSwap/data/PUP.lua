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

    state.OffenseMode:options('Normal', 'Acc','Hybrid')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Pet')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }


    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}

	update_pet_mode()
    select_default_macro_book()

	state.AutoMode = M{'Normal', 'Pet Only', 'Pet Only DT', 'Hybrid DT'}
	organizer_items = {
		cpring="Capacity Ring",
		trring="Trizek Ring",
		DThands="Oberon's Sainti",
		oil="Automat. oil +3",
		oil2="Automat. oil +3",
		oil3="Automat. oil +3",
		ohtas="Ohtas",
		
		}

	
end

-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        head=gear.herchead_dt,neck="voltsurge torque",ear1="enchanter earring +1",ear2="Loquacious Earring",
        body=gear.fc_tbody,ring1="prolix ring",ring2="weatherspoon ring",
        back="swith cape +1",waist="Ninurta's sash",feet=gear.hercfeet_fc }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    
    -- Precast sets to enhance JAs
--    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    
    sets.precast.JA['Activate'] = {back="Visucius's mantle"}
    
    sets.precast.JA['Repair'] = {
        head=gear.repair_head,ear1="Guignol Earring",
        body=gear.repair_body,
        hands=gear.repair_hands,
        legs=gear.repair_legs,
        feet="Foire Bab. +1"}

    sets.precast.JA.Ventriloquy = {legs="Pitre churidars"}

    sets.precast.JA.Maneuver = {main="Midnights",sub=empty,neck="Buffoon's Collar",ear1="Burana earring",
        body="Karagoz Farsetto",hands="Foire Dastanas +1",
        back="Visucius's Mantle"}



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=gear.repair_head,ear1="Roundel Earring",
        body=gear.hercbody_melee,ring1="Petrov Ring",ring2="Sirona's Ring",
        back="Solemnity Cape",waist="Chaac belt",legs=gear.repair_legs,feet="Ahosi leggings"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Whirlpool mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Buquwik cape",waist="Fotia belt",legs="Samnuha tights",feet=gear.hercfeet_acc }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, 
        {ear1="Brutal Earring",ear2="Moonshade Earring"})

    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], 
        {})

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {ear1="Brutal Earring",ear2="Moonshade Earring"})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})

    
    -- Midcast Sets

    sets.midcast.FastRecast = {
        head=gear.herchead_pup,neck="voltsurge torque",ear1="enchanter earring +1",ear2="Loquacious Earring",
        body=gear.fc_tbody,ring1="prolix ring",ring2="lebeche ring",
        back="swith cape +1",waist="Ninurta's sash"}
        

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {
        head="Naga Somen",
        body="Naga Samue",hands="Naga Tekko",legs="Foire Churidars +1"}

    sets.midcast.Pet['Elemental Magic'] = {
        head="Rawhide mask",neck="Empath necklace",ear1="Burana earring",ear2="Charivari earring",
        body=gear.repair_body,hands="Regimen mittens",
        back="Refraction cape",waist="Ukko sash",legs=gear.herclegs_pup_mab,feet=gear.hercfeet_pup_mab }

    sets.midcast.Pet['Elemental Magic'].Resistant = {
        head="Rawhide mask",neck="Empath necklace",ear1="Burana earring",ear2="Charivari earring",
        body=gear.repair_body,hands="Regimen mittens",
        back="Refraction cape",waist="Ukko sash",legs=gear.herclegs_pup_mab,feet=gear.hercfeet_pup_mab }
    
    sets.midcast.Pet['Enfeebling Magic'] = set_combine(sets.midcast.Pet['Elemental Magic'].Resistant, {})
    
    sets.midcast.Pet.WeaponSkill = {
        head="Karagoz capello", 
        neck="Empath Necklace",
        ear1="Burana earring",ear2="Charivari earring",
        body=gear.pet_tpbody,
        hands="Naga Tekko", 
        ring1="Overbearing Ring",
        back="Dispersal Mantle",
        waist="Ukko sash",
        legs="Karagoz pantaloni +1",
        feet=gear.pet_tpfeet}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets

    sets.idle = {range="Divinator",ammo="Automat. oil +3",
        head="Pitre Taj",neck="Empath necklace",ear1="Burana Earring",ear2="Infused Earring",
        body=gear.repair_body,hands="Rao kote",ring1="Defending ring",ring2="Sheltered Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Rao haidate",feet="Rao sune-ate +1"}

    sets.idle.Town = set_combine(sets.idle, {})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    sets.idle.PDT = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = { 
        head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Contriver's Cape",waist="Isa belt",legs="Rao Haidate",feet="Rao Sune-ate +1" }

    sets.idle.Pet.Engaged.Melee = {main="Ohtas",
        head=gear.pet_tphead,neck="Empath necklace",ear1="Burana Earring",ear2="Charivari Earring",
        body="Pitre Tobe +1",hands=gear.herchands_pup,ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Ukko sash",legs=gear.herclegs_pup_stp,feet=gear.hercfeet_pup_stp }
        
    sets.PetAcc = {head=gear.herchead_pup,neck="Empath necklace",ear1="Rimeice Earring",ear2="Burana Earring",
        body=gear.hercbody_pup_stp,hands=gear.herchands_pup,
        back="Penetrating cape",waist="Ukko Sash",legs=gear.herclegs_pup_stp,feet=gear.hercfeet_pup_stp }
        
    sets.PetDT = {head="Anwig salade",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",
        waist="Isa Belt",legs="Rao Haidate",feet="Rao sune-ate +1"}
        
--    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, 
--      {head=gear.repair_head,hands="Naga Tekko",legs=gear.repair_legs,feet=gear.pet_tpfeet})
    sets.idle.Pet.Engaged.Ranged = { head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Visucius's Mantle",waist="Isa belt",legs="Rao Haidate",feet=gear.pet_tpfeet }

    sets.idle.Pet.Engaged.Tank = {
        head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Visucius's Mantle",waist="Isa belt",legs="Rao Haidate",feet="Rao Sune-ate +1" }


--    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, 
--      {body=gear.repair_body,back="Aurist's cape +1",legs="Pitre churidars",feet="Cirque Scarpe +2"})
    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, 
        {
        head="Naga Somen",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
        body="Naga Samue",hands="Naga tekko",
        back="Visucius's Mantle",waist="Ukko Sash",legs="Pitre Churidars",feet="Rao sune-ate +1"})

--    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged.Nuke, 
--      {legs="Pitre Churidars",feet=gear.pet_tpfeet})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged.Nuke, 
        {
        head="Naga Somen",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
        body="Naga Samue",hands="Naga tekko",
        back="Visucius's Mantle",waist="Ukko Sash",legs="Pitre Churidars"})


    -- Defense sets

    sets.defense.Evasion = {
        head="Whirlpool Mask",neck="Loricate torque +1",
        body="Abnoba Kaftan",hands=gear.herchands_acc,ring1="Defending Ring",
        waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet=gear.hercfeet_acc}

    sets.defense.PDT = {
        head="Whirlpool Mask",neck="Loricate torque +1",
        body="Abnoba Kaftan",hands=gear.herchands_acc,ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="solemnity cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Ahosi leggings"}

    sets.defense.MDT = {
        head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's Earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Solemnity Cape",waist="Isa belt",legs="Rao haidate",feet="Ahosi leggings"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {head="Naga somen",neck="Lissome necklace", ear1="Telos earring",ear2="Brutal earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Epona's ring",ring2="Rajas Ring",
        back="Dispersal Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.hercfeet_acc}
    
    sets.engaged.Acc = {
        head="Whirlpool Mask",neck="Lissome necklace",ear1="Brutal earring",ear2="Telos Earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Hurch'lan Sash",legs="Samnuha tights",feet="Rao sune-ate +1"}
    sets.engaged.Hybrid = {
       head="Naga somen",neck="Lissome necklace", ear1="Telos earring",ear2="Brutal earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Epona's ring",ring2="Rajas Ring",
        back="Dispersal Mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet="Punchinellos"}
     sets.engaged.Acc.DT = {
        head="Whirlpool Mask",neck="Loricate torque +1",ear1="Brutal earring",ear2="Telos Earring",
        body="Abnoba Kaftan",hands="Regimen Mittens",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Dispersal mantle",waist="Hurch'lan Sash",legs="Samnuha tights",feet="Ahosi leggings"}
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end

--function job_state_change(stateField, newValue, oldValue)
--    if stateField == 'Physical Defense Mode' then
        --if newValue == 'Pet' then
--            equip(sets.idle.Pet.Engaged.Tank)
--			handle_equipping_gear(player.status)
--			
--        end
--    end	
--end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
       display_pet_status()
	   handle_equipping_gear(player.status)
		--if pet.tp > 100.0 then
			--equip(sets.midcast.Pet.WeaponSkill)
		--end
    end
end

--function job_state_change(new_state_value, old_state_value)
--end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                local man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
		if pet.head == 'Soulsoother Head' then
			if pet.frame == 'Stormwaker Frame' then
				return 'Heal'
			elseif pet.frame == 'Harlequin Frame' then
				return 'Tank'
			elseif pet.frame == 'Valoredge Frame' then
				return 'Tank'
			else 
				return 'None'
			end
		elseif pet.head == 'Valoredge Head' then
			if pet.frame == 'Valoredge Frame' then
				return 'Melee'
			elseif pet.frame == 'Sharpshot Frame' then
				return 'Melee'
			else
				return 'None'
			end
		elseif pet.head == 'Stormwaker Head' then	
			if pet.frame == 'Stormwaker Frame' then	
				return 'Magic'
			else
				return 'None'
			end
		elseif pet.head == 'Spiritreaver Head' then
			if pet.frame == 'Stormwaker Frame' then
				return 'Nuke'
			else
				return 'None'
			end
		elseif pet.head == 'Sharpshot Head' then	
			if pet.frame == 'Sharpshot Frame' then
				return 'Ranged'
			elseif pet.frame == 'Valoredge Frame' then
				return 'Melee'
			else
				return 'None'
			end
		else
			return 'None'
		end
        --return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

function customize_idle_set(idleSet)
	if state.HybridMode.current == 'Acc' then
		idleSet = set_combine(idleSet, sets.PetAcc)
	elseif state.HybridMode.current == 'DT' then
		idleSet = set_combine(idleSet, sets.PetDT)
	end
	return idleSet
end

function customize_melee_set(meleeSet)
	if state.HybridMode.current == 'Acc' then
		meleeSet = set_combine(meleeSet, sets.PetAcc)
	elseif state.HybridMode.current == 'DT' then
		meleeSet = set_combine(meleeSet, sets.PetDT)
	end
	return meleeSet
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..'] ['..state.PetMode.value..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
        
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
        add_to_chat(122,petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 9)
    else
        set_macro_page(1, 9)
    end
end
