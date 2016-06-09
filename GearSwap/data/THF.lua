-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
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
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
    state.IdleMode:options('Normal','STP')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -4%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
    send_command('bind ^F1 exec Soul.txt')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Plunderer's Armlets", waist="Chaac Belt",feet="Skulker's poulaines"}
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    sets.buff['Sneak Attack'] = {}
        --hands="Pillager's Armlets +1"}

    sets.buff['Trick Attack'] = {}
        --hands="Pillager's Armlets +1" }

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {sets.TreasureHunter} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body=gear.hercbody_melee,hands="Pillager's Armlets +1",ring1="Asklepian Ring",
        waist="Flume Belt +1"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = { ammo="Sapience orb",
		head=gear.fc_thead,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Weatherspoon ring",
		legs=gear.fc_tlegs 
		}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head=gear.adhemarhead_melee,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Canny cape",waist="Fotia Belt",legs="Samnuha tights",feet=gear.hercfeet_acc }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Adhemar jacket",back="Grounded Mantle +1"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head=gear.adhemarhead_melee,
		back="Rancorous mantle"
		})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum"})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Falcon Eye",
        head=gear.adhemarhead_melee,ear2="Ishvara earring",
        ring2="Petrov Ring",
        back="Rancorous mantle",feet=gear.hercfeet_ta })
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
        })
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
       })
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
        })

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum"})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",
        })
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",
        })
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",
        })

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum"})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Yetshila",
        })
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Yetshila",
        })
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Yetshila",
        })

    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo tathlum",
        head="Skormoth Mask",neck="Sanctity necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs=gear.herclegs_qd,feet=gear.hercfeet_acc }

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = { ammo="Sapience orb",
		head=gear.fc_thead,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Weatherspoon ring",
		waist="Ninurta's sash",legs=gear.fc_tlegs
		}
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Sapience orb",
		head=gear.fc_thead,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
		body=gear.fc_tbody,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Weatherspoon ring",
		waist="Ninurta's sash",legs=gear.fc_tlegs
		}

    -- Ranged gear
    sets.midcast.RA = {
        head=gear.adhemarhead_melee,neck="Combatant's torque",ear1="Telos Earring",ear2="Enervating Earring",
        body=gear.hercbody_melee,hands="Iuitl Wristbands",
        waist="Eschan stone",legs="Nahtirah Trousers",feet=gear.hercfeet }

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare earring",
        body="Abnoba kaftan",hands="Floral gauntlets",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity cape",waist="Flume belt +1",legs="Samnuha tights",feet="Skadi's jambeaux +1"}

    sets.idle.Town = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare earring",
        body="Abnoba kaftan",hands="Floral gauntlets",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity cape",waist="Flume belt +1",legs="Samnuha tights",feet="Skadi's jambeaux +1"}

    sets.idle.Weak = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Genmei Earring",ear2="Sanare earring",
        body="Abnoba kaftan",hands="Floral gauntlets",ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet }

        sets.idle.STP = set_combine(sets.idle,{ammo="Ginsen",
            neck="Combatant's torque",ear1="Telos earring",ear2="Enervating earring",
            ring1="Rajas Ring",ring2="Petrov Ring",
            legs="Samnuha tights",feet="Carmine Greaves"})


    -- Defense sets

    sets.defense.Evasion = {
        head=gear.adhemarhead_melee,neck="Combatant's torque",ear1="Eabani earring",ear2="Infused earring",
        body="Adhemar jacket",hands=gear.herchands_acc,ring1="Defending Ring",ring2="Beeline Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="Samnuha Tights",feet=gear.hercfeet }

    sets.defense.PDT = { ammo="Brigantia pebble",
        head="Lithelimb cap",neck="Loricate torque +1",ear1="Impregnable earring",ear2="Genmei Earring",
        body="Adhemar jacket",hands="Umuthi gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Flume Belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee }

    sets.defense.MDT = {
        head="Skormoth mask",neck="Loricate torque +1",ear1="Eabani Earring",ear2="Sanare Earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee }


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head=gear.adhemarhead_melee,neck="Defiant collar",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating mantle",waist="Windbuffet belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee }
    sets.engaged.Acc = {ammo="Honed tathlum",
        head="Skormoth mask",neck="Combatant's torque",ear1="Zennaroi Earring",ear2="Telos earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Reiki yotai",legs="Samnuha tights",feet=gear.hercfeet_acc }
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = {
        head="Skormoth mask",neck="Combatant's torque",ear1="Zennaroi Earring",ear2="Telos earring",
        body="Adhemar jacket",hands="Floral gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Reiki yotai",legs="Samnuha tights",feet=gear.hercfeet_acc }

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = {}

    sets.engaged.Evasion = {
        head=gear.adhemarhead_melee,neck="Combatant's torque",ear1="Eabani earring",ear2="Infused earring",
        body="Adhemar jacket",hands=gear.herchands_acc,ring1="Defending Ring",
        back="Solemnity Cape",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet }
    sets.engaged.Acc.Evasion = {
        head=gear.adhemarhead_melee,neck="Combatant's torque",ear1="Eabani earring",ear2="Infused earring",
        body="Adhemar jacket",hands=gear.herchands_acc,ring1="Defending Ring",
        back="Solemnity Cape",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet }

    sets.engaged.PDT = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Samnuha tights",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee }
    sets.engaged.Acc.PDT = {
        head=gear.adhemarhead_melee,neck="Loricate torque +1",ear1="Eabani Earring",ear2="Suppanomimi",
        body="Adhemar jacket",hands="Samnuha tights",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume belt +1",legs="Samnuha tights",feet=gear.hercfeet_melee }

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 16)
    elseif player.sub_job == 'WAR' then
        set_macro_page(3, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    else
        set_macro_page(2, 5)
    end
end