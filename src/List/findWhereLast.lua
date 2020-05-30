
local function find(list, predicate, from)
	for i = from or #list, 1, -1 do
		if predicate(list[i], i) then
			return i
		end
	end

	return 0
end

return find