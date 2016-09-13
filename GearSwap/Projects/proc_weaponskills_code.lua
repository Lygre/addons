function job_setup()
	state.ProcWeapon:options('None','Katana','Great Katana','Sword','Dagger','Staff','Club','Polearm','Scythe')

	ele_weaponskills = {
		['Katana'] = {'Blade: Ei'},
		['Great Katana'] = {'Tachi: Jinpu', 'Tachi: Koki'},
		['Sword'] = {'Red Lotus Blade', 'Seraph Blade'},
		['Dagger'] = {'Cyclone', 'Energy Drain'},
		['Staff'] = {'Earth Crusher','Sunburst'},
		['Club'] = {'Seraph Strike'},
		['Polearm'] = {'Raiden Thrust'},
		['Scythe'] = {'Shadow of Death'}
}
	proc_weapons = {
		['Katana'] = {'Heishi Shorinken'},
		['Great Katana'] = {'Ark Tachi'},
		['Sword'] = {'Ark Saber'},
		['Dagger'] = {'Atoyac'},
		['Staff'] = {'Treat Staff II'},
		['Club'] = {'Mafic Cudgel'},
		['Polearm'] = {'Pitchfork'},
		['Scythe'] = {'Ark Scythe'}
}
end

function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Proc Weapon Mode' then
		if newValue == 'Katana' then
			equip({main=proc_weapons[state.ProcWeapon.value][1],sub="Taka"})
		elseif newValue == 'None' then
			return
		else
			equip({main=proc_weapons[state.ProcWeapon.value][1]})
			-- print(proc_weapons[state.ProcWeapon.value][1])
		end
	end
end

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'elews1' then
		elews1()
	elseif cmdParams[1] == 'elews2' then
		elews2()
	end
end
function elews1()
	if state.ProcWeapon.value ~= 'None' then
		send_command('input /'..ele_weaponskills[state.ProcWeapon.value][1]..'')
	end
end
function elews2()
	if state.ProcWeapon.value ~= 'None' then
		if #ele_weaponskills[state.ProcWeapon.value] > 1 then
			send_command('input /'..ele_weaponskills[state.ProcWeapon.value][2]..'')
		else 
			return
		end
	end
end
