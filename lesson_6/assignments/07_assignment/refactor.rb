WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals

INITIAL_MARKER = ' '
PLAYER1_MARKER = 'X'
PLAYER2_MARKER = 'O'

###########################################
# initialize helpers
###########################################

def reset_local_var(variable, *vars)
  variable.clear
  if vars
    vars.each(&:clear)
  end
end

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

###########################################
# initialize methods
###########################################

def initialize_users
  { p: 'Player',
    c: 'Computer',
    r: ['p', 'c'],
    valid_user_inputs: ['p', 'c', 'r'],
    user_choice: '',
    computer_choice: '',
    user1_title: '',
    user2_title: '' }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = num }
  new_board[:player_markers] = { user1: PLAYER1_MARKER, user2: PLAYER2_MARKER }
  new_board
end

def initialize_score
  { player: 0, computer: 0 }
end

###########################################
# retrieve/inspect
###########################################

def validate_joiner_array(squares)
  !!squares.is_a?(Array)
end

def joiner_iteration(squares, delimeter, conjunction)
  output = ''
  squares.each_with_index do |value, idx|
    output << if idx < (squares.size - 1)
                "#{value}#{delimeter}"
              else
                "#{conjunction} #{value}"
              end
  end
  output
end

def joiner(squares, delimeter = ', ', conjunction = 'or')
  if validate_joiner_array(squares)
    string_output = ''
    case squares.size
    when 1 then string_output << squares[0].to_s
    when 2
      string_output << ("#{squares[0]} #{conjunction} #{squares[1]}")
    when 3..9
      string_output << joiner_iteration(squares, delimeter, conjunction)
    else
      prompt "There was a problem with the array size"
    end
    string_output
  else
    prompt 'Sorry, please provide a valid array as an argument.'
  end
end

def validate_integer_input(int)
  if int.include?('.')
    return false
  else
    int.to_i if int.to_i.to_s == int
  end
end

def integer_in_range(str, range)
  return nil if !validate_integer_input(str)
  int = str.to_i
  case range.size
  when 2
    return int if int.between?(range[0], range[1])
  when 1
    return int if range.join.to_i == int
  else
    display_error
  end
end

def string_in_range(str, range)
  test_string = range.join(' ').split
  string = str.strip.downcase
  string if test_string.include?(string)
end

def val_user_input(str, data_arr, type)
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
  brd.keys.select { |num| brd[num] == num }
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd, users_hsh)
  !!detect_winner(brd, users_hsh)
end

def detect_winner(brd, users_hsh)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER1_MARKER) == 3
      return users_hsh[:user1_title]
    elsif brd.values_at(line[0], line[1], line[2]).count(PLAYER2_MARKER) == 3
      return users_hsh[:user2_title]
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

def selection(brd, user)
  selected_squares = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == brd[:player_markers][user]
  end
  selected_squares
end

def priority(range_arr)
  attention = WINNING_LINES.each_with_object([]) do |line, arr|
    arr << (line - range_arr)
  end
  attention.keep_if { |arr| arr.size == 1 }
end

def valid_offense(brd, win_range)
  if win_range.empty? == false
    win = win_range.flatten
    win.keep_if { |num| empty_squares(brd).include?(num) }
    win if win.empty? == false
  end
end

def detect_offense(brd, computer)
  if valid_offense(brd, priority(selection(brd, computer)))
    valid_offense(brd, priority(selection(brd, computer))).sample
  end
end

def valid_defense(brd, threat_range)
  if threat_range.empty? == false
    threats = threat_range.flatten
    threats.keep_if { |num| empty_squares(brd).include?(num) }
    threats if threats.empty? == false
  end
end

def detect_defense(brd, opponent)
  if valid_defense(brd, priority(selection(brd, opponent)))
    valid_defense(brd, priority(selection(brd, opponent))).sample
  end
end

def select_five(brd, opponent)
  if (empty_squares(brd).include?(5)) && (!selection(brd, opponent).empty?)
    5
  end
end
###########################################
# output
###########################################

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

def display_error
  error = <<~MSG
  please check input type (string/integer) 
  and all valid input strings 
  (e.g. ['Yes y no n'])
  MSG
  prompt error
end

def display_invalid_choice
  message = <<~MSG
  Sorry, 
  that is not a valid choice
  MSG
  prompt message
end

def display_welcome_message
  welcome_prompt = <<~MSG
  Play Tic Tac Toe against the computer!
  MSG
  prompt(welcome_prompt)
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

def display_round_standings(brd, score, users_hsh)
  update_board(brd)
  if someone_won?(brd, users_hsh)
    prompt "#{detect_winner(brd, users_hsh)} won!"
    update_score(score, brd, users_hsh)
  else
    prompt "It's a tie!"
  end
  sleep(2)
end

def display_score(score)
  score = <<~MSG
  Current Scores:
  Player: #{score[:player]}
  Computer: #{score[:computer]}

  MSG
  prompt(score)
end

def display_available_choices(squares)
  message = <<~MSG
  Choose an available square
  #{joiner(squares)}
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

###########################################
# input
###########################################
def ask_marker_preference(hsh, valid_input, brd)
  choice = ''
  loop do
    message = <<~MSG
    Would you like to choose 
    your own marker? (y)es, or (n)o
    MSG
    prompt message
    answer = gets.chomp
    answer = 'n' if answer == ''
    choice = val_user_input(answer, valid_input, 'string')
    break if choice
    display_invalid_choice
  end
    choose_marker(hsh, brd) if choice == 'y'
end

