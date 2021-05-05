WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def clear_screen
  system('clear') || system('cls')
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

def validate_join_array(arr)
  !!arr.is_a?(Array)
end

def join(arr, delimeter = ', ', conjunction = 'or')
  if validate_join_array(arr)
    string_output = ''
    case arr.size
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
# rubocop:enable Metrics/MethodLength

def update_score(score, brd)
  score[:player] += 1 if detect_winner(brd).include?('Player')
  score[:computer] += 1 if detect_winner(brd).include?('Computer')
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_squares(brd)
  player_selected_squares = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == PLAYER_MARKER 
  end
  player_selected_squares
end

def computer_squares(brd)
  computer_selected_squares = brd.each_with_object([]) do |(key, value), arr|
    arr << key if value == COMPUTER_MARKER 
  end
  computer_selected_squares
end

def needs_attention(player_range)
  attention = WINNING_LINES.each_with_object([]) do |line, arr|
    arr << (line - player_range)
  end 
  attention.keep_if { |arr| arr.size == 1 }
end

def valid_offense(win_range, valid_squares)
  if win_range.empty? == false
    win = win_range.flatten
    win.keep_if {|num| valid_squares.include?(num)}
    win if win.empty? == false
  end
end

def valid_defense(threat_range, valid_squares)
  if threat_range.empty? == false
    threats = threat_range.flatten
    threats.keep_if {|num| valid_squares.include?(num)}
    threats if threats.empty? == false
  end
end

def detect_offense(brd, valid_squares)
  valid_offense(needs_attention(computer_squares(brd)), valid_squares)
end
 
def detect_defense(brd, valid_squares) 
  valid_defense(needs_attention(player_squares(brd)), valid_squares)
end

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

def player_places_piece!(brd)
  square = ''
  loop do
    available_choices(empty_squares(brd))
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    invalid_choice
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd, valid_squares)
  if detect_offense(brd,valid_squares) != nil
    puts "win detected! #{detect_offense(brd, valid_squares)}"
    square = detect_offense(brd,valid_squares).sample
  elsif detect_defense(brd, valid_squares) != nil
    puts "threat detected! squares #{detect_defense(brd,valid_squares)}"
    square = detect_defense(brd, valid_squares).sample
  elsif valid_squares.include?(5)
    puts "square 5 is available!"
    square = 5 
  else
    puts "no threat detected, choosing a random number."
    square = valid_squares.sample
  end
  brd[square] = COMPUTER_MARKER if square != nil
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

def match_winner?(hsh,rounds)
  winner = hsh.select do |key, value|
    key if value == rounds
  end
  winner.to_a.flatten[0].to_s.capitalize
end

def display_score(score)
  score = <<~MSG
  Current Scores:
  Player: #{score[:player]}
  Computer: #{score[:computer]}

  MSG
  prompt(score)
end

def first_player(user_input, brd, random_user)  
  case user_input
  when 'p'
    player_places_piece!(brd)
  when 'c'
    computer_places_piece!(brd, empty_squares(brd))
  when 'r'
    
    if random_user != ''
      computer_choice = random_user
    else
      arr = ['p', 'c']
      computer_choice = arr.sample  
      random_user << computer_choice
    end

    case computer_choice 
    when 'p'
      player_places_piece!(brd)
    when 'c'
      computer_places_piece!(brd, empty_squares(brd))
    end
  end  
end

def second_player(user_input, brd, random_user) 
  user_input = random_user if random_user != ''
  case user_input 
  when 'p'
    computer_places_piece!(brd, empty_squares(brd))
  when 'c' 
    player_places_piece!(brd)
  end
end

def update_board(brd)
  clear_screen
  display_board(brd)
end


def display_round_standings(brd, score)
  if someone_won?(brd)
    clear_screen
    display_board(brd)
    prompt "#{detect_winner(brd)} won!"
    update_score(score, brd)
    sleep(2)
  else
    clear_screen
    display_board(brd)
    prompt "It's a tie!"
    sleep(2)
  end
end

def round_loop(brd, score, user_input, random_user) 
  loop do
    clear_screen
    display_board(brd)
    display_score(score)
    first_player(user_input, brd, random_user)
    update_board(brd) 
    break if someone_won?(brd) || board_full?(brd)
    second_player(user_input, brd, random_user)
    update_board(brd) 
    break if someone_won?(brd) || board_full?(brd)
    sleep(1)
    clear_screen
  end
  display_round_standings(brd, score)
end

def welcome_message
  welcome_prompt = <<~MSG
  Play Tic Tac Toe against the computer!
  MSG
  prompt(welcome_prompt)
end

def who_goes_first
  who = <<~MSG
  Who would you like to go first?
  (p)layer, (c)omputer, or (r)andom
  (valid choices are p,c, or r)
  MSG
  prompt who
  gets.chomp
end

def match_rules(rounds = 5)
  match_params = <<~MSG
  Great! The first player to #{rounds}
  wins the match. Preparing the game...
  MSG
  prompt(match_params)
end

player1 = ''

# initiate game
loop do 
  welcome_message

  user_choice = who_goes_first 

  prompt "How many rounds would you like to play?"
  match_round = gets.chomp.to_i
  match_rules(match_round)
  sleep(3)
  current_score = initialize_score 
  
  # initiate match
  loop do 
    board = initialize_board
    round_loop(board, current_score, user_choice, player1)
    break if current_score.value?(match_round)
  end 
  # end match
  player1 = '' 
  prompt "Game over, match win goes to: #{match_winner?(current_score,match_round)}!"
  prompt 'Play again?(Y/N)'
  reply = gets.chomp.downcase
  break if reply == 'n'
end
prompt 'Thanks for playing Tic Tac Toe. Good-bye!'

