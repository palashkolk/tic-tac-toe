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
  puts "Enter player#{player_number} position"
  player_position = gets.chomp.to_i
  row_idx = (player_position - 1) / 3
  col_idx = (player_position - 1) % 3
  move_tracker[row_idx][col_idx] = player_number == 1 ? 'X' : '0'
end

def game_tracker(move_tracker)
  first_row = move_tracker[0][0] == move_tracker[0][1] && move_tracker[0][1] == move_tracker[0][2]
  second_row = move_tracker[1][0] == move_tracker[1][1] && move_tracker[1][1] == move_tracker[1][2]
  third_row = move_tracker[2][0] == move_tracker[2][1] && move_tracker[2][1] == move_tracker[2][2]
  first_col = move_tracker[0][0] == move_tracker[1][0] && move_tracker[1][0] == move_tracker[2][0]
  second_col = move_tracker[0][1] == move_tracker[1][1] && move_tracker[1][1] == move_tracker[2][1]
  third_col = move_tracker[0][2] == move_tracker[1][2] && move_tracker[1][2] == move_tracker[2][2]
  cross1 = move_tracker[0][0] == move_tracker[1][1] && move_tracker[1][1] == move_tracker[2][2]
  cross2 = move_tracker[0][2] == move_tracker[1][1] && move_tracker[1][1] == move_tracker[2][0]
  [first_row, second_row, third_row, first_col, second_col, third_col, cross1, cross2]
end

player = [1, 2]
winner_declared = false

game_start_message
display_board(move_tracker)
until winner_declared
  player.each do |player|
    player_move(player, move_tracker)
    display_board(move_tracker)
    winner_declared = true if game_tracker(move_tracker).include?(true)
    if winner_declared == true
      puts "player#{player} wins!"
      break
    end
  end
end
