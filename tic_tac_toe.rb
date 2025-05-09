move_tracker=[[1,"x",3],[4,5,"x"],[7,"0",9]]

def display_board(move_tracker)
  move_tracker.each do |element|
    puts " #{element[0]} | #{element[1]} | #{element[2]}  "
    puts '---+---+---' unless element==move_tracker.last
  end
end

display_board(move_tracker)