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

  model = config.model
  assert(model ~= nil, 'No Data Model provided')

  initialize_board()

  return {
    get_board = get_board,
    update = update,
    get_cell = get_cell,
    set_cell = set_cell
  }
end