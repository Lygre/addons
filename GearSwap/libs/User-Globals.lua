function global_on_load()
	--Generic Mule follow
	send_command('bind ^!F1 exec tenzenki.txt')
	send_command('bind ^!F2 exec tenzen.txt')
	send_command('bind ^!F3 send @others wkr poke tenzen')
	send_command('bind ^!F4 exec warp.txt')
	send_command('bind ^!F5 exec qufim.txt')
	
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


function global_on_unload()
	send_command('unbind ^!F1')
	send_command('unbind ^!F2')
	send_command('unbind ^!F3')
	send_command('unbind ^!F4')
	send_command('unbind ^!F5')

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

end
