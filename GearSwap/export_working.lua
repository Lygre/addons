--Copyright (c) 2013~2016, Byrthnoth
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of <addon name> nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
--DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

augment_fields = {
	[1] = S{"Accuracy(.%d+) "},
	[2] = S{"Attack(.%d+) "},
	[3] = S{"Evasion(.%d+) "},
	[4] = S{"Crit. hit rate (.%d+)%% "},
	[5] = S{"Enemy crit. hit rate (.%d+) "},
	[6] = S{"Enmity(.%d+)"},
	[7] = S{"Haste(.%d+)%% "},
	[8] = S{"\"Slow\"(.%d+) "},
	[9] = S{"Phys. dmg. taken (.%d+)%% "},
	[10] = S{"Magic dmg. taken (.%d+)%% "},
	[11] = S{"Breath dmg. taken (.%d+)%% "},
	[12] = S{"Damage taken (.%d+)%% "},
	[13] = S{"TP Bonus (.%d+) "},
	-- [14] = S{"Accuracy(.%d+) Attack(.%d+) "},
	-- [15] = S{"Accuracy(.%d+) Ranged Acc.(.%d+) "},
	-- [16] = S{"Attack(.%d+) Ranged Atk.(.%d+) "},
	[14] = S{"Acc(.%d+)/R.Acc(.%d+)/Atk.(.%d+)/R.Atk(.%d+)"},
	[15] = S{"Eva.(.%d+)/Mag. Eva.(.%d+)"},
	-- [19] = S{"Accuracy(.%d+) Ranged Acc.(.%d+) "},
	-- [20] = S{"Attack(.%d+) Ranged Atk.(.%d+) "},
	-- [21] = S{"\"Double Atk.\"(.%d+) Crit. hit (.%d+) "},
	[16] = S{"\"Store TP\"(.%d+) "},
	[17] = S{"\"Dbl. Atk.\"(.%d+) "},
	[18] = S{"\"Triple Atk.\"(.%d+) "},
	[19] = S{"\"Counter\"(.%d+) "},
	[20] = S{"\"Dual Wield\"(.%d+) "},
	[21] = S{"\"Martial Arts\"(.%d+)"},
	[22] = S{"\"Shield Mastery\"(.%d+) "},
	[23] = S{"\"Kick Attacks\"(.%d+) "},
	[24] = S{"\"Subtle Blow\"(.%d+) "},
	[25] = S{"\"Zanshin\"(.%d+) "},
	[26] = S{"Weapon Skill Acc.(.%d+) "},
	[27] = S{"Weapon skill damage (.%d+)%% "},
	[28] = S{"Crit. hit damage (.%d+)%% "},
	[29] = S{"\"Waltz\" potency (.%d+)%% "},
	[30] = S{"\"Waltz\" ability delay -%d "},
	[31] = S{"Sklchn. dmg. (.%d+)%% "},
	[32] = S{"\"Conserve TP\"(.%d+) "},
	[33] = S{"\"Waltz\" TP cost -%d "},
	[34] = S{"TP Bonus (.%d+) "},
	[35] = S{"Quadruple Attack (.%d+)"},
	[36] = S{"Potency of \"Cure\" effect received (.%d+)%% "},
	[37] = S{"Save TP (.%d+)"},
	[38] = S{"Chance of successful block (.%d+) "},
	[39] = S{"\"Phalanx\"(.%d+) "},
	[40] = S{"Sword enhancement spell damage (.%d+) "},
	[41] = S{"Occ. atk. twice"},
	[42] = S{"Occ. atk. twice"},
	[43] = S{"Occ. atk. 2-3 times"},
	[44] = S{"Occ. atk. 2-4 times"},
	[45] = S{"Occ. deals dbl. dmg."},
	[46] = S{"TP Bns. (.%d+)%% "},
	[47] = S{"AGI(.%d+) "},
	[48] = S{"VIT(.%d+) "},
	[49] = S{"STR(.%d+) "},
	[50] = S{"Mag. Evasion(.%d+) "},
	[51] = S{"DEX(.%d+) "},
	[52] = S{"DEF(.%d+) "},
	[53] = S{"\"Avatar perpetuation cost\" -%d "},
	[54] = S{"\"Blood Boon\"(.%d+)"},
	[55] = S{"\"Blood Pact\" ability delay -%d "},
	[56] = S{"Spell interruption rate down %d%% "},
	[57] = S{"Song spellcasting time -%d%% "},
	[58] = S{"Song recast delay -%d "},
	[59] = S{"Occ. quickens spellcasting (.%d+)%% "},
	[60] = S{"Occ. maximizes magic accuracy (.%d+)%% "},
	[61] = S{"MP(.%d+) "},
	[62] = S{"MP recovered while healing (.%d+) "},
	[63] = S{"MND(.%d+) "},
	[64] = S{"Magic Damage(.%d+) "},
	[65] = S{"Magic crit. hit rate (.%d+) "},
	[66] = S{"Magic burst dmg. (.%d+)%% "},
	[67] = S{"Mag. crit. hit dmg. (.%d+)%% "},
	[68] = S{"Mag. Acc.(.%d+)/Mag. Dmg.(.%d+)"},
	[69] = S{"Mag. Acc.(.%d+) \"Mag.Atk.Bns.\"(.%d+) "},
	[70] = S{"Mag. Acc.(.%d+) \"Mag. Atk. B.\"(.%d+) "},
	[71] = S{"Mag. Acc.(.%d+) "},
	[72] = S{"M.B. dmg.(.%d+)%%"},
	[73] = S{"INT(.%d+) "},
	[74] = S{"Indi. eff. dur. (.%d+)"},
	[75] = S{"Helix eff. dur. (.%d+)"},
	[76] = S{"Enh. Mag. eff. dur. (.%d+)"},
	[77] = S{"Blood Pact Dmg.(.%d+) "},
	[78] = S{"Blood Pact ab. del. II -%d "},
	[79] = S{"Avatar: "},
	[80] = S{"\"Regen\" potency (.%d+) "},
	[81] = S{"\"Refresh\"(.%d+) "},
	[82] = S{"\"Occult Acumen\"(.%d+)"},
	[83] = S{"\"Mag. Def. Bns.\"(.%d+) "},
	[84] = S{"\"Mag. Atk. Bns.\"(.%d+) "},
	[85] = S{"\"Fast Cast\"(.%d+) "},
	[86] = S{"\"Elemental Siphon\"(.%d+) "},
	[87] = S{"\"Drain\" and \"Aspir\" potency +%d "},
	[88] = S{"\"Cure\" spellcasting time -%d%% "},
	[89] = S{"\"Cure\" potency (.%d+)%% "},
	[90] = S{"\"Conserve MP\"(.%d+) "},
	[91] = S{"\"Rapid Shot\"(.%d+) "},
	[92] = S{"\"Recycle\"(.%d+) "},
	[93] = S{"Rng. Atk.(.%d+) "},
	[94] = S{"Rng. Acc.(.%d+) "},
	[95] = S{"Ranged Atk.(.%d+) \"Mag. Atk. B.\"(.%d+) "},
	[96] = S{"Attack(.%d+) Ranged Atk.(.%d+) "},
	-- [7] = S{"Attack(.%d+) Ranged Atk.(.%d+) "},
	[97] = S{"Accuracy(.%d+) Ranged Acc.(.%d+) "},
	-- [9] = S{"Accuracy(.%d+) Ranged Acc.(.%d+) "},
	[98] = S{"Acc(.%d+)/R.Acc(.%d+)/Atk.(.%d+)/R.Atk(.%d+)"},
	[99] = S{"\"Snapshot\"(.%d+) "},
	[100] = S{"Pet: "},
	[101] = S{"Breath (.%d+) "},
	[102] = S{"\"Sic\" and \"Ready\" ability delay -%d "},
	[103] = S{"\"Repair\" potency (.%d+)%% "},
	[104] = S{"\"Call Beast\" ability delay -%d "},
	[105] = S{'Pet: "Dbl. Atk."'},
	[106] = S{'Pet: Damage taken '},
	[107] = S{'Pet: "Regen"'},
	[108] = S{'Pet: Haste'},
	[109] = S{'Automaton: "Cure" potency '},
	[110] = S{'Automaton: "Fast Cast"'},
}
function export_set(options)
	local item_list = T{}
	local targinv,all_items,xml,all_sets,use_job_in_filename,use_subjob_in_filename,overwrite_existing
	if #options > 0 then
		for _,v in ipairs(options) do
			if S{'inventory','inv','i'}:contains(v:lower()) then
				targinv = true
			elseif v:lower() == 'all' then
				all_items = true
			elseif S{'xml'}:contains(v:lower()) then
				xml = true
			elseif S{'sets','set','s'}:contains(v:lower()) then
				all_sets = true
				if not user_env or not user_env.sets then
					msg.addon_msg(123,'Cannot export the sets table of the current file because there is no file loaded.')
					return
				end
			elseif v:lower() == 'mainjob' then
				use_job_in_filename = true
			elseif v:lower() == 'mainsubjob' then
				use_subjob_in_filename = true
			elseif v:lower() == 'overwrite' then
				overwrite_existing = true
			end
		end
	end
	
	local buildmsg = 'Exporting '
	if all_items then
		buildmsg = buildmsg..'your all items'
	elseif targinv then
		buildmsg = buildmsg..'your current inventory'
	elseif all_sets then
		buildmsg = buildmsg..'your current sets table'
	else
		buildmsg = buildmsg..'your currently equipped gear'
	end
	if xml then
		buildmsg = buildmsg..' as an xml file.'
	else
		buildmsg = buildmsg..' as a lua file.'
	end
	
	if use_job_in_filename then
		buildmsg = buildmsg..' (Naming format: Character_JOB)'
	elseif use_subjob_in_filename then
		buildmsg = buildmsg..' (Naming format: Character_JOB_SUB)'
	end
	
	if overwrite_existing then
		buildmsg = buildmsg..' Will overwrite existing files with same name.'
	end
	
	msg.addon_msg(123,buildmsg)
	
	if not windower.dir_exists(windower.addon_path..'data/export') then
		windower.create_dir(windower.addon_path..'data/export')
	end
	
	if all_items then
		for i = 0, #res.bags do
			item_list:extend(get_item_list(items[res.bags[i].english:gsub(' ', ''):lower()]))
		end
	elseif targinv then
		item_list:extend(get_item_list(items.inventory))
	elseif all_sets then
		-- Iterate through user_env.sets and find all the gear.
		item_list,exported = unpack_names({},'L1',user_env.sets,{},{empty=true})
	else
		-- Default to loading the currently worn gear.
		local augment_values = T{}
		--local augment_slots = L{}
		for i = 1,16 do -- ipairs will be used on item_list
			if not item_list[i] then
				item_list[i] = {}
				item_list[i].name = empty
				item_list[i].slot = toslotname(i-1)
			end
		end
		
		for slot_name,gs_item_tab in pairs(table.reassign({},items.equipment)) do -- Not sure why I have to reassign it here
			if gs_item_tab.slot ~= empty then
				local item_tab
				local bag_name = to_windower_bag_api(res.bags[gs_item_tab.bag_id].en)
				if res.items[items[bag_name][gs_item_tab.slot].id] then
					item_tab = items[bag_name][gs_item_tab.slot]
					item_list[slot_map[slot_name]+1] = {
						name = res.items[item_tab.id][language],
						slot = slot_name
						}
					if not xml then
						local augments = extdata.decode(item_tab).augments or {}
						local aug_str = ''
						for aug_ind,augment in pairs(augments) do
							if augment ~= 'none' then aug_str = aug_str.."'"..augment:gsub("'","\\'").."'," end
						end
						if string.len(aug_str) > 0 then
							item_list[slot_map[slot_name]+1].augments = aug_str
							--augment_slots:append(item_list[slot_map[slot_name]+1].slot)
							--~local things = {}
							--~things:unpack(augments)
							----print(table.unpack(augments))
							----print(aug_str)
							local aug_value = 0
							for w in string.gmatch(aug_str, "Mag. Acc.(.%d+)") do
								aug_value = aug_value + tonumber(w)
							end

							print(aug_value)
							--print(tonumber(aug_str:gmatch("Mag. Acc.(.%d+) ")) or 0)
						end
						--print(aug_value)

					end
				else
					msg.addon_msg(123,'You are wearing an item that is not in the resources yet.')
				end
			end
		end
		-- for _,str in pairs(item_list) do

		-- 		for _,str in 				
	end
	
	if #item_list == 0 then
		msg.addon_msg(123,'There is nothing to export.')
		return
	else
		local not_empty
		for i,v in pairs(item_list) do
			if v.name ~= empty then
				not_empty = true
				break
			end
		end
		if not not_empty then
			msg.addon_msg(123,'There is nothing to export.')
			return
		end
	end
	
	
	if not windower.dir_exists(windower.addon_path..'data/export') then
		windower.create_dir(windower.addon_path..'data/export')
	end
	
	local path = windower.addon_path..'data/export/'..player.name
	
	if use_job_in_filename then
		path = path..'_'..windower.ffxi.get_player().main_job
	elseif use_subjob_in_filename then
		path = path..'_'..windower.ffxi.get_player().main_job..'_'..windower.ffxi.get_player().sub_job
	else
		path = path..os.date(' %H %M %S%p  %y-%d-%m')
	end
	if xml then
		-- Export in .xml
		if (not overwrite_existing) and windower.file_exists(path..'.xml') then
			path = path..' '..os.clock()
		end
		local f = io.open(path..'.xml','w+')
		f:write('<spellcast>\n  <sets>\n    <group name="exported">\n      <set name="exported">\n')
		for i,v in ipairs(item_list) do
			if v.name ~= empty then
				local slot = xmlify(tostring(v.slot))
				local name = xmlify(tostring(v.name))
				f:write('        <'..slot..'>'..name..'</'..slot..'>\n')
			end
		end
		f:write('      </set>\n    </group>\n  </sets>\n</spellcast>')
		f:close()
	else
		-- Default to exporting in .lua
		if (not overwrite_existing) and windower.file_exists(path..'.lua') then
			path = path..' '..os.clock()
		end
		local f = io.open(path..'.lua','w+')
		f:write('sets.exported={\n')
		for i,v in ipairs(item_list) do
			if v.name ~= empty then
				if v.augments then
					--Advanced set table
					f:write('    '..v.slot..'={ name="'..v.name..'", augments={'..v.augments..'}},\n')
				else
					f:write('    '..v.slot..'="'..v.name..'",\n')
				end
			end
		end
		f:write('}')
		f:close()
	end
