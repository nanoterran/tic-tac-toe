describe('player', function()
  local Player = require 'player'
  local player

  local function given_player_has_been_initialized_with(config)
    player = Player(config)
  end

  it('should allow the player to be initialized with a name', function()
    given_player_has_been_initialized_with({ name = 'My_name' })

    assert.are.equal('My_name', player.get_name())
  end)

  it('should allow the player to be initialized with a type', function()
    given_player_has_been_initialized_with({ 
      name = 'My_name',
      type = 'nought'
    })

    assert.are.equal('nought', player.get_type())
  end)

  it('player should have no score by default', function()
    given_player_has_been_initialized_with({ 
      name = 'My_name',
      type = 'cross'
    })

    assert.are.equal(0, player.get_score())
  end)

  it('should allow to set player score', function()
    given_player_has_been_initialized_with({ 
      name = 'My_name',
      type = 'cross'
    })

    player.set_score(1)

    assert.are.equal(1, player.get_score())
  end)
end)