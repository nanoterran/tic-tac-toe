return function(config)
  local name = config.name
  local score = 0
  local type = config.type

  local function get_name()
    return name
  end

  local function get_type()
    return type
  end

  local function get_score()
    return score
  end

  local function set_score(new_score)
    score = new_score
  end

  return {
    get_name = get_name,
    get_type = get_type,
    get_score = get_score,
    set_score = set_score
  }
end