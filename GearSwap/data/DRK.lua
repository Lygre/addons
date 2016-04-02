--[[     
 === Notes ===
    Souleater: By default, souleater will cancel after any weaponskill is used.  
               However, if Blood Weapon is used, Souleater will remain active for it's duration.
               It will be canceled after your next weaponskill, following Blood Weapon wearing off. 
               This behavior can be toggled off/on with @f9 (window key + f9) 
               Another option is to Nethervoid + Drain II and pop SE. It will stay up in this
               scenario as well.
    Last Resort: There is an LR Hybrid Mode toggle present. This is useful when Last Resort may be risky.
    
    I simplified this lua since I got Liberator. There is support for GS by using sets.engaged.GreatSword
    but you will have to edit the list in job_setup so that your GS is present.
    
    Set format is as follows: 
    sets.engaged.[CombatForm][CombatWeapon][Offense or DefenseMode][CustomGroup]
    CustomGroups = AM3
    
    TODO: Get STR/DEX Augment on Acro Legs.
    Make a new pair of boots + gloves with acc/atk 20 stp+5 str/dex+7
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')

end
 
 
-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- Set the default to false if you'd rather SE always stay acitve
    state.SouleaterMode = M(true, 'Soul Eater Mode')
    
    wsList = S{'Spiral Hell', 'Insurgency'}
    gsList = S{'Malfeasance', 'Macbain', 'Zulfiqar' }
    drk_sub_weapons = S{"Sangarius +1", "Reikiko"}

    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Regen')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    
    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    
    select_default_macro_book()
	
    get_combat_form()
    get_combat_weapon()
    update_melee_groups()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
     --------------------------------------
     -- Start defining the sets
     --------------------------------------
     -- Augmented gear
     Acro = {}
     Acro.Hands = {}
     Acro.Feet = {}
    
     Acro.Hands.Haste = {name="Acro gauntlets", augments={'Accuracy+25','"Store TP"+6','Weapon skill damage +2%'}}
     Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+25','"Store TP"+6','Weapon skill damage +2%'}}

     Acro.Feet.STP = {name="Acro Leggings", augments={'Crit. hit damage +2%','Accuracy+16 Attack+16','"Store TP"+6'}} 
     Acro.Feet.WSD = {name="Acro Leggings", augments={'Crit. hit damage +2%','Accuracy+16 Attack+16','"Store TP"+6'}} 


     Niht = {}
     Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+13','Dark magic skill +3','"Drain" and "Aspir" potency +17','Weapon skill damage +3%'}}
     Niht.WSD = {name="Niht Mantle", augments={'Attack+13','Dark magic skill +3','"Drain" and "Aspir" potency +17','Weapon skill damage +3%'}}

     -- Precast Sets
     -- Precast sets to enhance JAs
     sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets"}
     sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
     sets.precast.JA['Dark Seal'] = {head="Fallen's burgeonet +1"}
     sets.precast.JA['Souleater'] = {head="Ignominy burgeonet +1"}
     --sets.precast.JA['Last Resort'] = {feet="Fallen's Sollerets +1"}
     sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
     sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}

     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = { head="Gavialis Helm" }
     sets.WSBack          = { back="Trepidity Mantle" }
     sets.NightAmmo       = { ammo="Ginsen" }
     sets.DayAmmo         = { ammo="Tengu-No-Hane" }
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
     sets.Lugra           = { ear1="Lugra Earring +1" }
     sets.Brutal          = { ear1="Brutal Earring" }
 
     sets.reive = {neck="Ygnas's Resolve +1"}
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        head="Yaoyotl Helm",
    	body="Mes'yohi Haubergeon",
        legs=gear.vallegs_tp,
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
        ammo="Sapience Orb",
        head="Carmine Mask",
		neck="Voltsurge torque",
        body=gear.odyssbody_tc,
        ear1="Loquacious Earring",
		ear2="Enchanter earring +1",
        hands="Leyline gloves",
		ring1="Weatherspoon Ring",
        ring2="Prolix Ring",
		legs="Founder's Hose",
        feet="Odyssean greaves"
     }

     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
     })
     sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
     })
     
     -- Midcast Sets
     sets.midcast.FastRecast = { ammo="Sapience orb",
         head="Carmine Mask",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
         body=gear.odyssbody_tc,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
         back="Grounded Mantle +1",waist="Ninurta's Sash",legs="Founder's hose",feet=gear.odyssfeet_acc
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = sets.midcast.FastRecast
 
     
	 sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
         neck="Incanter's torque",
         head="Carmine Mask",
         body="Founder's breastplate",
         ring1="Globidonta Ring",
         back="Aput Mantle"
     })

     sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
         head="Carmine mask",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Gwati Earring", 
         body="Founder's breastplate",hands="Leyline gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1", 
         back="Aput Mantle",waist="Eschan Stone",legs="Founder's Hose",feet=gear.odyssfeet_acc
     }

     sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
         head="Ignominy burgeonet +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
         body="Demon's Harness",hands="Fallen's Finger Gauntlets +1",ring1="Evanescence Ring",ring2="Archon Ring",
         back="Niht Mantle",waist="Casso Sash",legs="Heathen's Flanchard +1",feet=gear.odyssfeet_acc
     }
	 
     sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
         ammo="Psilomene",
         ear2="Calamitous earring",
         body="Founder's breastplate", hands="Acro gauntlets",ring2="Kunaji Ring", 
         legs="Heathen's Flanchard +1", feet="Amm greaves"})
     
     sets.midcast['Drain'] = set_combine(sets.midcast['Dark Magic'], {
		head=empty,
        body="Lugra Cloak",
     })

     sets.midcast['Aspir'] = sets.midcast['Drain']

     sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
         back="Chuparrosa Mantle",
         hands="Pavor Gauntlets",
     })

     sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
         hands="Heathen's Gauntlets +1"
     })
     sets.midcast['Absorb-STR'] = sets.midcast.Absorb
     sets.midcast['Absorb-DEX'] = sets.midcast.Absorb
     sets.midcast['Absorb-AGI'] = sets.midcast.Absorb
     sets.midcast['Absorb-INT'] = sets.midcast.Absorb
     sets.midcast['Absorb-MND'] = sets.midcast.Absorb
     sets.midcast['Absorb-VIT'] = sets.midcast.Absorb
     sets.midcast['Absorb-CHR'] = sets.midcast.Absorb
     sets.midcast['Absorb-Attri'] = sets.midcast.Absorb
     sets.midcast['Absorb-Acc'] = sets.midcast.Absorb

   
     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Floestone",
         head=gear.valhead, neck="Fotia Gorget", ear1="Brutal Earring", ear2="Moonshade Earring",
         body=gear.valbody_ws, hands=gear.valhands, ring1="Rajas Ring", ring2="Petrov Ring",
         back="Niht Mantle", waist="Fotia Belt", legs=gear.odysslegs_ws, feet=gear.valfeet_ws
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
		head=gear.valhead,
		body=gear.valbody_ws
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
		head=gear.valhead_temp, ear1="Zennaroi Earring",
		back="Grounded Mantle +1",  
     })
	
     ------SCYTHE WS SETS
	 -- INSURGENCY
     -- 20% STR / 20% INT 
     -- Base set only used at 3000TP to put AM3 up
     sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
         head=gear.valhead,ear2="Zennaroi earring",
         body=gear.valbody_ws,
         back="Bleating Mantle"
     })
     sets.precast.WS.Insurgency.AM3 = set_combine(sets.precast.WS.Insurgency, {
		ear2="Moonshade earring",
		ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1"
     })
     sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
		back="Lupine Cape"
     })
     sets.precast.WS.Insurgency.AM3Mid = set_combine(sets.precast.WS.Insurgency.Mid, {
		ear2="Moonshade earring",
		ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1"
	 })
     sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
         body="Fallen's Cuirass +1",
		 back="Grounded mantle +1", legs=gear.odysslegs_ws
     })
     sets.precast.WS.Insurgency.AM3Acc = set_combine(sets.precast.WS.Insurgency.Acc, {
		ear2="Moonshade earring",
		ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1"
	 })
     
     -- CROSS REAPER
     -- 60% STR / 60% MND
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
         head="Heathen's Burgonet +1",
         hands="Founder's gauntlets",ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1",
         legs=gear.odysslegs_ws, })

     sets.precast.WS['Cross Reaper'].AM3 = set_combine(sets.precast.WS['Cross Reaper'], {})

     sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS['Cross Reaper'], {
         head="Heathen's Burgonet +1",
         hands=Acro.Hands.STP,
         waist="Metalsinger Belt", legs="Founder's Hose"})

     sets.precast.WS['Cross Reaper'].AM3Mid = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
         waist="Windbuffet Belt +1",
     })
     sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
         body="Fallen's Cuirass +1"
     })
     
     -- ENTROPY
     -- 86-100% INT 
     sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
         ammo="Floestone",
         head="Heathen's Burgonet +1",
         hands="Acro gauntlets", ring1="Shiva Ring +1", ring2="Shiva Ring +1", 
         back="Toro Cape",legs=gear.odysslegs_ws })

     sets.precast.WS.Entropy.AM3 = set_combine(sets.precast.WS.Entropy, {
     })
     sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, { 
     })
     sets.precast.WS.Entropy.AM3Mid = set_combine(sets.precast.WS.Entropy.Mid, {
    })
     sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, {
    })

     -- Quietus
     -- 60% STR / MND 
     sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
         head=gear.valhead, ear1="Lugra Earring +1",
         hands="Acro gauntlets",ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1",        
     })
     sets.precast.WS.Quietus.AM3 = set_combine(sets.precast.WS.Quietus, {})
     sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
         waist="Caudata Belt",
     })
     sets.precast.WS.Quietus.AM3Mid = set_combine(sets.precast.WS.Quietus.Mid, {
     })
     sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, sets.precast.WS.Acc)

     -- SPIRAL HELL
     -- 50% STR / 50% INT 
     sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
         head="Heathen's Burgonet +1",
		 ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1",
         legs="Heathen's flanchard +1",
         waist="Caudata belt",
     })
     sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid)
     sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc)

     -- SHADOW OF DEATH
     -- 40% STR 40% INT - Darkness Elemental
     sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
         head="Ignominy burgeonet +1", neck="Fotia Gorget", ear1="Friomisi Earring",
         body="Fallen's Cuirass +1", hands="Fallen's Finger Gauntlets +1",ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1",
         back="Toro Cape", legs="Founder's hose", waist="Caudata Belt", feet="Ignominy Sollerets"})
     sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid)
     sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc)

	 ------GS WS SETS 
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		head=gear.valhead,
		ring1="Ifrit's Ring +1",ring2="Ifrit's ring +1",
     })
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
         ammo="Amar cluster",
         head="Yaoyotl Helm",
     }) 
     sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
        ammo="Ginsen",
        --head="Jumalik Helm",
        hands="Founder's Gauntlets",
        waist="Caudata Belt",legs="Acro Breeches",
        })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)


     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         head="Pixie Hairpin +1", neck="Sanctity Necklace", ear1="Friomisi Earring", 
         body="Fallen's Cuirass +1", hands=Acro.Hands.STP, ring1="Shiva Ring +1",ring2="Archon Ring",
         back="Toro Cape", waist="Eschan Stone",legs="Founder's hose Trousers", feet="Ignominy Sollerets"})
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         head="Ighwa Cap",
         hands="Leyline Gloves",
         back="Bleating Mantle",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
	--SAVAGE BLLADE
	sets.precast.WS['Savage Blade'] = {
		ammo="Ginsen",
		head="Ighwa cap", neck="Fotia Gorget", ear1="Brutal Earring", ear2="Moonshade Earring",
		body="Chozoron Coselete", hands="Heathen's Gauntlets +1", ring1="Rajas Ring", ring2="Globidonta Ring",
		back="Niht Mantle", waist="Fotia Belt", legs="Heathen's flanchard +1", feet="Acro Leggings"}
	
	sets.precast.WS['Savage Blade'].Acc = {
		ammo="Ginsen",
		head="Founder's corona", neck="Fotia Gorget", ear1="Brutal Earring", ear2="Moonshade Earring",
		body="Chozoron Coselete", hands="Heathen's Gauntlets +1", ring1="Rajas Ring", ring2="Globidonta Ring",
		back="Niht Mantle", waist="Fotia Belt", legs="Heathen's flanchard +1", feet="Acro Leggings"}

     -- Resting sets
     sets.resting = {
         head=empty,
         body="Lugra Cloak", ring1="Defending Ring", ring2="Sheltered Ring",
         legs="Carmine cuisses"
     }
 
     -- Idle sets
     sets.idle.Town = {
         ammo="Ginsen",
         head="Heathen's Burgonet +1", neck="Coatl gorget +1", ear1="Lugra Earring +1", ear2="Infused Earring",
         body="Chozoron Coselete", hands="Founder's Gauntlets", ring1="Rajas Ring", ring2="Defending Ring",
         back="Niht Mantle",waist="Flume Belt +1", legs=gear.vallegs_tp, feet="Acro leggings"}
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Ginsen",
         head="Valorous Mask", neck="Coatl Gorget +1", 
         body="Chozoron Coselete", hands=gear.odysshands_hybrid, ring1=gear.DarkRing.PDT, ring2="Defending Ring",
         back="Solemnity Cape", waist="Flume Belt +1", legs="Founder's Hose", feet="Amm Greaves"})
     
     sets.idle.Regen = set_combine(sets.idle.Field, {
        head=empty,     
         body="Lugra Cloak",
     })
 
     sets.idle.Weak = {
         head="Twilight Helm", neck="Coatl Gorget +1", 
         body="Twilight Mail", ring2="Defending Ring", 
         back="Solemnity Cape", waist="Flume Belt +1", legs=gear.vallegs_tp, feet="Amm Greaves"}

     sets.refresh = { 
        head=empty,
         neck="Coatl Gorget +1",
         body="Lugra cloak"
     }
     
     -- Defense sets
     sets.defense.PDT = {
		ammo="Brigantia pebble",
         head="Ighwa Cap", neck="Loricate torque +1", ear1="Impregnable Earring",ear2="Genmei Earring",
         body="Chozoron coselete", hands=gear.odysshands_hybrid, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
         back="Solemnity Cape", waist="Flume Belt +1", legs="Founder's Hose", feet="Amm Greaves"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
		head="Founder's corona",
        ear1="Sanare Earring",
		ear2="Zennaroi earring",
     })
 
     sets.Kiting = {legs="Carmine cuisses"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

     sets.HighHaste = {
         ammo="Ginsen",
         hands=Acro.Hands.STP,
         feet=Acro.Feet.STP
     }
     
     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         head="Ighwa Cap", neck="Loricate torque +1", 
         hands="Founder's gauntlets",
         back="Agema Cape", waist="Flume Belt +1", legs="Founder's Hose", feet="Amm Greaves"
     }
     sets.Defensive_Mid = {
         head="Ighwa Cap", neck="Agitator's Collar", 
         hands=gear.odysshands_hybrid,
         back="Agema Cape", waist="Flume Belt +1", legs="Founder's Hose", feet="Amm Greaves"
     }
     sets.Defensive_Acc = {
         head="Ighwa Cap",neck="Agitator's Collar",
         hands=gear.odysshands_hybrid,
         back="Agema Cape", waist="Flume Belt +1", legs=gear.vallegs_tp, feet="Amm Greaves"
     }
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         ammo="Ginsen",
         head=gear.valhead_temp, neck="Ganesha's Mala", ear1="Steelflash Earring", ear2="Bladeborn Earring",
    	 body=gear.valbody_ws, hands="Acro Gauntlets", ring1="Rajas Ring", ring2="Petrov Ring",
         back="Bleating Mantle", waist="Windbuffet Belt +1", legs=gear.odysslegs_stp, feet=gear.valfeet_stp
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
		body=gear.valbody_ws, ear1="Brutal earring", ear2="Telos earring",
		hands=gear.valhands,
		legs=gear.odysslegs_stp
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		head=gear.valhead_tp, neck="Combatant's torque", ear1="Zennaroi earring",
		back="Grounded Mantle +1", waist="Olseni belt", legs="Acro breeches",
     })
     -- Liberator AM3
     sets.engaged.AM3 = set_combine(sets.engaged, {
		head=gear.valhead_tp, ear1="Brutal earring", ear2="Telos earring",
		
		feet=gear.valfeet_stp
     })
     sets.engaged.Mid.AM3 = set_combine(sets.engaged.AM3, {
		head=gear.valhead_tp, neck="Lissome necklace",
		body=gear.valbody_ws,
		back="Lupine cape", waist="Olseni Belt",legs=gear.odysslegs_ws
     })
     sets.engaged.Acc.AM3 = set_combine(sets.engaged.Mid.AM3, {
		neck="Combatant's torque", ear1="Zennaroi earring",
		legs="Acro breeches"
     })

     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

     --sets.engaged.DW = set_combine(sets.engaged, {
     --   head="Otomi Helm",
     --   ear1="Dudgeon Earring",
     --   ear2="Heartseeker Earring",
     --   waist="Patentia Sash"
     --})
     --sets.engaged.OneHand = set_combine(sets.engaged, {
     --    head="Yaoyotl Helm",
     --    ring2="Mars's Ring",
     --    feet=Acro.Feet.STP
     --})

     sets.engaged.GreatSword = set_combine(sets.engaged, {
         head="Acro Helm", ear1="Brutal Earring", ear2="Lugra Earring +1"
     })
     sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {
         back="Grounded Mantle +1",waist="Olseni Belt"
     })
     sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
         hands="Heathen's Gauntlets +1"
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	head="Twilight Helm",neck="Loricate torque +1",
     	body="Twilight Mail"
     })
    
     sets.buff.Souleater = { 
         head="Ignominy Burgeonet +1"
     }

     sets.buff['Last Resort'] = { 
         feet="Fallen's Sollerets +1" 
     }
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
    --if spell.action_type == 'Magic' then
    --    equip(sets.precast.FC)
    --end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Souleater then
        equip(sets.buff.Souleater)
    end

    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
        if player.tp > 2999 then
            equip(sets.BrutalLugra)
        else -- use Lugra + moonshade
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            else
                equip(sets.Brutal)
            end
        end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
        -- Use Tengu-No-Hane for WS during the day, when acc mode is toggled
        if state.OffenseMode.current == 'Acc' then
            equip(select_ammo())
        end
        -- Trepidity Mantle rule: if your Niht Mantle augs suck, uncomment below
        --if world.day_element == 'Dark' then
        --    equip(sets.WSBack)
        --end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Souleater then
        equip(sets.buff.Souleater)
    end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff['Last Resort'] and state.HybridMode.current == 'PDT' then
        equip(sets.buff['Last Resort'])
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('@wait 1.0;cancel souleater')
            enable("head")
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.refresh)
    end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	if state.Buff.Souleater then
		idleSet = set_combine(idleSet, sets.buff.Souleater)
	end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Last Resort'] and state.HybridMode.current == 'PDT' then
    	meleeSet = set_combine(meleeSet, sets.buff['Last Resort'])
    end
	if state.Buff.Souleater then
		meleeSet = set_combine(meleeSet, sets.buff.Souleater)
	end
    if state.OffenseMode.current == 'Acc' then
        meleeSet = set_combine(meleeSet, select_ammo())
    end
    if state.CombatForm.has_value then
        meleeSet = set_combine(meleeSet, sets.HighHaste)
    end
    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive['Last Resort'] and state.HybridMode.current == 'PDT' then
            equip(sets.buff['Last Resort'])
        end
        get_combat_weapon()
    elseif newStatus == 'Idle' then
        determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    if S{'haste', 'march', 'embrava', 'geo-haste', 'indi-haste'}:contains(buff:lower()) and gain then
        if buffactive['Last Resort'] then
            state.CombatForm:set("Haste")
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            state.CombatForm:reset()
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    -- Drain II HP Boost. Set SE to stay on.
    if buff == "Max HP Boost" then
        if gain or buffactive['Max HP Boost'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- Make sure SE stays on for BW
    if buff == 'Blood Weapon' then
        if gain or buffactive['Blood Weapon'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- AM3 custom group
    if buff == 'Aftermath: Lv.3' then
        classes.CustomMeleeGroups:clear()
	
        if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end

        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    -- Automatically wake me when I'm slept
    --if string.lower(buff) == "sleep" and gain and player.hp > 200 then
    --    equip(sets.Berserker)
    --end

    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Trizek', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end

    if buff == "Souleater" then
        if gain then
            equip(sets.buff.Souleater)
            disable('head')
        else
            enable('head')
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
    get_combat_form()
    get_combat_weapon()
    update_melee_groups()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if state.OffenseMode.current == 'Mid' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Mid'
        end
    elseif state.OffenseMode.current == 'Acc' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Acc'
        end
    else
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    --if war_sj then
        --state.CombatForm:set("War")
    --else
        --state.CombatForm:reset()
    --end
    --if S{'NIN', 'DNC'}:contains(player.sub_job) and drk_sub_weapons:contains(player.equipment.sub) then
    --    state.CombatForm:set("DW")
    --elseif S{'SAM', 'WAR'}:contains(player.sub_job) and player.equipment.sub == 'Rinda Shield' then
    --    state.CombatForm:set("OneHand")
    --else
    --    state.CombatForm:reset()
    --end

    if (buffactive['Last Resort']) then
        if (buffactive.embrava or buffactive.haste) and buffactive.march  then
            add_to_chat(8, '-------------Delay Capped-------------')
            state.CombatForm:set("Haste")
        else
            state.CombatForm:reset()
        end
    end
end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local mythic_ws = "Insurgency"
        
        info.aftermath.weaponskill = mythic_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == mythic_ws and player.equipment.main == 'Liberator' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            if info.aftermath.level == 1 then
                info.aftermath.duration = 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

--windower.register_event('Zone change', function(new,old)
--    if state.LookCool.value == 'On' then
--        send_command('wait 3; gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
--    end
--end)

function select_ammo()
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightAmmo
    else
        return sets.DayAmmo
    end
end


-- Handle zone specific rules
windower.register_event('Zone change', function(new,old)
    determine_idle_group()
end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    if areas.Adoulin:contains(world.area) then
    	classes.CustomIdleGroups:append('Adoulin')
    end
end

--function adjust_melee_groups()
--	classes.CustomMeleeGroups:clear()
--	if state.Buff.Aftermath then
--		classes.CustomMeleeGroups:append('AM')
--	end
--end
function update_melee_groups()

	classes.CustomMeleeGroups:clear()
	
    if buffactive['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM3')
	end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 12)
	elseif player.sub_job == 'SAM' then
		set_macro_page(7, 12)
	else
		set_macro_page(8, 12)
	end
end