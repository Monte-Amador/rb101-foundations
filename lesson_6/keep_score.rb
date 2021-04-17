=begin

## Refactor
- [ ] Use heredoc syntax 
- [ ] prefer `.to_s` to string interpolation
- [X] add the `clear_screen` method from the 8_rps in lesson 2

# Logic Decomposition: Keep Score
Keep score of how many times the player and computer each win. Don't use
global or instance variables. Make it so that the first player to 5 wins the
game.

- [X] encase game in loop

keep score in a `score_hash` and each score by testing the output of who won,
or ignore if it is a tie.

after results are displayed update score and conditionally end game if match
is won, or ask user to continue.

=end

loop do # match loop start/end game
  # game goes until one player scores 5
  # prompt for new game
  current_score = initialize_score
  
  # loop: each round gets a new board
  loop do # start/end round
    board = initialize_board  
  
    loop do # processes 
      display_board(board)
      prompt "Current Score: #{current_score}"
      player_places_piece!(board)
      # break loop when someone wins or ties
      break if someone_won?(board) || board_full?(board)
      computer_places_piece!(board)
      # break loop when someone wins or ties
      break if someone_won?(board) || board_full?(board)
    end
  
    display_board(board)
      if someone_won?(board)
        prompt "#{detect_winner(board)} won!"
        update_score(current_score, board)
        break if current_score.has_value?(5) 
      else
        prompt "It's a tie!"
      end
  end
  prompt "Game over, #{match_winner(current_score)} won!"
  prompt 'Play again? (Y/N)'
  response = gets.chomp.downcase
  break if response == 'n'
end


loop do 
  current_score = initialize_score
  loop do # each round
    board = initialize_board # setup base board
    
    # loop do # inner loop :  breaks out of loop if someone won or tie
    #   display_board(board) # display board
    #   prompt "Current Score: #{current_score}"
    #   player_places_piece!(board) # player makes choice
    #   break if someone_won?(board) || board_full?(board) 

    #   computer_places_piece!(board) # computer makes choice
    #   break if someone_won?(board) || board_full?(board)
    # end
    # display_board(board)
    

  end 
end
# prompt 'Play again? (Y/N)'
# response = gets.chomp.downcase
# break if response == 'n'
prompt 'Thanks for playing Tic Tac Toe. Good-bye!'



def display_results_round
  # who won the round
  # this currently is handled on a per game basis through the method of
  # detect_winner(brd)
end

def winner?(hsh)
  # compare scores, either player wins match if any score == 5
  winner = hsh.select do |key, value|
    key if value == 5
  end
  winner.to_a.flatten[0].to_s.capitalize
end

def display_results_match
  # display winner from the best of 5 match
  # ask if user would like to play another game or exit
end


