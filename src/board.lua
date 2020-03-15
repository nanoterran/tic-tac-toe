return function(config)
  local board = {}

  local function initialize_board()
    for row = 1, 3 do
      board[row] = {}
      for column = 1, 3 do
        board[row][column] = ' '
      end
    end 
  end

  local function get_board()
    return board
  end

  local function get_cell(row, column)
    return board[row][column]
  end

  local function set_cell(row, column, value)
    board[row][column] = value
  end

  initialize_board()

  return {
    get_board = get_board,
    get_cell = get_cell,
    set_cell = set_cell
  }
end