describe('data model', function()
	local Model = require 'data_model'
	local model

	it('should be able to read from the data model', function()
		model = Model({
			key = 'value'
		})

		actual = model.read('key')
		expected = 'value'

		assert.are.equal(expected, actual)
	end)

	it('should be able to write to the data model', function()
		model = Model({
			key = 'value',
			another_key = 'another_value'
		})

		model.write('key', 'new_value')
		actual = model.read('key')

		assert.are.equal('new_value', actual)
	end)

	it('should error when reading an invalid key', function()
		model = Model({
			key = 'a_key'
		})

		assert.has_error(function() 
			model.read('another_key')
		end, 'Cannot read from invalid key: another_key')
	end)

	it('should error when writing to an invalid key', function()
		model = Model({
			key = 'a_key'
		})

		assert.has_error(function() 
			model.write('another_key')
		end, 'Cannot write to invalid key: another_key')
	end)

end)