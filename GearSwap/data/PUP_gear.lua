-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		head=gear.herchead_pup,neck="voltsurge torque",ear1="enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,ring1="prolix ring",ring2="weatherspoon ring",
		back="swith cape +1",waist="Ninurta's sash",feet=gear.hercfeet_fc }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    
    -- Precast sets to enhance JAs
--    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    
    sets.precast.JA['Repair'] = {
		head=gear.repair_head,ear1="Guignol Earring",
		body=gear.repair_body,
		hands=gear.repair_hands,
		legs=gear.repair_legs,
		feet="Foire Bab. +1"}

	sets.precast.JA.Ventriloquy = {legs="Pitre churidars"}

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar",ear1="Burana earring",
		body="Karagoz Farsetto",hands="Foire Dastanas +1",
		back="Dispersal Mantle"}



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
        back="Contriver's cape",waist="Isa Belt",legs="Rao haidate",feet="Rao sune-ate +1"}

    sets.idle.Town = set_combine(sets.idle, {})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = { 
        head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Contriver's Cape",waist="Isa belt",legs="Rao Haidate",feet="Rao Sune-ate +1" }

	sets.idle.Pet.Engaged.Melee = {
        head=gear.herchead_pup,neck="Empath necklace",ear1="Burana Earring",ear2="Charivari earring",
        body="Pitre Tobe +1",hands=gear.herchands_pup,ring1="Defending Ring",ring2="Overbearing Ring",
        back="Penetrating Cape",waist="Ukko sash",legs=gear.herclegs_pup_stp,feet=gear.hercfeet_pup_stp }
		
	sets.PetAcc = {head=gear.herchead_pup,neck="Empath necklace",ear1="Rimeice Earring",ear2="Burana Earring",
		body=gear.hercbody_pup_stp,hands=gear.herchands_pup,
		back="Penetrating cape",waist="Ukko Sash",legs=gear.herclegs_pup_stp,feet=gear.hercfeet_pup_stp }
		
	sets.PetDT = {head="Anwig salade",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
		body=gear.pet_tpbody,hands="Rao kote",
		waist="Isa Belt",legs="Rao Haidate",feet="Rao sune-ate +1"}
		
--    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, 
--		{head=gear.repair_head,hands="Naga Tekko",legs=gear.repair_legs,feet=gear.pet_tpfeet})
    sets.idle.Pet.Engaged.Ranged = { head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Contriver's Cape",waist="Isa belt",legs="Rao Haidate",feet=gear.pet_tpfeet }

	sets.idle.Pet.Engaged.Tank = {
	    head="Anwig Salade",neck="Shepherd's chain",ear1="Handler's Earring",ear2="Handler's earring +1",
        body=gear.pet_tpbody,hands="Rao kote",ring1="Defending Ring",ring2="Overbearing Ring",
        back="Penetrating Cape",waist="Isa belt",legs="Rao Haidate",feet="Rao Sune-ate +1" }


--    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, 
--		{body=gear.repair_body,back="Aurist's cape +1",legs="Pitre churidars",feet="Cirque Scarpe +2"})
    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, 
		{
		head="Naga Somen",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
		body="Naga Samue",hands="Naga tekko",
		back="Contriver's cape",waist="Ukko Sash",legs="Pitre Churidars",feet="Rao sune-ate +1"})

--    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged.Nuke, 
--		{legs="Pitre Churidars",feet=gear.pet_tpfeet})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged.Nuke, 
		{
		head="Naga Somen",neck="Shepherd's chain",ear1="Handler's earring",ear2="Handler's earring +1",
		body="Naga Samue",hands="Naga tekko",
		back="Contriver's cape",waist="Ukko Sash",legs="Pitre Churidars"})


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

