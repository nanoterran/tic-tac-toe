describe('board', function()
	local mach = require 'mach'
  local Board = require 'board'
  local board

  local fake_model_table = {
		read = function() end,
		write = function() end
  }
  fake_model = mach.mock_table(fake_model_table, 'fake_model_table')

  local function get_empty_board()
    local empty_board = {}
    for row = 1, 3 do
      empty_board[row] = {}
      for column = 1, 3 do
        empty_board[row][column] = ' '
      end
    end
    return empty_board
  end

  local function given_the_board_is_initialized_with(config)
    board = Board(config)
  end

  it('should initialize a board with empty cells', function()
    given_the_board_is_initialized_with({ model = fake_model })

    local expected = get_empty_board()
    actual = board.get_board()

    assert.are.same(expected, actual)
  end)

  it('should be able to get a board cell', function()
    given_the_board_is_initialized_with({ model = fake_model })

    actual = board.get_cell(2, 2)

    assert.are.equal(' ', actual)
  end)

  it('should be able to set a board cell', function()
    given_the_board_is_initialized_with({ model = fake_model })

    board.set_cell(1, 2, 'X')
    actual = board.get_cell(1, 2)

    assert.are.equal('X', actual)
  end)

  it('should return error when a model is not provide', function()
    assert.has_error(function() 
      given_the_board_is_initialized_with({})
    end, 'No Data Model provided')
  end)

  it('should allow to update the board with an input', function()
    given_the_board_is_initialized_with({ model = fake_model })

    fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 2, column = 2 })
      .and_then(fake_model.read.should_be_called_with('current_player')
      .and_will_return('O'))
      .when(function()
        board.update()
      end)

      local actual = board.get_cell(2, 2)

      assert.are.equal('O', actual)
  end)
end)