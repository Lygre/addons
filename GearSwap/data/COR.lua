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
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	
	organizer_items = {
		cards="Trump Card",
		cardcase="Trump card case",
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

    gear.RAbullet = "Adlivun Bullet"
    gear.WSbullet = "Eminent Bullet"
    gear.MAbullet = "Orichalcum Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	SnapBoots = {name="Taeon Boots", augments={'"Snapshot"+5','"Snapshot"+3',}}
	gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -4%',}}
	gear.fc_tbody = {name="Taeon Tabard", augments={'"Fast Cast"+5',}}
	MeleeBoots = {name="Taeon Boots", augments={'Accuracy+23','"Dual Wield"+5','DEX+2',}}
	
	gear.hercfeet = {name="Herculean Boots", augments={'Rng.Acc.+16 Rng.Atk.+16','"Rapid Shot"+4','AGI+12','Rng.Acc.+15',}}
	gear.herchands = {name="Herculean Gloves", augments={'Rng.Acc.+28','DEX+14','Rng.Atk.+10',}}
	gear.herclegs = {name="Herculean Trousers", augments={'Rng.Acc.+15 Rng.Atk.+15','Crit. hit damage +3%','DEX+8','Rng.Acc.+9',}}
	gear.herclegs_racc = {name="Herculean Trousers", augments={'Rng.Acc.+30','STR+11','Rng.Atk.+15',}}
	gear.herclegs_qd = {name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','STR+2','Mag. Acc.+12','"Mag.Atk.Bns."+13',}}

	
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

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
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}

    
    sets.precast.CorsairRoll = {range="Compensator",head="Lanun Tricorne",hands="Chasseur's gants +1",ring1="Barataria ring",
		back="Camulus's Mantle",legs="Desultor tassets"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's gants +1"})
    
    sets.precast.LuzafRing = {ring1="Barataria ring",ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairShot = {ammo=gear.QDbullet,
        head="Blood Mask",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Infused earring",
        body="Samnuha Coat",hands="Pursuer's Cuffs",ring1="Acumen Ring",ring2="Arvina Ringlet +1",
        back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Chasseur's bottes +1"}
    sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Blood Mask",neck="Sanctity Necklace",ear1="Enchanter Earring +1",ear2="Gwati Earring",
        body="Chasseur's frac +1",hands="Leyline gloves",ring1="Arvina Ringlet +1",ring2="Weatherspoon Ring",
        back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Chasseur's bottes +1"}
	
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
		head=gear.herchead_pup,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		waist="Ninurta's Sash",feet=gear.hercfeet_fc
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {ammo=gear.RAbullet,
        head="Aurore beret +1",
        body="Skopos Jerkin",hands="Lanun Gants",
        waist="Impulse Belt",legs="Nahtirah Trousers",feet=SnapBoots}

       
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
        head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Enervating Earring",ear2="Moonshade Earring",
        body="Adhemar jacket",hands="Pursuer's Cuffs",ring1="Petrov Ring",ring2="Arvina Ringlet +1",
        back="Gunslinger's Cape",waist="Fotia Belt",legs="Nahtirah Trousers",feet=gear.hercfeet}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Laksamana's Hat +1",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Moonshade Earring",
        body="Adhemar jacket",hands=gear.herchands,ring1="Hajduk Ring",ring2="Paqichikaji Ring",
        back="Gunslinger's Cape",waist="Fotia Belt",legs=gear.herclegs_racc,feet=gear.hercfeet}


    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head="Laksamana's hat +1",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Infused earring",
        body="Samnuha coat",hands="Pursuer's cuffs",ring1="Acumen Ring",ring2="Arvina ringlet +1",
        back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Lanun bottes +1"}
    
    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Laksamana's Hat +1",neck="Sanctity necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Pursuer's cuffs",ring1="Archon Ring",ring2="Arvina ringlet +1",
        back="Gunslinger's Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet="Lanun Bottes +1"}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
		head="Haruspex Hat",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		waist="Ninurta's Sash",legs=gear.herclegs,feet=gear.hercfeet}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, 
		{main="Chatoyant Staff",sub="Zuuxowu Grip",
		neck="Incanter's torque",ear1="Beatific Earring",
		ring1="Lebeche Ring",ring2="Sirona's Ring",
		back="Solemnity Cape",waist="Bishop's sash"})
		
    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Ocachi Gorget",ear1="Neritic Earring",ear2="Enervating Earring",
        body="Laksamana's Frac +1",hands=gear.herchands,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Gunslinger's Cape",waist="Yemaya Belt",legs=gear.herclegs,feet=gear.hercfeet}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {main="Surcouf's Jambiya",ammo=gear.RAbullet,
        head="Umbani cap",neck="Iqabi necklace",ear1="Clearview Earring",
        body="Chasseur's Frac +1",ring1="Hajduk Ring",ring2="Paqichikaji Ring",
        legs=gear.herclegs_racc})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ring1="Sheltered Ring",ring2="Defending Ring"}
    

    -- Idle sets
    sets.idle = {range="Compensator",ammo=gear.RAbullet,
        head="Blood Mask",neck="Sanctity Necklace",ear1="Sanare Earring",ear2="Infused Earring",
        body="Mekosuchinae harness",hands=gear.herchands,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Gishdubar sash",legs=gear.herclegs,feet="Skadi's jambeaux +1"}

    sets.idle.Town = {main="Surcouf's Jambiya",sub="Odium",range="Compensator",ammo=gear.RAbullet,
        head="Blood Mask",neck="Sanctity Necklace",ear1="Sanare Earring",ear2="Infused Earring",
        body="Mekosuchinae harness",hands=gear.herchands,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Gishdubar sash",legs=gear.herclegs,feet="Skadi's jambeaux +1"}
    
    sets.idle.PDT = {sub="Legion Scutum",range="Compensator",ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Sanare Earring",ear2="Genmei Earring",
        body="Lanun Frac +1",hands=gear.herchands,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Gishdubar sash",legs=gear.herclegs,feet="Lanun Bottes +1"}

    -- Defense sets
    sets.defense.PDT = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Sanare Earring",ear2="Genmei Earring",
        body="Lanun Frac +1",hands=gear.herchands,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Gishdubar sash",legs=gear.herclegs,feet="Lanun Bottes +1"}

    sets.defense.MDT = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Sanare Earring",ear2="Genmei Earring",
        body="Lanun Frac +1",hands=gear.herchands,ring1="Archon Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Gishdubar sash",legs=gear.herclegs,feet="Chass. Bottes +1"}
    

    sets.Kiting = {feet="Skadi's Jambeaux +1",ring2=gear.DarkRing.PDT}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Lissome Necklace",ear1="Zennaroi earring",ear2="Brutal earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet=gear.hercfeet}
    
    sets.engaged.Acc = {ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Lissome necklace",ear1="Zennaroi Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Petrov Ring",
        back="Grounded Mantle +1",waist="Kentarch Belt",legs="Samnuha Tights",feet=MeleeBoots}

    sets.engaged.DW = {ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Lissome Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet=MeleeBoots}
    
    sets.engaged.DW.Acc = {ammo=gear.RAbullet,
        head=gear.adhemarhead_melee,neck="Lissome necklace",ear1="Zennaroi Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Petrov Ring",
        back="Grounded Mantle +1",waist="Kentarch Belt",legs="Samnuha Tights",feet=MeleeBoots}


    ---sets.engaged.Ranged = {ammo=gear.RAbullet,
       --- head="Lanun Tricorne",neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Volley Earring",
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