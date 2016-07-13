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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

	    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT','MDT')
	state.PhysicalDefenseMode:options('PDT', 'Shield')
	state.Skillup = M(false, 'Boost Spell')
	
    state.AutoAga = M(false, 'Auto Curaga')
	Curaga_benchmark = 30
	Enmity = 1
	Safe_benchmark = 70
	Sublimation_benchmark = 30
	Sublimation = 1
	--get_current_strategem_count()
    select_default_macro_book()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
function user_setup()
    send_command('bind ^` input /sacrosanctity')
    send_command('bind !` input /asylum')
    send_command('bind @` input /divinecaress')
    send_command('bind ^F1 input /aurorastorm <me>')
    send_command('bind !F1 input /accession')
    send_command('bind @F1 input /reraise4')
    send_command('bind ^F2 input /celerity')
    send_command('bind !F2 input /divinecaress')
    send_command('bind ^F3 gs c toggle AutoAga')

end
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
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

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience orb",
		main="Oranyan",sub="Vivid Strap",
        head="Nahtirah Hat",neck="Orison Locket",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Inyanga jubbah +1",hands="Fanatic gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Alaunus's Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",legs="Doyen pants"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {main="Ababinili +1",legs="Ebers pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], 
		{main="Queller Rod",sub="Genmei Shield",
		body="Inyanga jubbah +1",feet="Hygieia Clogs"})
		
    sets.precast.FC.Impact = {head=empty,body="Twilight Cloak"}
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel earring",ear2="Thureous earring",
        body="Vanya Robe",hands="Fanatic gloves",ring1="Asklepian Ring",
        back="Solemnity cape",legs="Ebers pantaloons +1",feet="Vanya clogs"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Befouled crown",neck="Fotia gorget",
        body="Onca Suit",hands=empty,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Solemnity Cape",waist="Fotia Belt",legs=empty,feet=empty}
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {main="Oranyan",sub="Vivid strap",ammo="Sapience Orb",
        head="Nahtirah Hat",neck="Orison locket",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Inyanga jubbah +1",hands="Fanatic gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Alaunus's cape",waist="Witful belt",legs="Lengo Pants",feet="Regal pumps"}
    
    ------------ Cure sets-------------------

	sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",sub="Achaq Grip",ammo="Psilomene",
		head="Ebers cap +1",neck="Incanter's torque",ear1="Nourishing earring +1",ear2="Glorious earring",
		body="Ebers Bliaud +1",hands="Kaykaus cuffs",ring1="Haoma's Ring",ring2="Lebeche Ring",
		back="Alaunus's Cape",waist="Hachirin-no-obi",legs="Ebers Pantaloons +1",feet="Vanya clogs"}

    sets.midcast.CureSolace = {main="Queller Rod",sub="Genbu's Shield",ammo="Psilomene",
        head="Kaykaus Mitra",neck="Nodens gorget",ear1="Nourishing earring +1",ear2="Glorious Earring",
        body="Ebers bliaud +1",hands="Theophany mitts +1",ring1="Lebeche Ring",ring2="Haoma's Ring",
        back="Alaunus's Cape",waist="Bishop's sash",legs="Ebers pantaloons +1",feet="Vanya Clogs"}

    sets.midcast.Cure = {main="Queller Rod",sub="Genmei shield",ammo="Psilomene",
        head="Gendewitha Caubeen +1",neck="Incanter's torque",ear1="Mendicant's Earring",ear2="Glorious Earring",
        body="Kaykaus bliaut",hands="Theophany Mitts +1",ring1="Haoma's Ring",ring2="Haoma's Ring",
        back="Mending Cape",waist="Bishop's sash",legs="Ebers pantaloons +1",feet="Hygieia Clogs"}

    sets.midcast.Curaga = {main="Queller Rod",sub="Genmei shield",ammo="Psilomene",
        head="Gendewitha Caubeen +1",neck="Incanter's torque",ear1="Glorious Earring",ear2="Mendicant's Earring",
        body="Kaykaus bliaut",hands="Theophany Mitts +1",ring1="Lebeche Ring",ring2="Globidonta Ring",
        back="Mending Cape",waist="Pythia sash +1",legs="Ebers pantaloons +1",feet="Hygieia Clogs"}

    sets.midcast.CureMelee = {ammo="Sapience Orb",
        head="Gendewitha Caubeen +1",neck="Orison Locket",ear1="Enchanter earring +1",ear2="Mendicant's Earring",
        body="Ebers bliaud +1",hands="Fanatic gloves",ring1="Prolix Ring",ring2="Haoma's Ring",
        back="Mending Cape",waist=gear.ElementalObi,legs="Ebers pantaloons +1",feet="Piety Duckbills +1"}

    sets.midcast.Cursna = {main="Ababinili +1",sub="Arbuda Grip",ammo="Sapience Orb",
        head="Ebers cap +1",neck="Malison Medallion",ear1="Loquacious earring",ear2="Enchanter earring +1",
        body="Ebers bliaud +1",hands="Fanatic gloves",ring1="Haoma's Ring",ring2="Haoma's ring",
        back="Alaunus's Cape",waist="Ninurta's sash",legs="Piety Pantaloons +1",feet="Gendewitha Galoshes +1"}

    sets.midcast.StatusRemoval = {ammo="Sapience Orb",
        head="Ebers cap +1",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
		body="Ebers bliaud +1",hands="Fanatic gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Alaunus's Cape",waist="Ninurta's Sash",legs="Ebers pantaloons +1",feet="Regal Pumps"}

