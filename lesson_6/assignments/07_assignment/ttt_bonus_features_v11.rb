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

# rubocop:disable Metrics/AbcSize
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
# rubocop:enable Metrics/AbcSize

def initialize_users
  { p: 'Player',
    c: 'Computer',
    r: ['p', 'c'],
    valid_user_inputs: ['p', 'c', 'r'],
    user_choice: '',
    computer_choice: '',
    user_1: '',
    user_2: '' }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def initialize_score
  { player: 0, computer: 0 }
end

def join_iteration(arr, delimeter, conjunction)
  output = ''
  arr.each_with_index do |value, idx|
    output << if idx < (arr.size - 1)
                "#{value}#{delimeter}"
              else
                "#{conjunction} #{value}"
              end
  end
  output
end

def join(arr, delimeter = ', ', conjunction = 'or')
  if validate_join_array(arr)
    string_output = ''
    case arr.size
    when 1 then string_output << arr[0].to_s
    when 2
      string_output << ("#{arr[0]} #{conjunction} #{arr[1]}")
    when 3..9
      string_output << join_iteration(arr, delimeter, conjunction)
    else
      prompt "There was a problem with the array size"
    end
    string_output
  else
    prompt 'Sorry, please provide a valid array as an argument.'
  end
end

###########################################
# Retrieve/inspect Values
###########################################
def validate_join_array(arr)
  !!arr.is_a?(Array)
end

def validate_integer_input(int)
  return false if int.to_i.to_s != int
  int.to_i
end

def integer_in_range(str, range)
  return false if !validate_integer_input(str)
  int = str.to_i
  case range.size
  when 2
    return int if int.between?(range[0], range[1])
    return false
  when 1
    return int if range.join.to_i == int
    return false
  else
    display_error
    return nil
  end
end

def string_in_range(str, range)
  test_string = range.join(' ').split
  string = str.strip.downcase
  return string if test_string.include?(string)
  return false
end

def validate_user_input(str, data_arr, type)
  case type.downcase
  when 'integer'
    integer_in_range(str, data_arr)
  when 'string'
    string_in_range(str, data_arr)
  else
    display_error
  end
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
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER1_MARKER) == 3
      return first_turn.to_s
    elsif brd.values_at(line[0], line[1], line[2]).count(PLAYER2_MARKER) == 3
      return second_turn.to_s
    #return first_turn.to_s if brd.values_at(line[0], line[1], line[2]).count(PLAYER1_MARKER) == 3
    #return second_turn.to_s if brd.values_at(line[0], line[1], line[2]).count(PLAYER2_MARKER) == 3
    end
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

def prioritize(range_arr)
  attention = WINNING_LINES.each_with_object([]) do |line, arr|
    arr << (line - range_arr)
  end 
  attention.keep_if { |arr| arr.size == 1 }
end

def detect_offense(brd, valid_squares, computer_marker)
  valid_offense(prioritize(computer_squares(brd, computer_marker)), valid_squares)
end
 
def valid_defense(threat_range, valid_squares)
  if threat_range.empty? == false
    threats = threat_range.flatten
    threats.keep_if {|num| valid_squares.include?(num)}
    threats if threats.empty? == false
  end
end

def detect_defense(brd, valid_squares, player_marker) 
  valid_defense(prioritize(player_squares(brd, player_marker)), valid_squares)
end

def select_five(brd, valid_squares, player_marker)
  !!(valid_squares.include?(5)) && (player_squares(brd, player_marker).empty? == false)
end
###########################################
# Output
###########################################
def display_error
  error = <<~MSG
  please check input type (string/integer) 
  and all valid input strings 
  (e.g. ['Yes y no n'])
  MSG
  prompt error
end

def display_available_choices(arr)
  message = <<~MSG
  Choose an available square
  #{join(arr)}
  MSG
  prompt message
end

def display_invalid_choice
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

def ask_who_goes_first(hsh)
  loop do
    who = <<~MSG
    Who would you like to go first?
    (p)layer, (c)omputer, or (r)andom
    (valid choices are p,c, or r)
    MSG
    prompt who
    answer = gets.chomp
    valid_inputs = hsh[:valid_user_inputs]
    string_input = validate_user_input(answer, valid_inputs, 'string')
    hsh[:user_choice] << string_input if string_input
    break if hsh[:user_choice] != ''
    prompt 'sorry, please input a valid choice.'
  end
end

