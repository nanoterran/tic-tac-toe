return function(config)
  local cells = {}

  local function initialize_cells()
    for i = 1, 10 do
      cells[i] = ' '
    end 
  end

  local function get_cells()
    return cells
  end

  initialize_cells()

  return {
    get_cells = get_cells
  }
end