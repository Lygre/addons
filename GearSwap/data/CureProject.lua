function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'C1' then -- Aga Toggle --
		send_command('input /ta <stal>')
	status_change(player.status)
	end
end

function bestcure(spell, action, spellMap, eventArgs)
	Cures = {'Cure','Cure II','Cure III','Cure IV','Cure V','Cure IV'}
	windower.ffxi.get_mob_by_target('st')
	local pt_index = party_index_lookup(player.subtarget.name)
	if party[pt_index].hpp 

end

function party_index_lookup(name)
    for i=1,party.count do
        if party[i].name == name then
            return i
        end
    end
    return nil
end

function pretarget(spell, action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	end
    if T{"Cure","Cure II","Cure III","Cure IV"}:contains(spell.name) and spell.target.type == 'PLAYER' and not spell.target.charmed and AutoAga == 1 then
        if not party_index_lookup(spell.target.name) then
            return
        end
        local target_count = 0
        local total_hpp_deficit = 0
        for i=1,party.count do          
		if party[i].hpp<75 and party[i].status_id ~= 2 and party[i].status_id ~= 3 then
			target_count = target_count + 1
			total_hpp_deficit = total_hpp_deficit + (100 - party[i].hpp)
		end
	end
	if target_count > 1 then
		cancel_spell()
		if total_hpp_deficit / target_count > Curaga_benchmark then           
			send_command(';input /ma "Curaga IV" '..spell.target.name..';')
		else
			send_command(';input /ma "Curaga III" '..spell.target.name..';')
		end
	end
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

