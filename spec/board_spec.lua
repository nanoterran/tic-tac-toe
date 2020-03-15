describe('board', function()
  local Board = require 'board'
  local board

  local function given_the_board_is_initialized_with(config)
    board = Board(config)
  end

  it('should initialize a board with empty cells', function()
    given_the_board_is_initialized_with({})

    local expected_board = {}
    for i = 1, 10 do expected_board[i] = ' ' end

    assert.are.same(expected_board, board.get_board())
  end)

end)