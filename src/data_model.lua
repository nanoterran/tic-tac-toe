return function(config)
	local data = config

	local function read(key)
		assert(data[key] ~= nil, 'Cannot read from invalid key: ' .. key)
		return data[key]
	end

	local function write(key, new_value)
		assert(data[key] ~= nil, 'Cannot write to invalid key: ' .. key)
		data[key] = new_value
	end

	return {
		read = read,
		write = write
	}
end