def choose_marker(hsh, brd)
  choice = ''
  loop do
    question = <<~MSG
    Please choose between
    (x), or (o).
    MSG
    prompt question
    answer = gets.chomp
    valid_input = ['x', 'o']
    break if answer == '' #test empty string
    choice = val_user_input(answer, valid_input, 'string') 
    break if choice
    display_invalid_choice
  end
  case choice
  when 'o'
    if hsh[:user1_title] == 'Player'
     brd[:player_markers][:user1] = PLAYER2_MARKER
     brd[:player_markers][:user2] = PLAYER1_MARKER
    end
    p brd
  when 'x'
    if hsh[:user2_title] == 'Player'
     brd[:player_markers][:user1] = PLAYER2_MARKER
     brd[:player_markers][:user2] = PLAYER1_MARKER
    end
    p brd
  end
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
    string_input = val_user_input(answer, hsh[:valid_user_inputs], 'string')
    hsh[:user_choice] << string_input if string_input
    break if hsh[:user_choice] != ''
    prompt 'sorry, please input a valid choice.'
  end
end

def ask_how_many_rounds(arr)
  rounds = ''
  loop do
    message = <<~MSG
    How many rounds do you
    want to play? (max. 5)
    MSG
    prompt message
    answer = gets.chomp
    answer = '1' if answer == ''
    rounds = val_user_input(answer, arr, 'integer')
    break if rounds
    prompt 'sorry, please input a valid number 1-5'
  end
  rounds
end

def ask_play_again(valid_input)
  loop do
    prompt 'Play another match?(y/n)'
    play = gets.chomp.downcase
    play = 'y' if play == ''
    case val_user_input(play, valid_input, 'string')
    when 'y'
      clear_screen
      break
    when 'n'
      return 'n'
    else
      prompt 'sorry, "y" or "n" please'
    end
  end
end

###########################################
# modify values
###########################################

def create_user_one(hsh, sym)
  hsh[:user1_title] << hsh[sym]
end

def create_user_two(hsh)
  hsh[:user2_title] << hsh[:p] if hsh[:user1_title] == 'Computer'
  hsh[:user2_title] << hsh[:c] if hsh[:user1_title] == 'Player'
end

def establish_user_order(hsh, sym)
  create_user_one(hsh, sym)
  create_user_two(hsh)
end

def computer_chooses(hsh)
  if hsh[:computer_choice] == ''
    hsh[:computer_choice] << hsh[:r].sample
  end
  establish_user_order(hsh, hsh[:computer_choice].to_sym)
end

def assign_users(hsh)
  if hsh[:user1_title] && hsh[:user2_title] != ''
    reset_local_var(hsh[:user1_title], hsh[:user2_title])
  end
  if hsh[:user_choice] == 'r'
    computer_chooses(hsh)
  else
    establish_user_order(hsh, hsh[:user_choice].to_sym)
  end
end

def update_score(score, brd, users_hsh)
  score[:player] += 1 if detect_winner(brd, users_hsh).include?('Player')
  score[:computer] += 1 if detect_winner(brd, users_hsh).include?('Computer')
end

def player_places_piece!(brd, player)
  square = ''
  loop do
    display_available_choices(empty_squares(brd))
    choice = gets.chomp
    square = validate_integer_input(choice)
    break if empty_squares(brd).include?(square)
    display_invalid_choice
  end
  brd[square] = brd[:player_markers][player]
end

def computer_places_piece!(brd, computer, opponent)
  square = if detect_offense(brd, computer)
             detect_offense(brd, computer)
           elsif detect_defense(brd, opponent)
             detect_defense(brd, opponent)
           elsif select_five(brd, opponent)
             select_five(brd, opponent)
           else
             empty_squares(brd).sample
           end
  brd[square] = brd[:player_markers][computer]
end

def first_player(brd, users_hsh)
  case users_hsh[:user1_title]
  when 'Player'
    player_places_piece!(brd, :user1)
  when 'Computer'
    computer_places_piece!(brd, :user1, :user2)
  end
end

def second_player(brd, users_hsh)
  case users_hsh[:user2_title]
  when 'Computer'
    computer_places_piece!(brd, :user2, :user1)
  when 'Player'
    player_places_piece!(brd, :user2)
  end
end

def display_players_markers(brd, users_hsh)
  user_markers = <<~MSG
  Player Markers:
  #{users_hsh[:user1_title]} = #{brd[:player_markers][:user1]}, 
  #{users_hsh[:user2_title]} = #{brd[:player_markers][:user2]}

  MSG
  prompt user_markers
end

def iterate_users(brd, counter, users_hsh)
  first_player(brd, users_hsh) if counter.even?
  second_player(brd, users_hsh) if counter.odd?
end

def round_loop(brd, score, users_hsh)
  counter = 0
  loop do
    update_board(brd)
    display_players_markers(brd, users_hsh)
    display_score(score)
    iterate_users(brd, counter, users_hsh)
    update_board(brd)
    counter += 1
    break if someone_won?(brd, users_hsh) || board_full?(brd)
    clear_screen
  end
  display_round_standings(brd, score, users_hsh)
end

###########################################
# call game
###########################################
loop do
  clear_screen
  users = initialize_users
  display_welcome_message
  ask_who_goes_first(users)
  assign_users(users)
  num_rounds = ask_how_many_rounds([1, 5])
  display_match_rules(num_rounds)
  sleep(3)
  current_score = initialize_score
  loop do
    board = initialize_board
    # this works but needs refinement, there needs to be a better way to hold the value that the use chooses if the user chooses in case of a tie.
    ask_marker_preference(users, ['y', 'n'], board)
    round_loop(board, current_score, users)
    break if current_score.value?(num_rounds)
  end
  display_match_summary(current_score, num_rounds)
  break if ask_play_again(['y', 'n']) == 'n'
end
display_closing
