function table.copy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for copy_key, copy_val in pairs(orig) do
			copy[table.copy(copy_key)] = table.copy(copy_val)
		end
	else
		copy = orig
	end
	return copy
end

function table.compare(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then return a == b end
	for key,val in pairs(a) do
		if type(a[key]) ~= type(b[key]) then return false
		elseif a[key] ~= b[key] then return false end
	end
	for key, val in pairs(b) do
		if type(a[key]) ~= type(b[key]) then return false
		elseif a[key] ~= b[key] then return false end
	end
	return true
end

function table.compare_deep(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then return a == b end
	for key,val in pairs(a) do
		if type(a[key]) ~= type(b[key]) then return false
		elseif type(a[key]) == "table" then
			if table.compare(a[key], b[key]) == false then return false end
		elseif a[key] ~= b[key] then return false end
	end
	for key, val in pairs(b) do
		if type(a[key]) ~= type(b[key]) then return false
		elseif type(a[key]) == "table" then
			if table.compare(a[key], b[key]) == false then return false end
		elseif a[key] ~= b[key] then return false end
	end
	return true
end

function table.concat( ... )
	local args = {...}
	local tbl = {}

	for i=1, #args do
		if type(args[i]) == "table" then
			for j=1, #args[i] do tbl[#tbl+1] = args[i][j] end
		else
			tbl[#tbl+1] = args[i]
		end
	end
	return tbl
end

function table.contains(tbl, val)
	for i=1, #tbl do
		-- just use table.compare as it will handle cases when
		-- one or both of the parameters aren't tables
		if table.compare(tbl[i], val) then return true end
	end
	return false
end