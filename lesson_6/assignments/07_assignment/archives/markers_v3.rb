WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals

INITIAL_MARKER = ' '
PLAYER1_MARKER = 'X'
PLAYER2_MARKER = 'O'

###########################################
# Initialize Methods
###########################################
def clear_screen
  system('clear') || system('cls')
end

def update_board(brd)
  clear_screen
  display_board(brd)
end

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
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

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def initialize_score
  { player: 0, computer: 0 }
end

def join(arr, delimeter = ', ', conjunction = 'or')
  if validate_join_array(arr)
    string_output = ''
    case arr.size
    # refactor output
    when 0 then string_output << 'Sorry, you have to at least provide an array as an argument.'
    when 1 then string_output << arr[0].to_s
    when 2
      string_output << ("#{arr[0]} #{conjunction} #{arr[1]}")
    else
      arr.each_with_index do |item, idx|
        string_output << if idx < (arr.size - 1)
                           "#{item}#{delimeter}"
                         else
                           "#{conjunction} #{item}"
                         end
      end
    end
    string_output
  else
    'Sorry, please provide a valid array as an argument.'
  end
end

###########################################
# Retrieve/inspect Values
###########################################
def validate_join_array(arr)
  !!arr.is_a?(Array)
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd, first_turn, second_turn)
  !!detect_winner(brd, first_turn, second_turn)
end

def detect_winner(brd, first_turn, second_turn)
  WINNING_LINES.each do |line|
    return "#{first_turn}" if brd.values_at(line[0], line[1], line[2]).count(PLAYER1_MARKER) == 3
    return "#{second_turn}" if brd.values_at(line[0], line[1], line[2]).count(PLAYER2_MARKER) == 3
  end
  nil
end

def match_winner?(hsh, rounds)
  winner = hsh.select do |key, value|
    key if value == rounds
  end
  winner.to_a.flatten[0].to_s.capitalize
end


def player_squares(brd, player_marker)
  player_selected_squares = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == player_marker 
  end
  player_selected_squares
end

def computer_squares(brd, computer_marker)
  computer_selected_squares = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == computer_marker 
  end
  computer_selected_squares
end

def valid_offense(win_range, valid_squares)
  if win_range.empty? == false
    win = win_range.flatten
    win.keep_if {|num| valid_squares.include?(num)}
    win if win.empty? == false
  end
end

def priority(range_arr)
  attention = WINNING_LINES.each_with_object([]) do |line, arr|
    arr << (line - range_arr)
  end 
  attention.keep_if { |arr| arr.size == 1 }
end

def detect_offense(brd, valid_squares, computer_marker)
  valid_offense(priority(computer_squares(brd, computer_marker)), valid_squares)
end
 
def valid_defense(threat_range, valid_squares)
  if threat_range.empty? == false
    threats = threat_range.flatten
    threats.keep_if {|num| valid_squares.include?(num)}
    threats if threats.empty? == false
  end
end

def detect_defense(brd, valid_squares, player_marker) 
  valid_defense(priority(player_squares(brd, player_marker)), valid_squares)
end

def choose_five(brd, valid_squares, player_marker)
  !!(valid_squares.include?(5)) && (player_squares(brd, player_marker).empty? == false)
end
###########################################
# Output
###########################################
def available_choices(arr)
  message = <<~MSG
  Choose a square
  #{join(arr)}
  MSG
  prompt message
end

def invalid_choice
  message = <<~MSG
  Sorry, 
  that is not a valid choice
  MSG
  prompt message
end

def display_score(score)
  score = <<~MSG
  Current Scores:
  Player: #{score[:player]}
  Computer: #{score[:computer]}
  MSG
  prompt(score)
end

def display_round_standings(brd, score, first_turn, second_turn)
  if someone_won?(brd, first_turn, second_turn)
    update_board(brd)
    prompt "#{detect_winner(brd, first_turn, second_turn)} won!"
    update_score(score, brd, first_turn, second_turn)
    sleep(2)
  else
    update_board(brd)
    prompt "It's a tie!"
    sleep(2)
  end
end

def display_welcome_message
  welcome_prompt = <<~MSG
  Play Tic Tac Toe against the computer!
  MSG
  prompt(welcome_prompt)
end

def ask_who_goes_first(str)
  who = <<~MSG
  Who would you like to go first?
  (p)layer, (c)omputer, or (r)andom
  (valid choices are p,c, or r)
  MSG
  prompt who
  answer = gets.chomp
  answer.empty? ? str << 'p' : str << answer
end

# LEAVING OFF
def validate_input_string(str)
  # Processes...
end

def ask_how_many_rounds
  rounds = ''
  loop do
    message = <<~MSG
    How many rounds 
    do you want to play?
      MSG
      prompt message
      rounds = gets.chomp.to_i
      if rounds < 5
        rounds > 0 ? rounds : rounds = 1
        break
      else
        prompt "Max number of rounds is 5"
      end
    end
    rounds
  end

