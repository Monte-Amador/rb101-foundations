###########################################
# 1. setup
###########################################
def prompt(msg)
  puts "=> #{msg}"
end

def clear_screen
  system('clear') || system('cls')
end

#def reset_local_var(variable, *vars)
#  variable.clear
#  if vars
#    vars.each(&:clear)
#  end
#end

###########################################
# 2. initialize
###########################################

def initialize_score
  hsh = { 
    player: 0,
    dealer: 0 }
end

def initialize_twenty_one
  twenty_one = {
    dealer: { cards: [], score: '' },
    player: { cards: [], score: '' },
    deck: { 
      hearts: {
        cards: {
        '2': [2], 
        '3': [3], 
        '4': [4], 
        '5': [5], 
        '6': [6], 
        '7': [7], 
        '8': [8], 
        '9': [9], 
        '10': [10], jack: [10], queen: [10], king: [10], ace: [11] }
      },
      diamonds: {
        cards: {
        '2': [2], 
        '3': [3], 
        '4': [4], 
        '5': [5], 
        '6': [6], 
        '7': [7], 
        '8': [8], 
        '9': [9], 
        '10': [10], jack: [10], queen: [10], king: [10], ace: [11] }
      },
      clubs: {
        cards: {
        '2': [2], 
        '3': [3], 
        '4': [4], 
        '5': [5], 
        '6': [6], 
        '7': [7], 
        '8': [8], 
        '9': [9], 
        '10': [10], jack: [10], queen: [10], king: [10], ace: [11] }
      },
      spades: {
        cards: {
        '2': [2], 
        '3': [3], 
        '4': [4], 
        '5': [5], 
        '6': [6], 
        '7': [7], 
        '8': [8], 
        '9': [9], 
        '10': [10], jack: [10], queen: [10], king: [10], ace: [11] }
      }
    }
  }
end

def initial_deal(hsh, player, dealer)
  hsh[player][:cards] = []
  hsh[dealer][:cards] = []
  loop do
    deal(hsh, player, 'hidden')
    if twentyone?(hsh, player)
      prompt "#{player.to_s.capitalize} got 21!" 
      sleep(1)
    end
    deal(hsh, dealer, 'hidden')
    break if hsh[player][:cards].size && hsh[dealer][:cards].size == 2
  end
end

def deal(hsh, user, *hidden)
  new_card = []
  user_hand = hsh[user][:cards]
  deck = hsh[:deck]
  suit = deck.keys.sample
  cards = deck[suit][:cards]
  single_card = select_valid_cards(cards).keys.sample
  value = cards[single_card].sample
  card_display = inspect_card(single_card)
  suit_display = suit.to_s.capitalize[0]
  new_card << "#{card_display}"
  new_card << "#{suit_display}"
  new_card << remove_card(cards[single_card], value)
  if is_ace?(card_display) && will_user_bust?(hsh, user)
    modify_ace_value!(new_card)
  end
  if hidden == []
    display_single_card(user, new_card)
    sleep(1)
  end
  user_hand << new_card
end

###########################################
# 3. output
###########################################

def display_error
  error <<~MSG
  Sorry, please check
  your input to verify it
  is correct.
  MSG
  prompt error
end

def display_banner(msg, *spacer)
  banner = <<~MSG
  #########################################
  # #{msg}
  #########################################
  MSG
  puts banner
end

def display_match_summary(hsh)
  if hsh[:player] == 5
    "Player wins match!"
  else
    "Dealer wins match!"
  end
end

def display_user_turn(user)
  "#{user.to_s.capitalize}'s Turn"
end

def display_initial_hands(hsh)
  prompt "Dealer's Hand: #{display_dealer_cards(hsh, :dealer)}"
  prompt "Player's Hand: #{display_user_cards(hsh, :player)}"
end

def display_dealer_cards(hsh, user)
  display = []
  hand = hsh[user][:cards]
  hand.each do |arr|
    output = []
    output << arr[0..1]
    if arr[2] == 1
      output << "(1/11)"
    elsif arr[2] == 11
      output << "(1/11)"
    else
      output << "(#{arr[2]})"
    end
    display << output.join
    end
  display[0] = "|X|"
  display.join(' ')
end

def display_user_cards(hsh, user)
  display = []
  total = []
  hand = hsh[user][:cards] 
  hand.each do |arr|
    output = []
    output << arr[0..1]
    output << "(#{arr[2]})"
    total << arr[2]
    display << output.join
    end
  "#{display.join(' ')} >>> Total: #{total.sum}"
end

def display_all_cards(hsh)
  prompt "Dealer's Hand: #{display_user_cards(hsh, :dealer)}"
  prompt "Player's Hand: #{display_user_cards(hsh, :player)}"
end

def display_single_card(user, arr)
  card = <<~MSG
  #{user.capitalize}'s New Card:
  #{arr[0].capitalize + arr[1].capitalize}
  MSG
  prompt card
end

def display_bust(arr, score, hsh)
  user1 = arr[0].to_s.capitalize
  user2 = arr[1].to_s.capitalize
  display_banner "#{user1} busts, #{user2} wins!"
  score[arr[1]] += 1
  if user1 == 'Player'
    display_initial_hands(hsh)
  else
    display_all_cards(hsh)
  end
end

def exit_game
  question = <<~MSG
  exit game?
  MSG
  prompt question
  answer = gets.chomp.downcase
end

def closing_message
  prompt "Thanks for playing 21, goodbye!"
