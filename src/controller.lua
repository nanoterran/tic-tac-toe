return function(config)
	local model = config.model
	local player_one = config.player_one
	local player_two = config.player_two
	local board = config.board

	local function update()
		board.update()
		local has_winner = board.has_winner()

		if has_winner then
			-- report winner
		else
			local current_player = model.read('current_player')
			if current_player == 'X' then
				current_player = 'O'
			else
				current_player = 'X'
			end
			model.write('current_player', current_player)
		end
	end

	return {
		update = update
	}
end