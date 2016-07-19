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
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
	state.MagicBurst = M(false, 'Magic Burst')
    state.Buff.Saboteur = buffactive.saboteur or false
	
    send_command('bind ^` gs c toggle MagicBurst')
    send_command('bind !` input /convert')
    send_command('bind @` input /Chainspell')
    send_command('bind ^F1 input /composure')
    send_command('bind !F1 input /Paralyze2')
    send_command('bind @F1 input /slow2')
    send_command('bind ^F2 input /dia3')
    send_command('bind !F2 input /silence')
    send_command('bind @F2 hb on')
    send_command('bind ^F3 hb off')
    send_command('bind @F3 input /Distract3')
    send_command('bind ^F4 input /Frazzle3')
    send_command('bind !F4 input /Haste2')
    send_command('bind @F4 input /Refresh2')
    send_command('bind ^F5 input /addle2')
    send_command('bind !F5 input /bind')
    send_command('bind @F5 input /gravity')
    send_command('bind ^F6 input /sleep2')
    send_command('bind !F6 input /Break')
    send_command('bind @F6 input /dispel')
    send_command('bind ^F7 input /saboteur')
    send_command('bind !F7 input /spontaneity')
    send_command('bind @F7 input /stymie')


end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Sapience Orb",
        head=gear.merlhead_fc,neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Vitivation Tabard +1",hands="Leyline gloves",ring1="Weatherspoon Ring",ring2="Rahab Ring",
        back="Perimede Cape",waist="Witful Belt",legs="Psycloth lappas",feet=gear.merlfeet_fc }

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {})

    sets.precast.WS['Sanguine Blade'] = {}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {main="Chatoyant Staff",sub="Achaq Grip",
        head="Kaykaus mitra",neck="Incanter's Torque",ear1="Roundel Earring",ear2="Beatific Earring",
        body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Haoma's Ring",
        back="Swith Cape +1",waist="Bishop's sash",legs=gear.chirlegs,feet="Medium's Sabots"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {main="Oranyan",sub="Fulcio Grip",
        head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
        body="Telchine Chasuble",hands="Atrophy Gloves +1",
        back="Sucellos's cape",waist="Olympus Sash",legs="Telchine braconi",feet="Lethargy Houseaux +1"}

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{head="Amalric coif",waist="Gishdubar Sash",legs="Lethargy Fuseau +1"})

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
        {legs=gear.merllegs_phalanx})

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        {head=gear.chirhead,
        waist="Emphatikos Rope",legs="Shedir seraweels"})   

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",neck="Nodens Gorget",legs="Shedir seraweels"})
    
    sets.midcast['Enfeebling Magic'] = {main=gear.grio_elemental,sub="Clerisy Strap",ammo="Pemphredo tathlum",
        head=gear.chirhead,neck="Incanter's Torque",ear1="Digni. Earring",ear2="Enchanter Earring +1",
        body="Chironic doublet",hands="Kaykaus cuffs",ring1="Weatherspoon Ring",ring2="Globidonta Ring",
        back="Sucellos's cape",waist="Luminary Sash",legs=gear.chirlegs,feet="Medium's Sabots"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})

    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots +1"})
    
    sets.midcast['Elemental Magic'] = {main=gear.grio_elemental,sub="Niobid strap",ammo="Pemphredo Tathlum",
        head=gear.merlhead_nuke,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Gwati Earring",
        body=gear.merlbody_nuke,hands=gear.chirhands_nuke,ring1="Shiva ring +1",ring2="Shiva ring +1",
        back="Toro Cape",waist="Refoccilation Stone",legs=gear.merllegs_nuke,feet=gear.chirfeet }
    
	sets.magic_burst = {
		head=gear.merlhead_mb,neck="Mizukage-no-kubikazari",
		hands="Amalric gages",ring1="Mujin band",
		back="Seshaw cape",legs=gear.merllegs_mb,feet=gear.merlfeet_mb
		}
	
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Genmei shield",ammo="Pemphredo tathlum",
        head="Pixie hairpin +1",neck="Incanter's Torque",ear1="Friomisi Earring",ear2="Gwati Earring",
        body="Shango robe",hands=gear.chirhands_macc,ring1="Weatherspoon Ring",ring2="Archon Ring",
        back="Perimede Cape",waist="Eschan Stone",legs="Psycloth lappas",feet=gear.chirfeet }

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {hands=gear.chirhands_da, 
		waist="Fucho-no-Obi",legs=gear.merllegs_da,feet=gear.merlfeet_da })

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    --[[sets.midcast.EnhancingDuration = {
		main="Grioavolr",sub="Fulcio Grip",
        head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
        body="Telchine Braconi",hands="Atrophy Gloves +1",
        back="Sucellos's cape",waist="Olympus Sash",legs="Telchine braconi",feet="Lethargy Houseaux +1"}]]
        
    sets.buff.ComposureOther = {main="Oranyan",
        head="Lethargy Chappel +1",
        body="Lethargy Sayon +1",hands="Atrophy gloves +1",
        back="Sucellos's Cape",legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff"}    

    -- Idle sets
    sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Vitivation Chapeau +1",neck="Sanctity necklace",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Amalric doublet",hands=gear.chirhands_sc,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume Belt +1",legs="Psycloth lappas",feet=gear.merlfeet_refresh }

    sets.idle.Town = set_combine(sets.idle,{legs="Carmine cuisses"})
    
    sets.idle.Weak = sets.idle
	
    sets.idle.PDT = set_combine(sets.idle,{ammo="Brigantia pebble",
        neck="Loricate torque +1"})

    sets.idle.MDT = sets.idle.PDT
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle,{ammo="Brigantia pebble",
        neck="Loricate torque +1"})
		
    sets.defense.MDT = sets.defense.PDT
	
    sets.Kiting = {legs="Carmine cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Carmine Mask +1",neck="Lissome Necklace",ear1="Telos Earring",ear2="Eabani earring",
        hands="Gazu bracelet +1",ring1="Rajas Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Reiki Yotai",legs="Carmine cuisses"}
	
    sets.engaged.Defense = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    aspirs = S{'Aspir','Aspir II','Aspir III'}
    sleeps = S{'Sleep','Sleep II'}
    sleepgas = S{'Sleepga','Sleepga II'}

    local degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
        --['Firaga'] = {'Firaga','Firaga II','Firaga III','Firaja'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
        --['Blizzaga'] = {'Blizzaga','Blizzaga II','Blizzaga III','Blizzaja'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
        --['Aeroga'] = {'Aeroga','Aeroga II','Aeroga III','Aeroja'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
        --['Stonega'] = {'Stonega','Stonega II','Stonega III','Stoneja'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
        --['Thundaga'] = {'Thundaga','Thundaga II','Thundaga III','Thundaja'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V','Water VI'}
        --['Waterga'] = {'Waterga','Waterga II','Waterga III','Waterja'}
}
    --[[if not spell.skill == 'Elemental Magic' and not sleepgas:contains(spell.english) and not sleeps:contains(spell.english) and not aspirs:contains(spell.english) then
        return
    end]]

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

    local spell_index = table.find(degrade_array[spell.element],spell.name)

    if spell_recasts[spell.recast_id] > 0 then
        if spell_index > 1 then
            newSpell = degrade_array[spell.element][spell_index - 1]
            add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..newSpell..' instead.')
            send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
            eventArgs.cancel = true
        end
        --[[if aspirs:contains(spell.english) then
            if spell.english == 'Aspir' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Aspir II' then
                newSpell = 'Aspir'
            elseif spell.english == 'Aspir III' then
                newSpell = 'Aspir II'
            end         
        elseif sleeps:contains(spell.english) then
            if spell.english == 'Sleep' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Sleep II' then
                newSpell = 'Sleep'
            end
        elseif sleepgas:contains(spell.english) then
            if spell.english == 'Sleepga' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Sleepga II' then
                newSpell = 'Sleepga'
            end
        end]]
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        if buffactive['Composure'] then
            if spell.target.type ~= 'SELF' then
                equip(sets.buff.ComposureOther)
            end
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, spellMap, eventArgs)
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

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

function job_buff_change(buff, gain)
    if buff == "Commitment" and not gain then
        equip({ring2="Capacity Ring"})
        if player.equipment.right_ring == "Capacity Ring" then
            disable("ring2")
            send_command('@wait 9; input /item "Capacity Ring" <me>;')
        else
            enable("ring2")
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(2, 5)
    end
end