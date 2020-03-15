return function(config)
  local board = {}

  local function initialize_board()
    for i = 1, 10 do
      board[i] = ' '
    end 
  end

  local function get_board()
    return board
  end

  initialize_board()

  return {
    get_board = get_board
  }
end