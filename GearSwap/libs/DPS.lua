function variables() 
		attacks = 0
        hits = 0
        trend = {}
        trend_write_pos = 0
 
        define_user_functions()
 
        options = { usePDT = false, meleeMode = 'DD', autopilot = false,
                HUD = { x = 100, y = 100, visible = true, trendSize = 40 }
        }
       
        build_HUD()

end



function define_user_functions()
 
        function swing(hit)
                trend_write_pos = trend_write_pos + 1
                if trend_write_pos > options.HUD.trendSize then
                        trend_write_pos = 1
                end
               
                if hit then
                        hits = hits + 1
                        attacks = attacks + 1
                        trend[trend_write_pos] = 1
                else
                        attacks = attacks + 1
                        trend[trend_write_pos] = 0
                end
               
                local overall = math.floor(hits / attacks * 100 - .1)
                local recent = math.floor(table.sum(trend) / #trend * 100 - .1)
               
                windower.text.set_text(rtAcc, tostring(overall))
                windower.text.set_text(rtTrend, tostring(recent))
				
				if recent >= 92 then
					windower.text.set_color(rtTrend, 255, 2, 255, 2)
				elseif recent < 92 then
					if recent < 79 then
					windower.text.set_color(rtTrend, 255, 255, 2, 60)
					else
					windower.text.set_color(rtTrend, 255, 200, 100, 2)
					end
				
				end

        end
 
        windower.register_event('action',function (act)
                if act.actor_id == windower.ffxi.get_player().id then
                        if act.category == 1 then
                                for i=1,act.targets[1].action_count do
                        if act.targets[1].actions[i].message == 1 or act.targets[1].actions[i].message == 67 then
                                                swing(true)
                                        else
                                                swing(false)
                                        end
                                end
                        end
                end
        end)
 
 
end
 
 
function build_HUD()
 
        hudBord = 'blu_hud_border'
       
        windower.prim.create(hudBord)
        windower.prim.set_color(hudBord, 255, 2, 2, 2)
        windower.prim.set_position(hudBord, options.HUD.x - 9, options.HUD.y-2)
        windower.prim.set_size(hudBord, 140, 70)
        windower.prim.set_visibility(hudBord, options.HUD.visible)
       
        hudBG = 'blu_hud_background'
       
        windower.prim.create(hudBG)
        windower.prim.set_color(hudBG, 100, 40, 40, 100)
        windower.prim.set_position(hudBG, options.HUD.x - 7, options.HUD.y)
        windower.prim.set_size(hudBG, 135, 65)
        windower.prim.set_visibility(hudBG, options.HUD.visible)
       
        rtAcc = 'blu_realtime_accuracy_display'
 
        windower.text.create(rtAcc)
    windower.text.set_location(rtAcc, options.HUD.x, options.HUD.y)
    windower.text.set_bg_color(rtAcc, 0, 0, 0, 0)
    windower.text.set_color(rtAcc, 255, 255, 255, 255)
    windower.text.set_font(rtAcc, 'Arial')
    windower.text.set_font_size(rtAcc, 18)
    windower.text.set_bold(rtAcc, false)
    windower.text.set_italic(rtAcc, false)
    windower.text.set_text(rtAcc, '--')
    windower.text.set_bg_visibility(rtAcc, options.HUD.visible)
        windower.text.set_visibility(rtAcc, options.HUD.visible)
       
        rtTrend = 'blu_realtime_accuracy_trend_display'
 
        windower.text.create(rtTrend)
    windower.text.set_location(rtTrend, options.HUD.x + 40, options.HUD.y + 2)
    windower.text.set_bg_color(rtTrend, 0, 0, 0, 0)
    windower.text.set_color(rtTrend, 255, 255, 255, 255)
    windower.text.set_font(rtTrend, 'Arial')
    windower.text.set_font_size(rtTrend, 24)
    windower.text.set_bold(rtTrend, false)
    windower.text.set_italic(rtTrend, false)
    windower.text.set_text(rtTrend, '--')
    windower.text.set_bg_visibility(rtTrend, options.HUD.visible)
        windower.text.set_visibility(rtTrend, options.HUD.visible)
       
        gMode = 'blu_gear_mode_display'
 
        windower.text.create(gMode)
    windower.text.set_location(gMode, options.HUD.x + 40, options.HUD.y + 40)
    windower.text.set_bg_color(gMode, 0, 0, 0, 0)
    windower.text.set_color(gMode, 255, 255, 0, 0)
    windower.text.set_font(gMode, 'Arial')
    windower.text.set_font_size(gMode, 11)
    windower.text.set_bold(gMode, true)
    windower.text.set_italic(gMode, false)
    windower.text.set_text(gMode, 'Recent')
    windower.text.set_bg_visibility(gMode, options.HUD.visible)
        windower.text.set_visibility(gMode, options.HUD.visible)
       
        abText = 'blu_ability_availability_display'
 
        windower.text.create(abText)
    windower.text.set_location(abText, options.HUD.x-1, options.HUD.y - 12)
    windower.text.set_bg_color(abText, 0, 0, 0, 0)
    windower.text.set_color(abText, 255, 200, 180, 0)
    windower.text.set_font(abText, 'Lucida Console')
    windower.text.set_font_size(abText, 8)
    windower.text.set_bold(abText, true)
    windower.text.set_italic(abText, false)
    windower.text.set_text(abText, '')
    windower.text.set_bg_visibility(abText, options.HUD.visible)
        windower.text.set_visibility(abText, options.HUD.visible)
       
end
 
function file_unload()
        windower.prim.delete(hudBord or "")
        windower.prim.delete(hudBG or "")
        windower.text.delete(gMode or "")
        windower.text.delete(rtTrend or "")
        windower.text.delete(rtAcc or "")
        windower.text.delete(abText or "")
end
 

 
pDIF = 0
total_damage = 0
total_damage_array = L{}
max_count = 15
max_acc_count = 10
total_crit = 0

 
windower.register_event('action',function (act)
    local actor = act.actor_id
    local category = act.category
    local player = windower.ffxi.get_player()
      
    if actor == player.id and category == 1 then
	
        local round_hits = act.targets[1].action_count
		
        for i = 1,round_hits do
			if act.targets[1].actions[i].reaction == 8 then
				if act.targets[1].actions[i].message ~= 67 then
				total_damage_array:append(act.targets[1].actions[i].param)
				end
			end
		end
			approximate_pdif()
    end
end)
 
 
function approximate_pdif()
    local total_damage = 0
    local total_hits = math.min(max_count,total_damage_array:length())
     
    if total_damage_array:length() < 1 then
        return
    end
     
    for i=1,total_hits do
        local v = total_damage_array:last(i)
        total_damage = total_damage+v
    end
    pDIF = ( (total_damage/total_hits) / (D + fSTR) )
end

