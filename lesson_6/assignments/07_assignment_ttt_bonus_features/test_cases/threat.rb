=begin
In the end, it came down to my method identifying the threat but not testing to see if the threat was included in the available squares, it was instead testing against the winning lines which worked, except if the computer had blocked it, it wouldn't recognize that.

Okay... there's something wrong with my own logic as the game works correctly with the previous setup. It seems to be within the method perhaps not updating the available positions possibly?



Taken a break on this to let it rest. Upon restarting this project, go
through each line accordingly and make sure you can break down each and every
method and pay attention to their respective return values. 

This is the core of the lesson and the project. Verify the logic in each method call works as
expected. Specifically look at the three level deep loop scenario as this
seems to be the main point of the problem. Also, as a fun challenge let's see
if you can distill this into something far more simpler.

So, wrapping up, I've left off with a focus on the 3 level deep loop for the
game and this is where there is something going wrong (bug). I've also
rebuilt the loops individually and tested with the pry debug to ensure the
return values are correct and they look right. 

However, at the core of the problem I believe through some testing it has shown that there is an issue picking an available (empty) integer within the array (maybe not reading the empty squares) only after the defensive method picks up a threat. 

For a higher level view, this means that the computer move is correctly choosing a random available square *until* it detects a threat. When it picks up the threat, it correctly chooses the threat square as the correct move. Afterwards, it then chooses any random square, even so much as choosing a square that is unavailable. (This may be only unavaialable squares with the computer's value, not the user?) If, after a threat has been confirmed and the computer correctly defends that square, it will also randomly pick any square *unless* there is another threat.


=end

=begin
At this point, this is ready for a little more thorough testing but should be ready to implement in a new testing file where we have a board to visually test. Just bring it into the `tictactoe_bonus_features-v3.rb` and then look at refactoring by abstracting the multi-line logic out to separate variables.
=end
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def detect_threat(brd, valid_squares)
  # save all player markers to array
  current_squares_player = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == PLAYER_MARKER 
  end
  # identify any potential threats by comparing players squares to 
  # WINNING_LINES constant variable
  potential_threats = WINNING_LINES.each_with_object([]) do |line, arr|
    arr << (line - current_squares_player)
  end
  
  # strip empty arrays from return value
  potential_threats.keep_if { |arr| arr.size == 1 }
  
  if potential_threats.empty? == false
    threats = potential_threats.flatten
    threats.keep_if {|num| valid_squares.include?(num)}
    # implicit return for single array containng valid threats
    threats if threats.empty? == false
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_move(brd)
  puts "choose a square"
  p empty_squares(brd)
  square = gets.chomp.to_i
  brd[square] = PLAYER_MARKER 
end

def computer_move(brd, slot)
 if detect_threat(brd, slot) != nil
    p "threat detected!"
    square = detect_threat(brd, slot).sample
  else
    p "no threat detected, choosing last number"
    square = slot.last
  end
  brd[square] = COMPUTER_MARKER if square != nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

# Intitiate game and board
board = {}
  (1..9).each do |num|
  board[num] = INITIAL_MARKER
end

loop do
  puts "board before player move: #{board}"
  player_move(board)
  puts "board after player move and before computer move: #{board}"
  puts "Valid threats: #{detect_threat(board, empty_squares(board))}"
  computer_move(board, empty_squares(board))
  puts "board after computer move: #{board}"
  break if board_full?(board) 
end

puts "game over"
puts "tie!" if board_full?(board)
puts "someone won!" if board_full?(board) == false

# another_board = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" "}
# loop do
#   puts "State of board after round: #{another_board}"
#   puts "Is the board_full? => #{board_full?(another_board)}"
#   break if board_full?(another_board)
#   puts "available squares for player move: #{empty_squares(another_board)}"
#   player_move(another_board)
#   p "Board State: #{another_board}"
#   computer_move(another_board, empty_squares(another_board))
# end
