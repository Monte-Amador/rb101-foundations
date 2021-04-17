WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def clear_screen
  system('clear') || system('cls')
end

def validate_joiner_argument(arr)
  !!arr.is_a?(Array)
end

def joiner(arr, del=', ', conj='or')
  if validate_joiner_argument(arr)
    string_output = ''
    case arr.size
    when 0 then ''
    when 1 then string_output << arr[0].to_s
    when 2
      string_output << (arr[0].to_s + ' ' + conj.to_s + ' ' + arr[1].to_s)
    else
      arr.each_with_index do |item, idx|
        if idx < (arr.size - 1)
          string_output << (item.to_s + del.to_s)
        else
          string_output << (conj.to_s + ' ' + item.to_s)
        end
      end 
    end
    string_output
  else
  "Sorry, you need to provide an array as an argument."
  end
end

def prompt(msg)
  puts "=> #{msg}"
end
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Layout/EmptyLineBetweenDefs
def display_board(brd)
  clear_screen
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/EmptyLineBetweenDefs

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def initialize_score
  score_hash = {player: 0, computer: 0}
  score_hash
end

def update_score(score, brd)
  score[:player] += 1 if detect_winner(brd).include?('Player')
  score[:computer] += 1 if detect_winner(brd).include?('Computer')
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd) # note that this method mutates state of brd
  square = ''
  loop do
    prompt "Choose a square #{joiner(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt 'Sorry, that is not a valid choice'
  end
  # BUG? prompt 'square.to_s'
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 3
  end
  nil
end

def match_winner?(hsh)
  winner = hsh.select do |key, value|
    key if value == 5
  end
  winner.to_a.flatten[0].to_s.capitalize
end

# start/end game
loop do # outer loop: each match
  current_score = initialize_score 
  prompt 'Play Tic Tac Toe against the computer, first player to 5 wins the match.'
  
  loop do # inner loop: each round
    board = initialize_board  

    loop do # inner inner loop: each player chooses until win or tie
      display_board(board)
      prompt "Current Scores: Player => #{current_score[:player]}, Computer => #{current_score[:computer]}"
      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end # inner inner loop

    display_board(board)
    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
      update_score(current_score, board)
      break if current_score.has_value?(5) # break round loop
    else
      prompt "It's a tie!"
    end
    # LOGIC BUG
    # currently player won prompt is getting cleared before seeing it because it is
    # looping back to the beginning of the inner inner loop that displays
    # the state of the board - the method automatically clears the screen
    # which will wipe the screen immediately. This is why there is the
    # sleep command in place for now, as I am struggling to find a way to
    # break out of the loop below (commented out). Left off here
    sleep (2)
    # prompt "continue? (Y/N)"
    # continue_response = gets.chomp.downcase
    # break 
  end # inner loop
  if current_score.has_value?(5) 
    prompt "Game over, match win goes to: #{match_winner?(current_score)}!"
    prompt 'Play again? (Y/N)'
    response = gets.chomp.downcase
    break if response == 'n'
  end
end # outer loop
prompt 'Thanks for playing Tic Tac Toe. Good-bye!'
