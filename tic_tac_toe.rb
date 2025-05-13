class Game
  def initialize
    @move_tracker = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @winner_declared = false
    @game_drawn = false
  end

  def play_game(player)
    game_start_message(player)
    display_board
    until @winner_declared or @game_drawn
      player.each do |player|
        player_move(player, @move_tracker)
        display_board
        @winner_declared, @game_drawn = game_tracker
        next unless @winner_declared or @game_drawn

        puts "#{player.name} wins!" if @winner_declared
        puts 'game drawn!' if @game_drawn
        break
      end
    end
  end

  private

  def display_board
    @move_tracker.each do |element|
      puts " #{element[0]} | #{element[1]} | #{element[2]}  "
      puts '---+---+---' unless element == @move_tracker.last
    end
  end

  def game_start_message(player)
    puts "#{player[0].name} chooses X"
    puts "#{player[1].name} chooses 0"
  end

  def player_move(player, move_tracker)
    print "Enter #{player.name}'s position: "
    player_position = gets.chomp.to_i
    row_idx = (player_position - 1) / 3
    col_idx = (player_position - 1) % 3
    move_tracker[row_idx][col_idx] = player.marker
  end

  def game_tracker
    board_rows_cols = [@move_tracker, @move_tracker.transpose, [(0..2).map do |i|
      @move_tracker[i][i]
    end, (0..2).map do |i|
           @move_tracker[i][2 - i]
         end]].flatten(1)

    game_winner = false
    game_draw = false

    board_rows_cols.each do |array|
      game_winner = array.all?('X') || array.all?('0')
      next unless game_winner

      break
    end
    game_draw = @move_tracker.flatten(1).all? { |item| %w[X 0].include?(item) } if game_winner == false
    [game_winner, game_draw]
  end
end

class Player
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

new_game = Game.new
player1 = Player.new('Amir', 'X')
player2 = Player.new('Sabir', '0')
new_game.play_game([player1, player2])