--------------ENHANCING AND SUCH---------------------

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Oranyan",sub="Fulcio grip",
        head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa Earring",
        body="Telchine chasuble",hands="Telchine gloves",
        back="Mending Cape",waist="Olympus Sash",legs="Telchine braconi",feet="Telchine Pigaches"}

	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
		{ammo="Sapience orb",
		neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
		ring1="Prolix ring",
		back="Swith cape +1",waist="Ninurta's sash"})
	
	sets.midcast.Storm = sets.midcast['Enhancing Magic']
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{head=gear.chirhead,
		waist="Emphatikos Rope",legs="Shedir seraweels"})	

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
		{neck="Nodens Gorget",
		waist="Siegel Sash",legs="Shedir seraweels"})

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{main="Beneficus",sub="Genmei shield",feet="Ebers duckbills +1"})
		
    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'],{feet="Ebers Duckbills +1"})

    sets.midcast.BarElement = {main="Beneficus",sub="Genmei Shield",
        head="Ebers cap +1",neck="Incanter's Torque",ear1="Andoaa earring",
        body="Ebers bliaud +1",hands="Telchine gloves",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}

	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'],
		{main="Ababinili +1",sub="Fulcio grip",ammo="Homiliary",
		feet="Ebers duckbills +1"})
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",sub="Genmei Shield",
        head="Inyanga tiara +1",body="Piety Briault +1",hands="Ebers mitts +1"})

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Defending Ring",feet="Piety Duckbills +1"})

    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Defending Ring",legs="Piety Pantaloons +1"})
	
	sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {waist="Chaac Belt"})

    sets.midcast['Divine Magic'] = {main="Ababinili +1",sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head="Kaykaus mitra",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter earring +1",
        body="Inyanga jubbah +1",hands="Fanatic gloves",ring1="Globidonta ring",ring2="Weatherspoon Ring",
        back="Alaunus's cape",waist="Luminary Sash",legs="Telchine Braconi",feet="Medium's sabots"}

    sets.midcast['Dark Magic'] = {main="Rubicundity", sub="Genbu's Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter earring +1",
        body="Shango robe",hands=gear.chirhands_macc,ring1="Archon Ring",ring2="Weatherspoon ring",
        back="Perimede cape",waist="Eschan Stone",legs="Telchine Braconi",feet="Medium's sabots"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Ababinili +1",sub="Clerisy Strap",ammo="Pemphredo Tathlum",
        head="Inyanga tiara +1",neck="incanter's torque",ear1="Digni. Earring",ear2="Enchanter earring +1",
        body=gear.chirbody,hands="Inyanga Dastanas +1",ring1="Globidonta ring",ring2="Weatherspoon Ring",
        back="Alaunus's cape",waist="Eschan Stone",legs=gear.chirlegs,feet="Inyanga crackows +1"}

    sets.midcast.IntEnfeebles = {main="Ababinili +1", sub="Clerisy Strap",ammo="Pemphredo Tathlum",
        head=gear.chirhead,neck="incanter's torque",ear1="Gwati Earring",ear2="Enchanter earring +1",
        body=gear.chirbody,hands="Kaykaus cuffs",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Aurist's cape +1",waist="Eschan Stone",legs=gear.chirlegs,feet="Medium's sabots"}

    sets.midcast.Impact = {main=gear.grio_elemental,sub="Niobid strap",ammo="Pemphredo Tathlum",
        head=empty,neck="Incanter's torque",ear1="Enchanter Earring +1",ear2="Gwati Earring",
        body="Twilight Cloak",hands=gear.chirhands_macc,ring1="Archon Ring",ring2="Sangoma Ring",
        back="Alaunus's cape",waist="Eschan Stone",legs=gear.chirlegs,feet="Medium's sabots"}
    	

    -- Sets to return to when not performing an action.
    
    -- Resting set
    sets.resting = {  
        body="Vrikodara jupon",hands=gear.chirhands_sc,
        legs="Assiduity pants +1",feet="Vanya clogs"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Bolelabunga", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi earring",
        body="Ebers Bliaud +1",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Vanya clogs"}

    sets.idle.PDT = {main="Bolelabunga", sub="Genmei shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs="Assiduity pants +1",feet=gear.chirfeet_block }

	sets.idle.MDT = {main="Bolelabunga", sub="Genmei shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Inyanga jubbah +1",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Vanya clogs"}


    sets.idle.Town = {main="Bolelabunga", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi earring",
        body="Inyanga jubbah +1",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Herald's gaiters"}
    
    sets.idle.Weak = {main="Bolelabunga", sub="Genmei shield",ammo="Homiliary",
        head="Befouled crown",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Vanya robe",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Slipor sash",legs="Assiduity pants +1",feet="Vanya clogs"}
    
    -- Defense sets

    sets.defense.PDT = {
		main="Mafic cudgel", -- 10% PDT;
		sub="Genmei shield", -- 10% PDT; Block +6; Counter +4
		ammo="Brigantia pebble",
        head=gear.chirhead_pdt, -- 2% MDT; Block +3
		neck="Loricate torque +1", -- 6% DT
		ear1="Thureous earring", -- Block +2
		ear2="Genmei earring", --  2% PDT; Counter +1
        body="Vrikodara jupon", -- 3% PDT
		hands="Gendewitha gages +1", -- Block +4
		ring1="Defending Ring", -- 10% DT
		ring2=gear.DarkRing.PDT, -- 5% PDT; 4% MDT
        back="Solemnity Cape", -- 4% DT
		waist="Slipor sash", -- 3% MDT
		legs=gear.chirlegs_dt, -- Block +3
		feet=gear.chirfeet_pdt -- 2% PDT; Block +4
		}
    sets.defense.Shield = {
		main="Mafic cudgel", -- 10% PDT;
		sub="Genmei shield", -- 10% PDT; Block +6; Counter +4
		ammo="Brigantia pebble",
        head=gear.chirhead_block, -- 2% MDT; Block +3
		neck="Loricate torque +1", -- 6% DT
		ear1="Thureous earring", -- Block +2
		ear2="Genmei earring", --  2% PDT; Counter +1
        body="Vrikodara jupon", -- 3% PDT
		hands=gear.chirhands_block, -- Block +4
		ring1="Defending Ring", -- 10% DT
		ring2=gear.DarkRing.PDT, -- 5% PDT; 4% MDT
        back="Solemnity Cape", -- 4% DT
		waist="Slipor sash", -- 3% MDT
		legs=gear.chirlegs_block, -- Block +3
		feet=gear.chirfeet_block -- 2% PDT; Block +4
		}
	
    sets.defense.MDT = {main="Mafic Cudgel", sub="Genmei shield",ammo="Vanir battery",
        head="Inyanga tiara +1",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Inyanga jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Slipor sash",legs="Inyanga shalwar +1",feet="Inyanga crackows +1"}

    sets.Kiting = {feet="Herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {main="Mafic Cudgel",sub="Genmei shield",ammo="Homiliary",
        head=gear.chirhead_block,neck="Lissome Necklace",ear1="Digni. Earring",ear2="Zennaroi Earring",
        body="Kaykaus Bliaut",hands=gear.chirhands_block,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Solemnity Cape",waist="Ninurta's sash",legs=gear.chirlegs_block,feet=gear.chirfeet_block }


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers mitts +1",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific pretarget
-------------------------------------------------------------------------------------------------------------------

function party_index_lookup(name)
    for n=1,party.count do
        if party[n].name == name then
            return n
        end
    end
    return nil
end

function pretarget(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		eventArgs.cancel = true
		send_command('input /item "Echo Drops" <me>')
	end
    --[[if T{"Cure","Cure II","Cure III","Cure IV"}:contains(spell.name) and spell.target.type == 'PLAYER' and not spell.target.charmed and state.AutoAga.value then
        if not party_index_lookup(spell.target.name) then
            return
        end
        local inrange = 1
        local hpp_deficit = 0
        local memindex = party_index_lookup(spell.target.name)
        for i=party.count,1,-1 do
            local current_int = i - 1
            local current_mem = i - current_int 
            while current_int > 0 do
            if i ~= memindex then
                local memdist = (party[i].x - party[memindex].x)^2 + (party[i].y - party[memindex].y)^2 + (party[i].z - party[memindex].z)^2
                if math.sqrt(memdist) < 15 then
                    if party[i].hpp<75 and party[i].status_id ~= 2 and party[i].status_id ~= 3 then
                        inrange = inrange + 1
                        hpp_deficit = hpp_deficit + (100 - party[i].hpp)
                    end
                end
            else 
                hpp_deficit = hpp_deficit + (100 - party[i].hpp)
            end
        end
        if inrange > 1 then
            eventArgs.cancel = true
            if hpp_deficit / inrange > AgaBenchmark then
                send_command('input /ma "Curaga IV" '..spell.target.name)
            else 
                send_command('input /ma "Curaga III" '..spell.target.name)
            end
        end         
    end]]
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
        eventArgs.handled = true
    end
end 


Cures 									= S{'Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'}
Curagas 								= S{'Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cura','Cura II','Cura III'}
Lyna									= S{'Paralyna','Silena','Viruna','Erase','Stona','Blindna','Poisona'}
Barspells								= S{'Barfira','Barfire','Barwater','Barwatera','Barstone','Barstonra','Baraero','Baraera','Barblizzara','Barblizzard','Barthunder','Barthundra'}
Turtle									= S{'Protectra V','Shellra V'}
Cursna									= S{'Cursna'}
Regens									= S{'Regen','Regen II','Regen III','Regen IV','Regen V'}
Enhanced								= S{'Flurry','Haste','Refresh'}
Banished								= S{'Banish','Banish II','Banish III','Banishga','Banishga II'}
Smited									= S{'Holy','Holy II'}
Reposed									= S{'Repose','Flash'}
Potency									= S{'Slow','Paralyze'}
Defense									= S{'Stoneskin'}


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Impact" then
        equip(sets.precast.FC,sets.precast.FC.Impact)
    end
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell,action,spellMap,eventArgs)
	local abil_recasts = windower.ffxi.get_ability_recasts()
    if player.sub_job == 'SCH' then
    	local currentCharges = get_current_strategem_count()
    	if Lyna:contains(spell.english) and (not buffactive[366]) and (currentCharges > 0) then
            if (not buffactive[453]) and abil_recasts[453] == 0 then
                eventArgs.cancel = true
                send_command('@input /ja "accession" <me>;wait 1.5;input /ma "'..spell.name..'" '..spell.target.name)
            end
        end
    end
end        


function job_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Healing Magic' then
		if Cures:contains(spell.name) then
			if  world.day =='Lightsday' or  world.weather_element == 'Light'  or buffactive == 'Aurorastorm' then
				equip(sets.midcast.CureWithLightWeather)
			elseif Enmity == 1 then
				equip(sets.midcast.CureEnmity)
			elseif buffactive['Afflatus Solace'] then
				equip(sets.midcast.CureSolace)
			end
		end
		if Curagas:contains(spell.name) then
			if  world.day =='Lightsday' or  world.weather_element == 'Light'  or buffactive == 'Aurorastorm' then
				equip(sets.midcast.CureWithLightWeather)
			else
				equip(sets.midcast.Curaga)
			end
		end
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

---Auto Boost spell
function job_buff_change(buff, gain)
	if state.Skillup.value then
		if not buffactive['AGI Boost'] then
			if buff == 'AGI Boost' and gain == false then
				send_command('input /ma "Boost-AGI" <me>')
			end
		send_command('input /ma "Boost-AGI" <me>')
		end
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
		elseif default_spell_map == 'BarStatus' then
			return "BarStatus"
	elseif (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and (world.day == 'Lightsday' or world.weather_element == 'Light' or buffactive == 'Aurorastorm') then
		return "CureWithLightWeather"
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

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'A10' then -- Aga Toggle --
		if AutoAga == 1 then
			AutoAga = 0
			add_to_chat(8,'Curaga 3 Mode: [Off]')
		else
			AutoAga = 1
			add_to_chat(158,'Curaga 3 Mode: [ON]')
		end
		status_change(player.status)

	elseif cmdParams[1] == 'Z10' then -- Enmity Toggle --
		if Enmity == 1 then
			Enmity = 0
			add_to_chat(8,'Enmity - Mode: [Off]')
		else
			Enmity = 1
			add_to_chat(158,'Enmity - Mode: [ON]')
		end
		status_change(player.status)
		
	
	elseif cmdParams[1] == 'B10' then -- Sublimation Toggle --
		if Sublimation == 1 then
			Sublimation = 0
			add_to_chat(8,'Auto Sublimation: [Off]')
		else
			Sublimation = 1
			add_to_chat(158,'Auto Sublimation: [ON]')
		end
		status_change(player.status)
		
	elseif cmdParams[1] == 'SUPERCURE' then
		if (windower.ffxi.get_spell_recasts()[215] > 0) then
			send_command('input /ma "Cure V" <t>')
		else
			send_command('input /ja "Penury" <me>;wait 1.2;input /ma "Cure V" <me>')
		end
		
	elseif cmdParams[1] == 'SUPERGEN' then
		if (windower.ffxi.get_spell_recasts()[215] > 0) then
			send_command('input /ma "Regen IV" <t>')
		else
			send_command('input /ja "Penury" <me>;wait 1.2;input /ma "Regen IV" <t>')
		end
	
	elseif cmdParams[1] == 'SESUNA' then
		if (windower.ffxi.get_spell_recasts()[246] > 0) then
			send_command('input /ma "Esuna" <t>')
		else
			send_command('input /ja "Afflatus Misery" <me>;wait 1.2;input /ma "Esuna" <me>')
		end
	end
end

function AutoSublimation()      
        if buffactive['Sublimation: Complete'] then
                if player.mpp < Sublimation_benchmark then  
                    if Sublimation == 1 then
                        windower.send_command('@wait 4;input /ja "Sublimation" <me>')
                        add_to_chat(039,'Sublimation Completed: MP Danger Zone')
                    end
                elseif player.mpp < 75 then
                    if Sublimation == 1 then
                        windower.send_command('@wait 4;input /ja "Sublimation" <me>')
                        add_to_chat(159,'Sublimation Completed: MP Mid Range')
                    end
                end
        elseif not buffactive['Sublimation: Complete'] and not buffactive['Sublimation: Activated'] then
            if Sublimation == 1 then
            windower.send_command('@wait 4;input /ja "Sublimation" <me>')
            end
        end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	get_current_strategem_count()
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(10, 14)
end

--[[function nix_all_blinking()
	send_command('@dressup bmn all target T')]]
	
function get_current_strategem_count()
    if player.sub_job == 'SCH' then
        -- returns recast in seconds.
        local allRecasts = windower.ffxi.get_ability_recasts()
        local stratsRecast = allRecasts[231]

        --[[local maxStrategems = (player.main_job_level + 10) / 20]]
    	local maxStrategems = 2
    	
        local fullRechargeTime = maxStrategems * 120

        local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

        return currentCharges
    end
end
