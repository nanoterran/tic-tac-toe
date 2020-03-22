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

  local function the_board_is_filled()
    local filled_board = {
      { 'X', 'O', 'O' },
      { 'O', 'X', 'X' },
      { 'X', 'O', '' }
    }

    for row = 1, 3 do
      for column = 1, 3 do
        board.set_cell(row, column, filled_board[row][column])
      end
    end
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

  it('should be able to check for a winner on a row', function()
    given_the_board_is_initialized_with({ model = fake_model })

    board.set_cell(1, 1, 'X')
    board.set_cell(1, 2, 'X')
    board.set_cell(1, 3, 'X')

    local actual
    fake_model.read.should_be_called_with('current_player')
      .and_will_return('X')
      .and_then(fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 1, column = 3 }))
      .when(function()
        actual = board.has_winner()
      end)

    assert.are.equal(true, actual)
  end)

  it('should be able to check for a winner on a column', function()
    given_the_board_is_initialized_with({ model = fake_model })

    board.set_cell(1, 2, 'O')
    board.set_cell(2, 2, 'O')
    board.set_cell(3, 2, 'O')

    local actual
    fake_model.read.should_be_called_with('current_player')
      .and_will_return('O')
      .and_then(fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 3, column = 2 }))
      .when(function()
        actual = board.has_winner()
      end)

    assert.are.equal(true, actual)
  end)

  it('should be able to check for diagonal one win', function()
    given_the_board_is_initialized_with({ model = fake_model })

    board.set_cell(1, 1, 'O')
    board.set_cell(2, 2, 'O')
    board.set_cell(3, 3, 'O')

    local actual
    fake_model.read.should_be_called_with('current_player')
      .and_will_return('O')
      .and_then(fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 3, column = 3 }))
      .when(function()
        actual = board.has_winner()
      end)

    assert.are.equal(true, actual)
  end)

  it('should be able to check for diagonal two win', function()
    given_the_board_is_initialized_with({ model = fake_model })

    board.set_cell(1, 3, 'O')
    board.set_cell(2, 2, 'O')
    board.set_cell(3, 1, 'O')

    local actual
    fake_model.read.should_be_called_with('current_player')
      .and_will_return('O')
      .and_then(fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 3, column = 3 }))
      .when(function()
        actual = board.has_winner()
      end)

    assert.are.equal(true, actual)
  end)

  it('should be able to check for a draw', function()
    given_the_board_is_initialized_with({ model = fake_model })

    the_board_is_filled()

    local actual
    fake_model.read.should_be_called_with('current_player')
      .and_will_return('O')
      .and_then(fake_model.read.should_be_called_with('input')
      .and_will_return({ row = 3, column = 3 }))
      .when(function()
        actual = board.is_draw()
      end)

    assert.are.equal(true, actual)
  end)
end)