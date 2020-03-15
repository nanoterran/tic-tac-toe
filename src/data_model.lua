return function(config)
	local data = config

	local function read(key)
		assert(data[key] ~= nil, 'Invalid key: ' .. key)
		return data[key]
	end

	local function write(key, new_value)
		data[key] = new_value
	end

	return {
		read = read,
		write = write
	}
end