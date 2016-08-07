-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
include('organizer-lib.lua')
--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'prep', 'DW', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	
	send_command('bind != input /ja "Haste Samba" <me>')
	
	send_command('unbind f10')
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind F10 gs c cycle OffenseMode')
	send_command('bind !f9 input /lockstyleset 12')
	send_command('unbind ^f9')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('bind f11 gs c cycle CastingMode')
	send_command('bind f12 gs c update user')
	send_command('bind !f12 gs c reset defense')
 select_default_macro_book()

	gear.CasterHead = {name="Chironic Hat", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Conserve MP"+4','CHR+2','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
        gear.RefreshHead = {name="Chironic Hat", augments={'DEX+3','AGI+2','"Refresh"+2','Accuracy+8 Attack+8','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}

	gear.CasterHands = {name="Chironic Gloves", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Haste+1','Mag. Acc.+13',}}
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

   
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)
end
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.RecastStaff,head="Nahtirah Hat",ear2="Loquac. Earring",
		body="Dalmatica +1", hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -1%','Song spellcasting time -5%',}},
		ring1="Prolix Ring",ring2="",
		back="Perimede Cape",waist="Witful Belt",legs="Gendewitha Spats +1",feet="Medium's Sabots"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",back="Pahtli Cape",legs="Doyen Pants",ear1="Mendi. Earring",feet="Iaso Boots"})

	sets.precast.FC.Curaga = set_combine(sets.precast.FC,{body="Heka's Kalasiris",back="Pahtli Cape",legs="Doyen Pants",ear1="Mendi. Earring",feet="Iaso Boots"})

	sets.midcast.Cure =  {main="Chatoyant Staff",sub="Achaq Grip",
		head="Vanya Hood",neck="Incanter's Torque",ear2="",ear1="Novia Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs +1",ring1="Janniston Ring",ring2="Sirona's Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Kaykaus Tights +1",feet="Vanya Clogs"}

	sets.midcast.Curaga = {main="Chatoyant Staff",sub="Achaq Grip",
		head="Vanya Hood",neck="Incanter's Torque",ear2="",ear1="Novia Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs +1",ring1="Janniston Ring",ring2="Sirona's Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Kaykaus Tights +1",feet="Vanya Clogs"}


	gear.default.obi_waist = "Witful Belt"
	gear.default.obi_back = "Phatli Cape"

	sets.precast.FC.EnhancingMagic = set_combine(sets.precast.FC, {})
	
	gear.default.fastcast_staff = "Felibre's Dague"

	sets.precast.FC.BardSong = {main=gear.FastcastStaff,
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel", hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -1%','Song spellcasting time -5%',}},
		ring1="Prolix Ring",ring2="",
		back="Perimede Cape",waist="Witful Belt",legs="Gendewitha Spats +1",feet="Bihu Slippers"}

	sets.precast.HMarch = set_combine(sets.precast.FC.BardSong, {range="Marsyas",hands="Fili Manchettes +1"})
	
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
	
       
	
	sets.fcdagger = {main="Felibre's Dague"}
	
	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {}
		
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.HordeLullaby = {range="Daurdabla"}
	sets.midcast.FoeLullaby = {main="Carnwenhan",sub="Genbu's Shield",range="Gjallarhorn",sub="Genbu's Shield",
		head=gear.CasterHead,neck="Aoidos' Matinee",ear1="Darkside Earring",ear2="Musical Earring",
		body="Fili Hongreline +1",hands="Brioso Cuffs +1",ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Kumbira Cape",waist="Luminary Sash",legs="Mdk. Shalwar +1",feet="Brioso Slippers +1"}

	sets.midcast.Paeon = {range="Daurdabla",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel", hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -1%','Song spellcasting time -5%',}},
		ring1="Prolix Ring",ring2="",
		back="Perimede Cape",waist="Witful Belt",legs="Gendewitha Spats +1",feet="Bihu Slippers"}

	sets.midcast.Madrigal = {head="Aoidos' Calot +2"}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast.Scherzo= {feet="Fili Cothurnes +1"}
	
	sets.midcast.HMarch = {range="Marsyas",hands="Fili Manchettes +1"}
	sets.midcast.Minuet = {body="Fili hongreline +1"}
	sets.midcast.Minne = {}

	sets.midcast['Magic Finale'] = {main="Carnwenhan",range="Gjallarhorn",sub="Genbu's Shield",
		head=gear.CasterHead,neck="Incanter's Torque",ear1="Darkside Earring",ear2="Musical Earring",
		body="Brioso Just. +1",hands=gear.CasterHands,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Kumbira Cape",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}

	sets.midcast.Mazurka = {range="Daurdabla"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main="Carnwenhan",sub="Genbu's Shield",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear2="Ethereal Earring",ear1="Musical Earring",
		body="Fili hongreline +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Witful Belt",legs="Marduk's Shalwar +1",feet="Brioso Slippers +1"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff2 = {main="Carnwenhan",sub="Genbu's Shield",range="Gjallarhorn",sub="Genbu's Shield",
		head=gear.CasterHead,neck="Aoidos' Matinee",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Fili hongreline +1",hands=gear.CasterHands,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Kumbira Cape",waist="Luminary Sash",legs="Marduk's Shalwar +1",feet="Brioso Slippers +1"}

	sets.midcast.Dia = {waist="Chaac Belt"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff = {main="Carnwenhan",sub="Genbu's Shield",range="Gjallarhorn",sub="Genbu's Shield",
		head=gear.CasterHead,neck="Incanter's Torque",ear1="Darkside Earring",ear2="Musical Earring",
		body="Brioso Just. +1",hands=gear.CasterHands,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Kumbira Cape",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}

	sets.midcast.Absorb = {main="Carnwenhan",sub="Genbu's Shield",range="Gjallarhorn",sub="Genbu's Shield",
		head=gear.CasterHead,neck="Incanter's Torque",ear1="Darkside Earring",ear2="Musical Earring",
		body="Brioso Just. +1",hands=gear.CasterHands,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Kumbira Cape",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}


	sets.midcast.Haste = {main="Grioavolr",range="",ammo="Impatiens",
		head="Telchine Cap",neck="Orunmila's Torque",ear2="Loquacious Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="",ring2="",
		back="Swith Cape +1",waist="Witful Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

	sets.midcast['Enhancing Magic'] = {ear1="Andoaa Earring",
		body="Telchine Chas.",hands="Telchine Gloves",head="Telchine Cap",neck="Incanter's Torque",
		back="",waist="",legs="Telchine Braconi",feet="Telchine Pigaches"}


	-- Song-specific recast reduction
	sets.midcast.SongRecast = {}

	

	-- Other general spells and classes.
	
		
	sets.midcast.Stoneskin = {}
	
		
	sets.midcast.Cursna = {
		neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Ephedra Ring",feet="Gende. Galosh. +1"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Sangoma",sub="Genbu's Shield",
		head=gear.RefreshHead,neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Moonshade Earring",
		body="Vanya Robe",hands="Shrieker's Cuffs",ring1="Dark Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet="Fili Cothurnes +1"}

	sets.idle.Town = {main="Carnwenhan",sub="Genbu's Shield",range="Marsyas",
		head="Gala Corsage",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Moonshade Earring",
		body="Councilor's Garb", hands="Kaykaus Cuffs +1",
		ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
		back="Solemnity Cape",waist="Fucho-no-obi",legs="Kaykaus Tights +1",feet="Fili Cothurnes +1"}
	
	sets.idle.Weak = {main="Sangoma",sub="Genbu's Shield",
		head=gear.RefreshHead,neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Moonshade Earring",
		body="Vanya Robe",hands="Shrieker's Cuffs",ring1="Dark Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet="Fili Cothurnes +1"}
	
	
	sets.Misc = {main="Atar I"}
	
	sets.Misc2 = {main="Vourukasha I"}

	sets.Misc3 = {main="Apamajas I"}

	sets.engaged.prep = {main="Carnwenhan", sub="Skinflayer"}

	sets.engaged = {main="Carnwenhan", sub="Skinflayer",
		head="Telchine Cap",neck="Clotharius Torque",ear2="Bladeborn Earring",ear1="Steelflash Earring",
		body="Onca Suit",ring1="Rajas Ring",ring2="Hetairoi Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1"}

	
	sets.engaged.DW = {
		head="Telchine Cap",neck="Clotharius Torque",ear2="Dudgeon Earring",ear1="Heartseeker Earring",
		body="Onca Suit",ring1="Rajas Ring",ring2="Hetairoi Ring",
		back="Bleating Mantle",waist="Reiki Yotai"}

	

	sets.precast.WS = {
		head="Telchine Cap",neck="Iqabi Necklace",ear2="Bladeborn Earring",ear1="Steelflash Earring",
		body="Onca Suit",ring1="Rajas Ring",ring2="Ifrit Ring +1",
		back="Rancorous Mantle",waist="Prosilio Belt +1"}

	
	
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)

	if spell.type == 'BardSong' then

				if buffactive['Nightingale'] or buffactive['Troubadour'] then

					state.useMidcastGear:set('true')

				end

	end

	if not buffactive['Nightingale'] and not buffactive['Troubadour'] then

		state.useMidcastGear:reset()

	end

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
     	 if string.find(spell.name,'March') and not spell.interrupted then
       
            adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Madrigal') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Prelude') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Ballad') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Scherzo') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Minuet') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Etude') and not spell.interrupted then
		adjust_timers(spell, spellMap)
	elseif string.find(spell.name,'Minne') and not spell.interrupted then
		adjust_timers(spell, spellMap)
      	elseif spell.name == 'Haste' and not spell.interrupted then
		adjust_timers(spell, spellMap)
	
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub')
	 elseif newValue == 'DW' then
            disable('main','sub')
	
       	elseif newValue == 'None' then
            enable('main','sub')
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------





-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
		
		
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 8
       
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
           send_command('timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
               send_command('timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1

	if player.equipment.range == 'Marsyas' then 
  		mult = mult + 0.5 
  		
  	end

 
    if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.1 end
	if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.1 end
	if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.1 end
	if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.1 end
	if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.1 end
	if player.equipment.main == "Grioavolr" then mult = mult + 0.9 end -- 

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.58 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +1' then mult = mult + 0.1 end
    if spellMap == 'HMarch' and player.equipment.hands == 'Fili Manchettes +1' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +1" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +1" then mult = mult + 0.1 end

	
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end

  

    
    
 


    local totalDuration = math.floor(mult*120)

    return totalDuration
    
   
	
   
end




-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end




windower.register_event('zone change',reset_timers)
windower.register_event('logout',reset_timers)