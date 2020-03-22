return function(config)
  local board = {}
  local model

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

  local function update()
    local input = model.read('input')
    local current_player = model.read('current_player')

    set_cell(input.row, input.column, current_player)
  end

  local function has_horizontal_win(player, input)
    local row = input.row

    return board[row][1] == player and board[row][2] == player and board[row][3] == player
  end

  local function has_vertical_win(player, input)
    local column = input.column

    return board[1][column] == player and board[2][column] == player and board[3][column] == player
  end

  local function has_diagonal_win(player, input)
    return board[1][1] == player and board[2][2] == player and board[3][3] == player
  end

  local function has_diagonal_win_two(player, input)
    return board[1][3] == player and board[2][2] == player and board[3][1] == player
  end

  local function has_winner()
    local current_player = model.read('current_player')
    local input = model.read('input')

    return has_horizontal_win(current_player, input) or
      has_vertical_win(current_player, input) or
      has_diagonal_win(current_player, input) or
      has_diagonal_win_two(current_player, input)
  end

  local function is_full()
    for row = 1, 3 do
      for column = 1, 3 do
        if board[row][column] == ' ' then
          return false
        end
      end
    end
    return true
  end

  local function is_draw()
    return is_full() and not has_winner()
  end

  model = config.model
  assert(model ~= nil, 'No Data Model provided')

  initialize_board()

  return {
    get_board = get_board,
    update = update,
    get_cell = get_cell,
    set_cell = set_cell,
    has_winner = has_winner,
    is_draw = is_draw
  }
end