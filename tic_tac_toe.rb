move_tracker = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

def display_board(move_tracker)
  move_tracker.each do |element|
    puts " #{element[0]} | #{element[1]} | #{element[2]}  "
    puts '---+---+---' unless element == move_tracker.last
  end
end

def game_start_message
  puts 'Player one chooses X'
  puts 'Player two chooses 0'
end

def player_move(player_number, move_tracker)
  print "Enter player#{player_number} position: "
  player_position = gets.chomp.to_i
  row_idx = (player_position - 1) / 3
  col_idx = (player_position - 1) % 3
  move_tracker[row_idx][col_idx] = player_number == 1 ? 'X' : '0'
end

def game_tracker(move_tracker)
  board_rows_cols = [move_tracker, move_tracker.transpose, [(0..2).map { |i| move_tracker[i][i] }, (0..2).map do |i|
    move_tracker[i][2 - i]
  end]].flatten(1)

  game_winner = false
  game_draw = false

  board_rows_cols.each do |array|
    game_winner = array.all?('X') || array.all?('0')
    next unless game_winner

    break
  end
  game_draw = move_tracker.flatten(1).all? { |item| %w[X 0].include?(item) } if game_winner == false
  [game_winner, game_draw]
end

player = [1, 2]
winner_declared = false
game_drawn = false

game_start_message
display_board(move_tracker)

until winner_declared or game_drawn
  player.each do |player|
    player_move(player, move_tracker)
    display_board(move_tracker)
    winner_declared, game_drawn = game_tracker(move_tracker)
    next unless winner_declared or game_drawn

    puts "player#{player} wins!" if winner_declared
    puts 'game drawn!' if game_drawn
    break
  end
end
