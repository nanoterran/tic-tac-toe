describe('player', function()
  local Player = require 'player'
  local player = Player

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
      type = 'cross'
    })

    assert.are.equal('cross', player.get_type())
  end)

  it('player should have no score by default', function()
    given_player_has_been_initialized_with({ 
      name = 'My_name',
      type = 'cross'
    })

    assert.are.equal(0, player.get_score())
  end)

  it('should allow to increment player score by one point', function()
    given_player_has_been_initialized_with({ 
      name = 'My_name',
      type = 'cross'
    })

    player.increase_score()

    assert.are.equal(1, player.get_score())
  end)
end)