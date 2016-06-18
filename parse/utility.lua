function message(message)
	windower.add_to_chat(messageColor,'PARSE: '..message)
end

function debug(message)
	if settings.debug then
		windower.add_to_chat(messageColor,'PARSE DEBUG: '..message)
	end
end

function merge_tables(t1,t2)
	for key,value in pairs(t2) do
		if not t1[key] then -- doesn't exist already
			--debug('key not found, making new')
			t1[key] = value
		else -- exists, need to merge data
			if type(value)=='number' then -- if a number, just add the data to the value
				t1[key] = t1[key] + value
				--debug('adding value to previous record')
			elseif type(value)=='table' then --if it's a table, we need to go deeper
				merge_tables(t1[key],value)
			end
		end
	end
end

function copy(obj, seen)
	if type(obj) ~= 'table' then return obj end
	if seen and seen[obj] then return seen[obj] end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
	return res
end