end

function unpack_names(ret_tab,up,tab_level,unpacked_table,exported)
	for i,v in pairs(tab_level) do
		local flag,alt
		if type(v)=='table' and i ~= 'augments' and not ret_tab[tostring(tab_level[i])] then
			ret_tab[tostring(tab_level[i])] = true
			unpacked_table,exported = unpack_names(ret_tab,i,v,unpacked_table,exported)
		elseif i=='name' and type(v) == 'string' then
			alt = up
			flag = true
		elseif type(v) == 'string' and v~='augment' and v~= 'augments' and v~= 'priority' then
			alt = i
			flag = true
		end
		if flag then
			if not exported[v:lower()] then
				unpacked_table[#unpacked_table+1] = {}
				local tempname,tempslot = unlogify_unpacked_name(v)
				unpacked_table[#unpacked_table].name = tempname
				unpacked_table[#unpacked_table].slot = tempslot or alt
				if tab_level.augments then
					local aug_str = ''
					for aug_ind,augment in pairs(tab_level.augments) do
						if augment ~= 'none' then aug_str = aug_str.."'"..augment:gsub("'","\\'").."'," end
					end
					if aug_str ~= '' then unpacked_table[#unpacked_table].augments = aug_str end
				end
				if tab_level.augment then
					local aug_str = unpacked_table[#unpacked_table].augments or ''
					if tab_level.augment ~= 'none' then aug_str = aug_str.."'"..augment:gsub("'","\\'").."'," end
					if aug_str ~= '' then unpacked_table[#unpacked_table].augments = aug_str end
				end
				exported[tempname:lower()] = true
				exported[v:lower()] = true
			end
		end
	end
	return unpacked_table,exported
end

function unlogify_unpacked_name(name)
	local slot
	name = name:lower()
	for i,v in pairs(res.items) do
		if type(v) == 'table' then
			if v[language..'_log']:lower() == name then
				name = v[language]
				local potslots = v.slots
				if potslots then potslots = to_windower_api(res.slots[potslots:it()()].english) end
				slot = potslots or 'item'
				break
			elseif v[language]:lower() == name then
				name = v[language]
				local potslots = v.slots
				if potslots then potslots = to_windower_api(res.slots[potslots:it()()].english) end
				slot = potslots or 'item'
				break
			end
		end
	end
	return name,slot
end

function xmlify(phrase)
	if tonumber(phrase:sub(1,1)) then phrase = 'NUM'..phrase end
	return phrase --:gsub('"','&quot;'):gsub("'","&apos;"):gsub('<','&lt;'):gsub('>','&gt;'):gsub('&&','&amp;')
end

function get_item_list(bag)
	local items_in_bag = {}
	-- Load the entire inventory
	for _,v in pairs(bag) do
		if type(v) == 'table' and v.id ~= 0 then
			if res.items[v.id] then
				items_in_bag[#items_in_bag+1] = {}
				items_in_bag[#items_in_bag].name = res.items[v.id][language]
				local potslots,slot = copy_entry(res.items[v.id].slots)
				if potslots then
					slot = res.slots[potslots:it()()].english:gsub(' ','_'):lower() -- Multi-lingual support requires that we add more languages to slots.lua
				end
				items_in_bag[#items_in_bag].slot = slot or 'item'
				if not xml then
					local augments = extdata.decode(v).augments or {}
					local aug_str = ''
					for aug_ind,augment in pairs(augments) do
						if augment ~= 'none' then aug_str = aug_str.."'"..augment:gsub("'","\\'").."'," end
					end
					if string.len(aug_str) > 0 then
						items_in_bag[#items_in_bag].augments = aug_str
					end
				end
			else
				msg.addon_msg(123,'You possess an item that is not in the resources yet.')
			end
		end
	end
	return items_in_bag
end
