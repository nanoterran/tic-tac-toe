describe('controller', function()
	local mach = require 'mach'
	local Controller = require 'controller'
	local controller

	local fake_model_table = {
		read = function() end,
		write = function() end
	}
	local fake_board_table = {
		get_board = function() end,
		has_winner = function() end,
		is_draw = function() end,
    get_cell = function() end,
		set_cell = function() end,
		update = function() end
	}

	local fake_model = mach.mock_table(fake_model_table, 'fake_model_table')
	local fake_board = mach.mock_table(fake_board_table, 'fake_board_table')

	local function given_controller_has_been_initialized(config)
		controller = Controller(config)
	end

	local function get_empty_board()
		local board = {}
		for row = 1, 3 do
      board[row] = {}
      for column = 1, 3 do
        board[row][column] = ' '
      end
		end
		return board
	end

	it('should initialize a controller with model', function()
		given_controller_has_been_initialized({
			model = fake_model,
			board = fake_board
		})
	end)

	it('should be able to update the board', function()
		given_controller_has_been_initialized({
			model = fake_model,
			board = fake_board
		})

		fake_board.update.should_be_called()
			.and_other_calls_should_be_ignored()
			.when(function()
				controller.update()
			end)
	end)

	it('should change player when there is no winner', function()
		given_controller_has_been_initialized({
			model = fake_model,
			board = fake_board
		})

		fake_board.update.should_be_called()
			.and_then(fake_board.has_winner.should_be_called()
			.and_will_return(false))
			.and_then(fake_model.read.should_be_called_with('current_player')
			.and_will_return('X'))
			.and_then(fake_model.write.should_be_called_with('current_player', 'O'))
			.and_other_calls_should_be_ignored()
			.when(function()
				controller.update()
			end)
	end)

	it('should update model when there is a winner', function()
		given_controller_has_been_initialized({
			model = fake_model,
			board = fake_board
		})

		fake_board.update.should_be_called()
			.and_then(fake_board.has_winner.should_be_called()
			.and_will_return(true))
			.and_then(fake_model.read.should_be_called_with('current_player')
			.and_will_return('X'))
			.and_then(fake_model.write.should_be_called_with('winner', 'X'))
			.and_other_calls_should_be_ignored()
			.when(function()
				controller.update()
			end)
	end)

	it('should be able to report a draw', function()
		given_controller_has_been_initialized({
			model = fake_model,
			board = fake_board
		})

		fake_board.update.should_be_called()
			.and_then(fake_board.has_winner.should_be_called()
			.and_will_return(false))
			.and_then(fake_model.read.should_be_called_with('current_player')
			.and_will_return('X'))
			.and_then(fake_board.is_draw.should_be_called()
			.and_will_return(true))
			.and_then(fake_model.write.should_be_called_with('winner', '-'))
			.when(function()
				controller.update()
			end)
	end)
end)