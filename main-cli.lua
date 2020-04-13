local Board = require 'src.board'
local Model = require 'src.data_model'
local Player = require 'src.player'
local Controller = require 'src.controller'

local player_one = Player({
	name = 'p1',
	type = 'X'
})
local player_two = Player({
	name = 'p2',
	type = 'O'
})


local input = {}

local model = Model({
	current_player = 'X',
	input = input,
	winner = '',
	game_state = 'running'
})

local board = Board({ model = model })

local controller = Controller({
	model = model,
	board = board
})

local function print_board()
	for row = 1, 3 do
		for column = 1, 3 do
			if column < 3 then
				io.write(' ' .. string.format(board.get_cell(row, column) .. ' |'))
			else
				io.write(' ' .. string.format(board.get_cell(row, column)))
			end
		end
		print()
		if row < 3 then
			print('-----------')
		end
	end
	print()
end

local function process_input()
	io.write('Enter a row and a clumn separated by space(row column): ')
	input.row, input.column = io.read('*n', '*n')
	print()

	local invalid_input = true
	while invalid_input do
		local current_cell = board.get_cell(input.row, input.column)
		if current_cell == ' ' then
			model.write('input', input)
			invalid_input = false
		else
			io.write('ERROR: Invalid Input\n')
			io.write('Enter a row and a clumn separated by space(row column): ')
			input.row, input.column = io.read('*n', '*n')
			print()
		end
	end
end

local function render_current_player()
	local current_player = model.read('current_player')
	print('Current Player: ' .. current_player .. '\n')
end

local function render()
	render_current_player()
	print_board()

end

local function update_game()
	controller.update()
end

io.write('\n\nWelcome to Tic Tac Toe\n\n')
render_current_player()

local state = model.read('game_state')
while state == 'running' do
	process_input()
	update_game()
	render()

	state = model.read('game_state')
end


print('Winner: ' .. model.read('winner') .. '\n')