end

###########################################
# 4. inspect/modify
###########################################
def inspect_hands(hsh, player, dealer, score)
  if someone_busted(hsh)
    display_bust(someone_busted(hsh), score, hsh)
  else
    compare_hands(hsh, player, dealer, score)
    display_all_cards(hsh)
  end
end

def validate_integer_input(int)
  if int.include?('.')
    return false
  end
  int.to_i if int.to_i.to_s == int
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

def match_winner?(hsh)
  hsh.has_value?(5)
end

def select_valid_cards(hsh)
  hsh.select { |key, hsh| hsh.size > 0 }
end

def inspect_card(key)
  if key == :'10'
    (key[0] + key[1])
  else
    key.to_s.capitalize[0]
  end
end

def remove_card(hsh, item)
  hsh.delete(item)
end

def is_ace?(card)
  card == 'A' 
end

def modify_ace_value!(arr)
  arr.delete('11')
  arr[2] = 1
end

def will_user_bust?(hsh, user)
  total = []
  hand = hsh[user][:cards]
  hand.each do |arr|
    total << arr[2]
    end
  total.sum >= 11
end

def reassign_ace!(arr)
  arr.each do |sub_arr|
    if sub_arr[2] == 11
      sub_arr[2] = 1
    end
  end
  return false
end

def hold_on_seventeen(hsh)
  total = []
  hsh[:dealer][:cards].select {|item| total << item[2] }
  total if total.sum >= 17 
end

def bust?(hsh, user) 
  total = []
  cards = hsh[user][:cards]
  cards.select {|item| total << item[2]}
  if total.sum > 21 && total.include?(11)
    reassign_ace!(cards)  
  else
    total.sum > 21
  end
end

def twentyone?(hsh, user) 
  total = []
  hsh[user][:cards].select {|item| total << item[2]}
  total.sum == 21
end

def someone_busted(hsh)
  player = :player
  dealer = :dealer
  if !!bust?(hsh, player)
    [player, dealer]
  elsif !!bust?(hsh, dealer)
    [dealer, player]
  end
end

def total_value_cards(hsh, user)
  user_total = []
  hsh[user][:cards].select {|item| user_total << item[2] }
  user_total
end

def display_winner(user)
  user_capitalize = user.to_s.capitalize
  display_banner "#{user_capitalize} wins hand!"
end

def compare_hands(hsh, player, dealer, score)
  player_total = total_value_cards(hsh, player)
  dealer_total = total_value_cards(hsh, dealer)
  if player_total.sum > dealer_total.sum 
    display_winner(player) 
    score[player] += 1
  elsif dealer_total.sum > player_total.sum
    display_winner(dealer) 
    score[dealer] += 1 
  else
    display_banner "Push!"
  end
end

###########################################
# 5. iterations
###########################################

def ask_hit_stay
  prompt "Would you like to (h)it or (s)tay?"
  reply = gets.chomp.downcase
  string_input = val_user_input(reply, ['s', 'S', 'H', 'h'], 'string')
end

def hit(hsh, user)
  if user == :dealer
    sleep(2)
  end
  deal(hsh, user)
  sleep(1)
  clear_screen
  if twentyone?(hsh, user)
    prompt "#{user.to_s.capitalize} got 21!" 
    sleep(2)
  end
end

def stay
  prompt "Player chooses to stay!"
  sleep(1)
  clear_screen
end

def player_turn(hsh, user)
  loop do
    break if bust?(hsh, user) || twentyone?(hsh, user)
    display_banner(display_user_turn(user))
    display_initial_hands(hsh)
    action = ask_hit_stay
    clear_screen
    if action == 'h'
      hit(hsh, user)
    elsif action == 's'
      return stay
    else
      prompt "Sorry, valid inputs are 'h, or s'"
    end
  end
end

def dealer_turn(hsh, user)
  loop do
    break if bust?(hsh, :player)
    clear_screen
    display_banner(display_user_turn(user))
    display_all_cards(hsh)
    break if hold_on_seventeen(hsh) 
    hit(hsh, user)
    break if bust?(hsh, user) || twentyone?(hsh, user)
  end
end

def welcome_message
  clear_screen
  message = <<~MSG
  Welcome to 21!
  The goal is to get to 21 without going over.
  If neither player gets 21, highest hand wins.
  First player to win 5 hands wins the match!
 
  >>> Dealer must stay on 17 or higher <<<
  press return to continue.
  MSG
  puts message
  keypress = gets.chomp
end

def display_score(hsh)
  "21 Match Score:
  Dealer: #{hsh[:dealer]}
  Player: #{hsh[:player]}"
end

def display_visual_spacer
  puts "\n"
end

def ask_another_hand()
  prompt "shuffle and deal again?(y/n)"
  answer = gets.chomp.downcase
  string_input = val_user_input(answer, ['y', 'n'], 'string')
end
###########################################
# 6. game logic
###########################################

loop do
  welcome_message
  score = initialize_score
  loop do 
    round = initialize_twenty_one
    initial_deal(round, :player, :dealer)
    clear_screen
    player_turn(round, :player)
    dealer_turn(round, :dealer)
    clear_screen
    inspect_hands(round, :player, :dealer, score)
    display_visual_spacer
    display_banner(display_score(score))
    if match_winner?(score)
      prompt display_match_summary(score)
      return closing_message
    end
    display_visual_spacer
    break if ask_another_hand == 'n'
  end
    break if exit_game == 'y'
end
closing_message
