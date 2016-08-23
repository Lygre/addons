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

organizer_items = {
  echos="Echo Drops",
  remedies="Remedy",
  holy="Holy Water"
}

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Corrosive Ooze','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
        'Retinal Glare','Spectral Floe','Subduction','Tem. Upheaval','Tenebral Crush','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Rail Cannon','Diffusion Ray','Scouring Spate'
    }

    -- Magical spells with a primary Agi mod
    blue_magic_maps.MagicalAgi = S{
        'Benthic Typhoon','Silent Storm'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light','Blinding Fulgor'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse','Sub-zero Smash','Entomb'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades','Anvil Lightning'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
        'Tourbillion'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'Learning')


  



    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    ---------------------------------

    sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk", feet="Assimilator's Charuqs +1"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Hashishin Tayt"}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Sirona's Ring",
        back="Iximulew Cape",waist="Ovate Rope",legs="Hagondes Pants +1",feet="Iuitl Gaiters +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'"Fast Cast"+5','STR+9',}},
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin mintan"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Adhemar bonnet",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body=gear.ws_tbody,hands=gear.tp_thands,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Windbuffet Belt +1",legs="Taeon tights",feet="Taeon boots"}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Buremte Gloves"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
    ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Brutal Earring",
    right_ear="Digni. Earring",
    left_ring="Rufescent Ring",
    right_ring="Epona's Ring",
    back="Cornflower Cape",}
    
    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Helios band",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Shengo robe",hands="Helios gloves",ring1="Acumen Ring",ring2="Arvina's Ringlet +1",
        back="Cornflower Cape",waist="Eschan Stone",legs="Hagondes Pants",feet="Mavi basmask"}
		
    sets.precast.WS['Savage Blade'] = {ammo="Ginsen",
        head=gear.tp_thead,neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body=gear.ws_tbody,hands=gear.tp_thands,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Fotia Belt",legs="Telchine Braconi",feet="Battlecast gaiters"}
    
    sets.precast.WS['Chant du Cygne'] = {ammo="Falcon Eye",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body="Abnoba Kaftan",
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Bleating Mantle",
}
    


    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience orb",
        head="Amalric coif",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Taeon Tabard",hands="Leyline gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}
        
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {hands="Hashishin bazubands +1"})
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Cheruski Needle",
        head="Umbani Cap",neck="Tjukurrpa Medal",ear1="Vulcan's Pearl",ear2="Vulcan's Pearl",
        body="Assim. Jubbah +1",hands=gear.tp_thands,ring1="Rajas Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Pipilaka Belt",legs="Taeon tights",feet="Battlecast gaiters"}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Cheruski Needle",
        head="Whirlpool Mask",neck="Tjukurrpa Medal",ear1="Vulcan's Pearl",ear2="Vulcan's Pearl",
        body="Assim. Jubbah +1",hands="Assim. Bazu. +1",ring1="Rajas Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Pipilaka Belt",legs="Manibozho Brais",feet="Assim. Charuqs +1"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Floestone",body="Assim. Jubbah +1",hands="Assimilator's Bazubands +1"})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",head="Rawhide Mask",body="Rawhide vest",hands=gear.tp_thands,
         waist="Pipilaka Belt",legs="Manibozho Brais"})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Assim. Jubbah +1",hands="Assimilator's Bazubands +1",back="Iximulew Cape"})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Assim. Jubbah +1",hands="Iuitl Wristbands",ring2="Ifrit Ring",
         back="Lupine cape",waist="Pipilaka Belt",feet="Assim. Charuqs +1"})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Floestone",ear1="Vulcan's Pearl",body="Assim. Jubbah +1",hands="Assimilator's Bazubands +1",
         ring2="Ifrit Ring",back="Toro Cape",feet="Helios boots"})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Vulcan's pearl",body="Assim. Jubbah +1",hands="Assimilator's Bazubands +1",
         ring2="Ifrit Ring",back="Cornflower Cape"})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Assim. Jubbah +1",hands="Assimilator's Bazubands +1",back="Cornflower Cape",
         waist="Pipilaka Belt"})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
    ammo="Ginsen",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Gwati Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back="Izdubar Mantle",
}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {body="Amalric doublet",legs="Telchine braconi",feet="Helios Boots"})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {hands="Hashishin Bazubands +1",ring1="Metamorph Ring",ring2="Acumen Ring",waist="Salire belt"})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Titan Ring"})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Voltsurge torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Samnuha coat",hands="Rawhide gloves",ring1="Metamorph Ring",ring2="Sangoma Ring",
        back="Cornflower Cape",waist="Eschan Stone",legs="Hashishin tayt",feet="Hashishin Basmak +1"}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        back="Refraction Cape",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Whirlpool Mask",neck="Lavalier +1",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Fravashi Mantle",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Hagondes Sabots" }

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, 
		{head="Amalric coif"})

    sets.midcast['Blue Magic'].Healing = {
        head="Telchine Cap",neck="Incanter's Torque",ear1="Beatific Earring",ear2="Healing Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered cape",waist="Bishop's Sash",legs="Telchine Braconi",feet="Telchine pigaches"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",
        body="Assimilator's Jubbah",hands="Rawhide gloves",
        back="Cornflower Cape",legs="Hashishin tayt",feet="Luhlaza Charuqs"}

    sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, {hands="Hashishin bazubands +1"})
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Magus Bazubands"}
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Magus Bazubands",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
        
    -- Idle sets
    sets.idle = {
    ammo="Ginsen",
    head="Rawhide Mask",
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Crit.hit rate+2','STR+3','Accuracy+11','Attack+13',}},
    legs="Crimson Cuisses",
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Incanter's Torque",
    waist="Reiki Yotai",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Shukuyu Ring",
    back="Solemnity Cape",}

    sets.idle.PDT = {ammo="Impatiens",
        head="Lithelimb cap",neck="Twilight torque",ear1="Sanare Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands="Umuthi Gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Repulse Mantle",waist="Olseni Belt",legs="Hagondes Pants",feet="Battlecast Gaiters"}

sets.idle.MDT = {ammo="Vanir Battery",
        head="Telchine cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Merman's earring",
        body="Vrikodara jupon",hands=gear.fc_thands,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Mubvum. mantle",waist="Flax Sash",legs="Telchine braconi",feet="Telchine pigaches"}

    sets.idle.Town = {
    ammo="Ginsen",
    head="Rawhide Mask",
    body={ name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Crit.hit rate+2','STR+3','Accuracy+11','Attack+13',}},
    legs="Crimson Cuisses",
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Incanter's Torque",
    waist="Reiki Yotai",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Shukuyu Ring",
    back="Solemnity Cape",}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Impatiens",
        head="Lithelimb cap",neck="Twilight torque",ear1="Sanare Earring",ear2="Spellbreaker Earring",
        body="Onca suit",hands=empty,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Repulse Mantle",waist="Flume Belt",legs=empty,feet=empty}

    sets.defense.MDT = {ammo="Vanir Battery",
        head="Telchine cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Eabani earring",
        body="Hashishin mintan +1",hands="Leyline gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Hexerei cape",waist="Witful Belt",legs="Lengo pants",feet="Hashishin basmak +1"}

    sets.Kiting = {ring2="Shneddick Ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Bleating Mantle",
}

    sets.engaged.Acc = { 
    ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Asperity Necklace",
    waist="Reiki Yotai",
    left_ear="Brutal Earring",
    right_ear="Eabani Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back="Atheling Mantle",}
		
    sets.engaged.Refresh = {ammo="Honed Tathlum",
        head="Rawhide mask",neck="Asperity Necklace",ear1="Steelflash earring",ear2="Bladeborn Earring",
        body="Hashishin mintan +1",hands="Umuthi gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Mecistopins Mantle",waist="Windbuffet Belt +1",legs="Quiahuiz trousers",feet="Iuitl gaiters +1"}

    sets.engaged.DW = {
    ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Asperity Necklace",
    waist="Reiki Yotai",
    left_ear="Brutal Earring",
    right_ear="Eabani Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back="Atheling Mantle",}

    sets.engaged.DW.Acc = {
    ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+8','Attack+2',}},
    neck="Asperity Necklace",
    waist="Reiki Yotai",
    left_ear="Brutal Earring",
    right_ear="Eabani Earring",
    left_ring="Pernicious Ring",
    right_ring="Epona's Ring",
    back="Atheling Mantle",}

    sets.engaged.RefreshWeapons = {main="Medeina Kiliji",sub="Bolelabunga"}

    sets.engaged.Nuke = {main="Nehushtan",sub="Gabaxorea"}

    sets.engaged.Swords = {main=gear.dmg_sword,sub=gear.tp_sword}

    sets.engaged.DW.Refresh = {ammo="Ginsen",
        head="Rawhide mask",neck="Asperity Necklace",ear1="Brutal earring",ear2="Suppanomimi",
        body="Hashishin mintan +1",hands="Umuthi gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Flume Belt",legs="Taeon tights",feet="Taeon boots"}


    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
	sets.TreasureHunter = {waist="Chaac Belt"}
    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


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
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 17)
    else
        set_macro_page(2, 17)
    end
end