def ask_how_many_rounds
  rounds = ''
  loop do
    message = <<~MSG
    How many rounds 
    do you want to play?
    (max rounds = 5)
    MSG
    prompt message
    answer = gets.chomp
    answer = '1' if answer == ''
    valid_inputs = [1,5]
    rounds = validate_user_input(answer, valid_inputs, 'integer')
    break if rounds != false
    prompt 'sorry, please input a valid number 1-5'
    end
    rounds
  end

def display_match_rules(rounds)
  match_params = <<~MSG
  Great! The first player to win
  #{rounds} round(s) wins the match. 
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

def ask_play_again
  play = ''
  loop do
    prompt 'Play another match?(y/n)'
    play << gets.chomp.downcase
    play = 'y' if play == ''
    valid_input = %w(y n)
    answer = validate_user_input(play, valid_input, 'string') 
    case answer
    when 'y'
      clear_screen
      break
    when 'n'
      return answer
    else
      prompt 'sorry, "y" or "n" please'
    end
  end
end

###########################################
# Modify Values
###########################################

def set_users(hsh)
  if hsh[:user_1] && hsh[:user_2] != ''
    reset_local_var(hsh[:user_1], hsh[:user_2])
  end
  if hsh[:user_choice] == 'r'
    computer_chooses(hsh)
  else
    set_user_order(hsh, hsh[:user_choice].to_sym)
  end
end

def computer_chooses(hsh)
  if hsh[:computer_choice] == ''
    hsh[:computer_choice] << hsh[:r].sample
  end
  set_user_order(hsh, hsh[:computer_choice].to_sym)
end
   
def set_user_one(hsh, sym)
  hsh[:user_1] << hsh[sym]
end

def set_user_two(hsh)
  hsh[:user_2] << hsh[:p] if hsh[:user_1] == 'Computer'
  hsh[:user_2] << hsh[:c] if hsh[:user_1] == 'Player'
end

def set_user_order(hsh, sym)
  set_user_one(hsh, sym)
  set_user_two(hsh)
end

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
    display_available_choices(empty_squares(brd))
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    display_invalid_choice
  end
  brd[square] = player_marker 
end
# refactor computer_places_piece! by detecting boolean values? 
def computer_places_piece!(brd, valid_squares, computer_marker, opponent_marker)
  if detect_offense(brd, valid_squares, computer_marker)
    square = detect_offense(brd, valid_squares, computer_marker).sample
  elsif detect_defense(brd, valid_squares, opponent_marker)
    square = detect_defense(brd, valid_squares, opponent_marker).sample
  elsif select_five(brd, valid_squares, opponent_marker)
    square = 5
  else
    square = valid_squares.sample
  end
  brd[square] = computer_marker if square != nil
end

def first_player(brd, first_turn) 
  case first_turn
  when 'Player'
    player_places_piece!(brd, PLAYER1_MARKER)
  when 'Computer'
    computer_places_piece!(brd, empty_squares(brd), PLAYER1_MARKER, PLAYER2_MARKER)
  end
end
  
def second_player(brd, second_turn) 
  case second_turn 
  when 'Computer'
    computer_places_piece!(brd, empty_squares(brd), PLAYER2_MARKER, PLAYER1_MARKER)
  when 'Player'
    player_places_piece!(brd, PLAYER2_MARKER)
  end
end

def display_players_markers(first_turn, second_turn)
  prompt "#{first_turn} = 'X', #{second_turn} = 'O'"
end

def turns(brd, first_turn, second_turn, counter)
  first_player(brd, first_turn) if counter.even?
  second_player(brd, second_turn) if counter.odd?
end

def round_loop(brd, score, first_turn, second_turn)
  counter = 0
  loop do
    update_board(brd) 
    display_players_markers(first_turn, second_turn)
    display_score(score)
    turns(brd, first_turn, second_turn, counter)
    update_board(brd) 
    counter += 1
    break if someone_won?(brd, first_turn, second_turn) || board_full?(brd)
    clear_screen
  end
  display_round_standings(brd, score, first_turn, second_turn)
end

###########################################
# Game Logic
###########################################
loop do 
  users = initialize_users
  display_welcome_message
  ask_who_goes_first(users)
  set_users(users)
  num_rounds = ask_how_many_rounds
  display_match_rules(num_rounds)
  sleep(1)
  current_score = initialize_score 
  loop do 
    board = initialize_board
    round_loop(board, current_score, users[:user_1], users[:user_2])
    break if current_score.value?(num_rounds)
  end 
  display_match_summary(current_score, num_rounds)
  break if ask_play_again == 'n'
end
display_closing
