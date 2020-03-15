describe('board', function()
	local mach = require 'mach'
  local Board = require 'board'
  local board

  local fake_model_table = {
		read = function() end,
		write = function() end
  }
  fake_model = mach.mock_table(fake_model_table, 'fake_model_table')

  local function given_the_board_is_initialized_with(config)
    board = Board(config)
  end

  it('should initialize a board with empty cells', function()
    given_the_board_is_initialized_with({ model = fake_model })

    local expected = {}
    for row = 1, 3 do
      expected[row] = {}
      for column = 1, 3 do
        expected[row][column] = ' '
      end
    end

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

    board.set_cell(1, 2, 'cross')
    actual = board.get_cell(1, 2)

    assert.are.equal('cross', actual)
  end)

  it('should return error when a model is not provide', function()
    assert.has_error(function() 
      given_the_board_is_initialized_with({})
    end, 'No Data Model provided')
  end)
end)