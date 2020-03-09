describe('board', function()
  local Board = require 'board'
  local board

  local function given_the_board_is_initialized_with(config)
    board = Board(config)
  end


  it('should initialize a board with empty cells', function()
    given_the_board_is_initialized_with({})

    local expected_cells = {}
    for i = 1, 10 do expected_cells[i] = ' ' end

    assert.are.same(expected_cells, board.get_cells())
  end)

end)