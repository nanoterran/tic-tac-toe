describe('board', function()
  local Board = require 'board'
  local board

  local function given_the_board_is_initialized_with(config)
    board = Board(config)
  end

  it('should initialize a board with empty cells', function()
    given_the_board_is_initialized_with({})

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
    given_the_board_is_initialized_with({})

    actual = board.get_cell(2, 2)

    assert.are.equal(' ', actual)
  end)

  it('should be able to set a board cell', function()
    given_the_board_is_initialized_with({})

    board.set_cell(1, 2, 'cross')
    actual = board.get_cell(1, 2)

    assert.are.equal('cross', actual)
  end)

  -- TODO: Test to do
  -- should set a board cell

end)