def display_match_rules(rounds)
  match_params = <<~MSG
  Great! The first player to #{rounds}
  wins the match. Preparing the game...
  MSG
  prompt(match_params)
end

def display_match_summary(score, rounds)
  display_score(score)
  message = <<~MSG
  Game over, match win goes to: 
  #{match_winner?(score, rounds)}!
  MSG
  prompt message
end

def display_closing
  message = <<~MSG
  Thanks for playing Tic Tac Toe!
  Goodbye!
  MSG
  prompt message
end

def ask_play_again(play)
  loop do
    reset_local_var(play)
    prompt 'Play another match?(y/n)'
    play << gets.chomp.downcase
    case play
    when 'y'
      clear_screen
      break
    when 'n'
      break
    else
      prompt 'sorry, "y" or "n" please'
    end
  end
end


###########################################
# Modify Values
###########################################
def reset_local_var(var_1, *vars)
  var_1.clear
  if vars
    vars.each { |item| item.clear }
  end
end

def update_score(score, brd, first_turn, second_turn)
  score[:player] += 1 if detect_winner(brd, first_turn, second_turn).include?('Player')
  score[:computer] += 1 if detect_winner(brd, first_turn, second_turn).include?('Computer')
end

def player_places_piece!(brd, player_marker)
  square = ''
  loop do
    available_choices(empty_squares(brd))
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    invalid_choice
  end
  brd[square] = player_marker 
end
 
def computer_places_piece!(brd, valid_squares, computer_marker, opponent_marker)
  if detect_offense(brd, valid_squares, computer_marker)
    square = detect_offense(brd, valid_squares, computer_marker).sample
  elsif detect_defense(brd, valid_squares, opponent_marker)
    square = detect_defense(brd, valid_squares, opponent_marker).sample
  elsif choose_five(brd, valid_squares, opponent_marker)
    square = 5
  else
    square = valid_squares.sample
  end
  brd[square] = computer_marker if square != nil
end

def set_user(turn, str)
  turn.clear
  turn << "#{str}"
end

def first_player(user_input, brd, generated_user, first_turn) 
  case user_input
  when 'p'
    set_user(first_turn, 'Player')
    player_places_piece!(brd, PLAYER1_MARKER)
  when 'c'
    set_user(first_turn, 'Computer')
    computer_places_piece!(brd, empty_squares(brd), PLAYER1_MARKER, PLAYER2_MARKER)
  when 'r'
    if generated_user != ''
      computer_choice = generated_user
    else
      arr = ['p', 'c']
      computer_choice = arr.sample  
      generated_user << computer_choice
    end

    case computer_choice 
    when 'p'
      set_user(first_turn, 'Player')
      player_places_piece!(brd, PLAYER1_MARKER)
    when 'c'
      set_user(first_turn, 'Computer')
      computer_places_piece!(brd, empty_squares(brd), PLAYER1_MARKER, PLAYER2_MARKER)
    end
  end  
end

def second_player(user_input, brd, generated_user, second_turn) 
  user_input = generated_user if generated_user != ''
  case user_input 
  when 'p'
    set_user(second_turn, 'Computer')
    computer_places_piece!(brd, empty_squares(brd), PLAYER2_MARKER, PLAYER1_MARKER)
  when 'c'
    set_user(second_turn, 'Player')
    player_places_piece!(brd, PLAYER2_MARKER)
  end
end

def round_loop(brd, score, user_input, generated_user, first_turn, second_turn)
  loop do
    update_board(brd) 
    display_score(score)
    first_player(user_input, brd, generated_user, first_turn)
    update_board(brd) 
    break if someone_won?(brd, first_turn, second_turn) || board_full?(brd)
    second_player(user_input, brd, generated_user, second_turn)
    update_board(brd) 
    break if someone_won?(brd, first_turn, second_turn) || board_full?(brd)
    clear_screen
  end
  display_round_standings(brd, score, first_turn, second_turn)
end

###########################################
# Game Logic
###########################################
computer_choice = ''
user_choice = ''
play_again = ''
player1 = ''
player2 = ''
loop do 
  display_welcome_message
  ask_who_goes_first(user_choice)
  num_rounds = ask_how_many_rounds
  display_match_rules(num_rounds)
  current_score = initialize_score 
  loop do 
    board = initialize_board
    round_loop(board, current_score, user_choice, computer_choice, player1, player2)
    break if current_score.value?(num_rounds)
  end 
  reset_local_var(computer_choice, user_choice)
  display_match_summary(current_score, num_rounds)
  ask_play_again(play_again)
  break if play_again == 'n'
end
display_closing
