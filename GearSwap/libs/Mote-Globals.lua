-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to user, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the 'gear' table.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.Staff.HMP = 'Chatoyant Staff'
	gear.Staff.PDT = 'Earth Staff'
	
	-- Dark Rings
	gear.DarkRing = {}

	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"
	gear.default.obi_waist = "Cognition Belt"
	gear.default.obi_back = "Toro Cape"
	gear.default.obi_ring = "Strendu Ring"
	gear.default.fastcast_staff = ""
	gear.default.recast_staff = ""
	
	gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -4%',}}


	gear.merlbody_nuke = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-2','MND+5','Mag. Acc.+6','"Mag.Atk.Bns."+15',}}
	gear.merlhead_nuke = {name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Mag. Acc.+3','"Mag.Atk.Bns."+15',}}
	gear.merllegs_nuke = {name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Conserve MP"+5','Mag. Acc.+11','"Mag.Atk.Bns."+9',}}

	
	gear.merlhead_mb = {name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst mdg.+8%','INT+8','"Mag.Atk.Bns."+12',}}
	gear.merlhead_fc = {name="Merlinic Hood", augments={'"Fast Cast"+7','CHR+5',}}
	gear.chirhead = {name="Chironic Hat", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','CHR+9','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
	gear.chirhead_block = {name="Chironic Hat", augments={'Chance of successful block +4','CHR+6','Accuracy+13',}}
	gear.chirhead_pdt = {name="Chironic Hat", augments={'Attack+12','Phys. dmg. taken -4%',}}
	gear.chirbody = {name="Chironic Doublet", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Mag. Acc.+14',}}
	gear.merlhands_pdt = {name="Merlinic Dastanas", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Phys. dmg. taken -2%','MND+7','Mag. Acc.+14','"Mag.Atk.Bns."+2',}}
	gear.chirhands_macc = {name="Chironic Gloves", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Resist Silence"+4','CHR+1','Mag. Acc.+8',}}
	gear.chirhands_sc = {name="Chironic Gloves", augments={'Potency of "Cure" effect received+6%','Crit.hit rate+3','"Refresh"+1','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
	gear.chirhands_da = {name="Chironic Gloves", augments={'"Drain" and "Aspir" potency +10','INT+6','"Mag.Atk.Bns."+14',}}
	gear.chirhands_nuke = {name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Spell interruption rate down -6%','CHR+13','"Mag.Atk.Bns."+13',}}
	gear.chirhands_block = {name="Chironic Gloves", augments={'Attack+10','Chance of successful block +4','CHR+9',}}
	gear.merllegs_dt = {name="Merlinic Shalwar", augments={'Phys. dmg. taken -4%',}}
	gear.merllegs_da = {name="Merlinic Shalwar", augments={'Mag. Acc.+25','"Drain" and "Aspir" potency +11','"Mag.Atk.Bns."+14',}}
	gear.merllegs_mb = {name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+11%','CHR+9','Mag. Acc.+14',}}
	gear.merllegs_phalanx = {name="Merlinic Shalwar", augments={'Mag. Acc.+5','Magic dmg. taken -3%','Phalanx +2','Accuracy+1 Attack+1',}}
	gear.chirlegs = {name="Chironic Hose", augments={'Mag. Acc.+30','Haste+2','MND+10','"Mag.Atk.Bns."+10',}}
	gear.chirlegs_block = {name="Chironic Hose", augments={'Chance of successful block +4','Attack+12',}}
	gear.chirlegs_dt = {name="Chironic Hose", augments={'Damage taken-3%','CHR+2','Accuracy+1',}}
	gear.merlfeet_dt = {name="Merlinic Crackows", augments={'Mag. Acc.+14','Damage taken-3%','DEX+2',}}
	gear.merlfeet_refresh = {name="Merlinic Crackows", augments={'"Store TP"+1','Pet: Attack+21 Pet: Rng.Atk.+21','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	gear.merlfeet_fc = {name="Merlinic Crackows", augments={'Accuracy+13','"Fast Cast"+6','MND+1','Mag. Acc.+9','"Mag.Atk.Bns."+7',}}
	gear.merlfeet_da = {name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +11','CHR+3','Mag. Acc.+11','"Mag.Atk.Bns."+15',}}	
	gear.merlfeet_mb = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst mdg.+10%','Mag. Acc.+5',}}
	gear.chirfeet = {name="Chironic Slippers", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Cure" potency +1%','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}
	gear.chirfeet_block = {name="Chironic Slippers", augments={'Chance of successful block +4','Attack+2',}}
	gear.chirfeet_pdt = {name="Chironic Slippers", augments={'Phys. dmg. taken -3%',}}
	
	gear.ws_tbody = { name="Taeon Tabard", augments={'Accuracy+25','"Triple Atk."+2','Weapon skill damage +3%',}}
	gear.fc_tbody = { name="Taeon Tabard", augments={'"Fast Cast"+5',}}
	
	
	gear.adhemarhead_melee = {name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}}
	
	gear.herchands_melee = {name="Herculean Gloves", augments={'"Dual Wield"+5','DEX+7','Accuracy+13','Attack+4',}}
	gear.herchands_acc = {name="Herculean Gloves", augments={'Rng.Atk.+14','"Triple Atk."+4','AGI+10','Accuracy+13',}}
	gear.herclegs_dt = {name="Herculean Trousers", augments={'"Mag.Atk.Bns."+2','Magic dmg. taken -1%','Phalanx +3','Accuracy+16 Attack+16',}}
	gear.hercfeet_melee = {name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Dual Wield"+5','AGI+4','Accuracy+13',}}
	gear.hercfeet_acc = {name="Herculean Boots", augments={'"Triple Atk."+3','AGI+10','Accuracy+15','Attack+12',}}
	gear.hercfeet_fc = {name="Herculean Boots", augments={'VIT+9','"Fast Cast"+5','Chance of successful block +8','Accuracy+20 Attack+20',}}
	----RNG-------
	gear.adhemarhead_rng = {name="Adhemar Bonnet", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
	gear.hercbody_rng_crit = {name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Crit. hit damage +4%','Rng.Atk.+8',}}
	gear.taeonhands_rng_crit = {name="Taeon Gloves", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+3','Crit. hit damage +2%',}}
	gear.herchands_rng_crit = {name="Herculean Gloves", augments={'Rng.Acc.+24 Rng.Atk.+24','Crit. hit damage +3%',}}
	gear.herclegs_rng_racc = {name="Herculean Trousers", augments={'Rng.Acc.+26','Crit. hit damage +4%','DEX+6',}}
	gear.herclegs_rng_crit = {name="Herculean Trousers", augments={'Rng.Atk.+22','Crit. hit damage +4%','AGI+5','Rng.Acc.+6',}}
	gear.hercfeet_rng_jishnu = {name="Herculean Boots", augments={'Rng.Acc.+3 Rng.Atk.+3','Crit. hit damage +5%','Rng.Acc.+14','Rng.Atk.+14',}}
	gear.taeonfeet_rng_crit = {name="Taeon Boots", augments={'Rng.Acc.+24','Crit.hit rate+3','Crit. hit damage +3%',}}
	SnapBoots = {name="Taeon Boots", augments={'"Snapshot"+5','"Snapshot"+3',}}


	----PUP--------
 	gear.herchead_pup = {name="Herculean Helm", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: Haste+4',}}
	gear.herchands_pup = {name="Herculean Gloves", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Store TP"+11','Pet: Attack+11 Pet: Rng.Atk.+11','Pet: "Mag.Atk.Bns."+3',}}
	gear.herclegs_pup_stp = {name="Herculean Trousers", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Store TP"+11','Pet: DEX+3',}}
	gear.hercfeet_pup_stp = {name="Herculean Boots", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Store TP"+11','Pet: DEX+7','Pet: "Mag.Atk.Bns."+14',}}
	
	gear.repair_hands = { name="Taeon Gloves", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','"Repair" potency +5%','Pet: Haste+1',}}
    gear.repair_head = { name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','"Repair" potency +5%','CHR+10',}}
    gear.repair_body = { name="Taeon tabard", augments={'Pet: "Mag.Atk.Bns."+23','"Repair" potency +5%',}}
    gear.repair_legs = { name="Taeon tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','"Repair" potency +4%','Pet: Damage taken -2%',}}

	gear.pet_mbfeet = { name="Taeon Boots", augments={'Pet: Mag. Acc.+25','"Dual Wield"+5','DEX+2',}}
    gear.pet_tpfeet = { name="Taeon Boots", augments={'Pet: Attack+22 Pet: Rng.Atk.+22','Pet: "Dbl. Atk."+4','Pet: Damage taken -2%',}}
    gear.pet_tpbody = { name="Taeon Tabard", augments={'Pet: Attack+25 Pet: Rng.Atk.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.pet_tphead = { name="Taeon chapeau", augments={'Pet: Attack+24 Pet: Rng.Atk.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -2%',}}
	---------------
    gear.valhead = {name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +1%','STR+13','Accuracy+7',}}
    gear.valhead_temp = {name="Valorous Mask", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+4','AGI+6','Accuracy+4','Attack+14',}}
	gear.valhead_tp = {name="Valorous Mask", augments={'Accuracy+28','"Store TP"+2',}}
    gear.valbody_ws = {name="Valorous Mail", augments={'Accuracy+30','Crit.hit rate+1','STR+15',}}
    gear.valhands = {name="Valorous Mitts", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+1','Accuracy+9',}}
    gear.vallegs_ws = {name="Valor. Hose", augments={'Accuracy+21 Attack+21','STR+6','Attack+2',}}
    gear.vallegs_tp = {name="Valor. Hose", augments={'Accuracy+17','"Store TP"+6','DEX+14',}}
	gear.valfeet_stp = {name="Valorous Greaves", augments={'Accuracy+18 Attack+18','"Store TP"+7','Accuracy+9','Attack+7',}}
	gear.valfeet_ws = {name="Valorous Greaves", augments={'Accuracy+25 Attack+25','Weapon Skill Acc.+5','STR+7','Accuracy+10','Attack+13',}}

    gear.odyssbody_tc = {name="Odyss. Chestplate", augments={'Accuracy+11 Attack+11','VIT+8','Accuracy+11',}}
	gear.odysshands_ws = {name="Odyssean Gauntlets", augments={'Accuracy+22','Weapon skill damage +1%','VIT+9',}}
    gear.odysshands_hybrid = {name="Odyssean Gauntlets", augments={'Accuracy+28','Phys. dmg. taken -4%',}}
    gear.odysslegs_stp = {name="Odyssean Cuisses", augments={'Accuracy+6 Attack+6','"Store TP"+5','Accuracy+3',}}
	gear.odysslegs_ws = {name="Odyssean Cuisses", augments={'Accuracy+10 Attack+10','Weapon skill damage +5%','Accuracy+14','Attack+8',}}
	gear.odysslegs_acc = {name="Odyssean Cuisses", augments={'Accuracy+8 Attack+8','"Store TP"+3','VIT+5','Accuracy+11','Attack+6',}}
    gear.odyssfeet_acc = {name="Odyssean Greaves", augments={'Accuracy+25','Potency of "Cure" effect received+3%','Attack+9',}}
	

	
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------

-- Function to bind GearSwap binds when loading a GS script.
function global_on_load()
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle HybridMode')
	send_command('bind !f9 gs c cycle RangedMode')
	send_command('bind @f9 gs c cycle WeaponskillMode')
	send_command('bind f10 gs c set DefenseMode Physical')
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	send_command('bind !f10 gs c toggle Kiting')
	send_command('bind f11 gs c set DefenseMode Magical')
	send_command('bind !f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^f11 gs c cycle CastingMode')
	send_command('bind f12 gs c update user')
	send_command('bind ^f12 gs c cycle IdleMode')
	send_command('bind !f12 gs c reset DefenseMode')

	send_command('bind ^- gs c toggle selectnpctargets')
	send_command('bind ^= gs c cycle pctargetmode')
end

-- Function to revert binds when unloading.
function global_on_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind @f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')

	send_command('unbind ^-')
	send_command('unbind ^=')
end

-------------------------------------------------------------------------------------------------------------------
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

-- Global intercept on precast.
function user_precast(spell, action, spellMap, eventArgs)
    cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
    refine_waltz(spell, action, spellMap, eventArgs)
end

-- Global intercept on midcast.
function user_midcast(spell, action, spellMap, eventArgs)
	-- Default base equipment layer of fast recast.
	if spell.action_type == 'Magic' and sets.midcast and sets.midcast.FastRecast then
		equip(sets.midcast.FastRecast)
	end
end

-- Global intercept on buff change.
function user_buff_change(buff, gain, eventArgs)
	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if buff:lower() == 'weakness' then
		if gain then
			send_command('timers create "Weakness" 300 up abilities/00255.png')
		else
			send_command('timers delete "Weakness"')
		end
	end
end

sprint_enabled = true
sprint_speed = 59
prev_update = nil

windower.raw_register_event('incoming chunk',function(id, original, modified, injected, blocked)
    if id == 0x37 then
        prev_update = original
        if sprint_enabled then
            return original:sub(1, 44) .. 'C':pack(sprint_speed) .. original:sub(46)
        end
    end
end)

fixed_pos = ''
fixed_ts = os.time()
 
windower.raw_register_event('outgoing chunk',function(id,original,modified,injected,blocked)
    if not blocked then
        if id == 0x15 then
            if (gearswap.cued_packet or midaction()) and fixed_pos ~= '' and os.time()-fixed_ts < 10 then
                return original:sub(1,4)..fixed_pos..original:sub(17)
            else
                fixed_pos = original:sub(5,16)
                fixed_ts = os.time()
            end
        end
    end
end)