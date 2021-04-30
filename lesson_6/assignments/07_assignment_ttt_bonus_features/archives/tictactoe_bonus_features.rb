# rubocop:disable Style/FrozenStringLiteralComment
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals
# rubocop:enable Style/FrozenStringLiteralComment

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

def clear_screen
  system('clear') || system('cls')
end

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def validate_joiner_argument(arr)
  !!arr.is_a?(Array)
end

# rubocop:disable Metrics/MethodLength
def joiner(arr, del = ', ', conj = 'or')
  if validate_joiner_argument(arr)
    string_output = ''
    case arr.size
    when 0 then ''
    when 1 then string_output << arr[0].to_s
    when 2
      string_output << ("#{arr[0]} #{conj} #{arr[1]}")
    else
      arr.each_with_index do |item, idx|
        string_output << if idx < (arr.size - 1)
                           "#{item} #{del}"
                         else
                           "#{conj} #{item}"
                         end
      end
    end
    string_output
  else
    'Sorry, you need to provide an array as an argument.'
  end
end
# rubocop:enable Metrics/MethodLength

def initialize_score
  { player: 0, computer: 0 }
end

def update_score(score, brd)
  score[:player] += 1 if detect_winner(brd).include?('Player')
  score[:computer] += 1 if detect_winner(brd).include?('Computer')
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
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

loop do
  current_score = initialize_score
  prompt 'Play Tic Tac Toe against the computer, first player to 5 wins the match.'
  loop do
    board = initialize_board
    loop do
      display_board(board)
      prompt "Current Scores: Player => #{current_score[:player]}, Computer => #{current_score[:computer]}"
      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end
    display_board(board)
    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
      update_score(current_score, board)
      break if current_score.value?(5) # break round loop
    else
      prompt "It's a tie!"
    end
    sleep(2)
  end
  next unless current_score.value?(5)

  prompt "Game over, match win goes to: #{match_winner?(current_score)}!"
  prompt 'Play again?(Y/N)'
  reply = gets.chomp.downcase
  break if reply == 'n'
end
prompt 'Thanks for playing Tic Tac Toe. Good-bye!'
