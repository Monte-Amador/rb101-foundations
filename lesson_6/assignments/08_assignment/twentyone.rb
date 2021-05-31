###########################################
# setup
###########################################
def prompt(msg)
  puts "=> #{msg}"
end

def clear_screen
  system('clear') || system('cls')
end

def reset_local_var(variable, *vars)
  variable.clear
  if vars
    vars.each(&:clear)
  end
end

###########################################
# initialize
###########################################

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
    deal(hsh, player, 'hide')
    if twentyone?(hsh, player)
      puts "#{player.to_s.capitalize} got 21!" 
      sleep(1)
    end
    deal(hsh, dealer, 'hide')
    break if hsh[player][:cards].size && hsh[dealer][:cards].size == 2
  end
end

def deal(hsh, user, *hide)
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
  if hide == []
    display_single_card(user, new_card)
    sleep(1)
  end
  user_hand << new_card
end

###########################################
# output
###########################################

def display_user_turn(user)
  header = <<~MSG
  #########################################
  # #{user.to_s.capitalize}'s Turn
  #########################################
  MSG
  puts header
end

def display_game_summary
  header = <<~MSG
  #########################################
  # Game Over
  #########################################
  MSG
  puts header
end

def display_initial_hands(hsh)
  puts "Dealer's Hand: #{display_dealer_cards(hsh, :dealer)}"
  puts "Player's Hand: #{display_user_cards(hsh, :player)}"
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
  # good use of joiner method here
  "#{display.join(' ')} >>> Total: #{total.sum}"
end

def display_all_cards(hsh)
  puts "Dealer's Hand: #{display_user_cards(hsh, :dealer)}"
  puts "Player's Hand: #{display_user_cards(hsh, :player)}"
end

def display_single_card(user, arr)
  card = <<~MSG
  #{user.capitalize}'s New Card:
  #{arr[0].capitalize + arr[1].capitalize}
  MSG
  puts card
end

def ask_play_again
  question = <<~MSG
  
  play again?
  MSG
  puts question
  answer = gets.chomp
end

###########################################
# inspect/modify
###########################################

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
  # maybe return false after testing the output verifies < 21
end

def hold_on_seventeen?(hsh, user)
  total = []
  hsh[user][:cards].select {|item| total << item[2] }
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

def display_bust(arr)
  user1 = arr[0].to_s.capitalize
  user2 = arr[1].to_s.capitalize
  message = <<~MSG
  #{user1} busts!
  #{user2} wins!
  MSG
  prompt message
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

def compare_hands(hsh, player, dealer)
  player_total = []
  dealer_total = []
  hsh[player][:cards].select { |item| player_total << item[2] }
  hsh[dealer][:cards].select { |item| dealer_total << item[2] }
  if player_total.sum > dealer_total.sum 
    puts "#{player.to_s.capitalize} wins hand!"
    player
  elsif dealer_total.sum > player_total.sum
    puts "#{dealer.to_s.capitalize} wins hand!"
    dealer
  else
    puts "Push!"
  end
end

#def someone_won?(hsh, player, computer)
#  !!compare_hands(hsh, player, computer)
#end

###########################################
# iterations
###########################################

def player_turn(hsh, user)
  loop do
    break if bust?(hsh, user) || twentyone?(hsh, user)
    display_user_turn(user)
    display_initial_hands(hsh)
    puts "Would you like to (h)it or (s)tay?"
    reply = gets.chomp
    clear_screen
    if reply == 'h'
      deal(hsh, user)
      sleep(1)
      clear_screen
      if twentyone?(hsh, user)
        puts "#{user.to_s.capitalize} got 21!" 
        sleep(1)
      end
    elsif reply == 's'
      puts "Player chooses to stay!"
      sleep(1)
      clear_screen
    else
      puts "Sorry, valid inputs are 'h, or s'"
    end
    break if reply == 's'
  end
end

def dealer_turn(hsh, user)
  loop do
    break if bust?(hsh, :player)
    clear_screen
    display_user_turn(user)
    display_all_cards(hsh)
    break if hold_on_seventeen?(hsh, user) 
    deal(hsh, user)
    sleep(2)
    clear_screen
    break if bust?(hsh, user) || twentyone?(hsh, user)
  end
end

def welcome_message
  clear_screen
  message = <<~MSG
  Welcome to 21!
  The goal is to get to 21 without going over.
  If neither player reaches 21, highest card wins.
  Each user get's a turn and can continue to receive cards 
  until they elect to stay or bust.
  
  >>> Dealer must stay on 17 or higher <<<
  press return to continue.
  MSG
  prompt message
  keypress = gets.chomp
end
###########################################
# game logic
###########################################

loop do
  welcome_message
  loop do 
    round = initialize_twenty_one
    initial_deal(round, :player, :dealer)
    clear_screen
    player_turn(round, :player)
    dealer_turn(round, :dealer)
    clear_screen
    display_game_summary
    if someone_busted(round)
      display_all_cards(round)
      display_bust(someone_busted(round))
    else
      display_all_cards(round)
      compare_hands(round, :player, :dealer)
    end
    break if ask_play_again == 'n'
  end
    break if ask_play_again == 'n'
end
