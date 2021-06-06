def prompt(msg)
  puts "=> #{msg}"
end

def clear_screen
  system('clear') || system('cls')
end

def initialize_score
  { player: 0, dealer: 0 }
end

# rubocop:disable Metrics/MethodLength
def initialize_twenty_one
  { dealer: { cards: [], hand_total: [0] },
    player: { cards: [], hand_total: [0] },
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
          '10': [10], jack: [10], queen: [10], king: [10], ace: [11]
        }
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
          '10': [10], jack: [10], queen: [10], king: [10], ace: [11]
        }
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
          '10': [10], jack: [10], queen: [10], king: [10], ace: [11]
        }
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
          '10': [10], jack: [10], queen: [10], king: [10], ace: [11]
        }
      }
    } }
end
# rubocop:enable Metrics/MethodLength

def initial_deal(hsh, player, dealer)
  hsh[player][:cards] = []
  hsh[dealer][:cards] = []
  loop do
    deal(hsh, player)
    deal(hsh, dealer, 'hidden')
    break if hsh[player][:cards].size && hsh[dealer][:cards].size == 2
  end
end

def initial_count(hsh)
  hsh[:player][:hand_total][0] = total_value_cards(hsh, :player).sum
  hsh[:dealer][:hand_total][0] = total_value_cards(hsh, :dealer).sum
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def deal(hsh, user, *hidden)
  new_card = []
  user_total = hsh[user][:hand_total] # => array
  user_hand = hsh[user][:cards]
  deck = hsh[:deck]
  suit = deck.keys.sample
  cards = deck[suit][:cards]
  single_card = select_valid_cards(cards).keys.sample
  value = cards[single_card].sample
  card_display = inspect_card(single_card)
  suit_display = suit.to_s.capitalize[0]
  new_card << card_display.to_s
  new_card << suit_display.to_s
  new_card << remove_card(cards[single_card], value)
  if ace?(card_display) && will_user_bust?(user_total)
    modify_ace_value!(new_card)
  end
  if hidden == []
    display_single_card(user, new_card)
    sleep(1)
  end
  user_total[0] += new_card[2]
  user_hand << new_card
  if twentyone?(user_total.sum) && user == :player
    puts "#{user} got 21!"
    sleep(1)
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

def display_error
  error <<~MSG
  Sorry, please check
  your input to verify it
  is correct.
  MSG
  prompt error
end

def display_banner(msg)
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
  prompt "Player's Hand: #{display_user_cards(hsh, :player, hsh[:player][:hand_total].sum)}"
end

def display_dealer_cards(hsh, user)
  display = []
  hand = hsh[user][:cards]
  hand.each do |arr|
    output = []
    output << arr[0..1]
    output << if arr[2] == 1 || arr[2] == 11
                "(1/11)"
              else
                "(#{arr[2]})"
              end
    display << output.join
  end
  display[0] = "|X|"
  display.join(' ')
end

def display_user_cards(hsh, user, cached_total)
  display = []
  hand = hsh[user][:cards]
  hand.each do |arr|
    output = []
    output << arr[0..1]
    output << "(#{arr[2]})"
    display << output.join
  end
  "#{display.join(' ')} >>> Total: #{cached_total}"
end

def display_all_cards(hsh)
  dealer_total = hsh[:dealer][:hand_total].sum
  player_total = hsh[:player][:hand_total].sum
  prompt "Dealer's Hand: #{display_user_cards(hsh, :dealer, dealer_total)}"
  prompt "Player's Hand: #{display_user_cards(hsh, :player, player_total)}"
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
  gets.chomp.downcase
end

def closing_message
  prompt "Thanks for playing 21, goodbye!"
end

def inspect_hands(hsh, player, dealer, score)
  if who_busted(hsh)
    display_bust(who_busted(hsh), score, hsh)
  else
    compare_hands(hsh, player, dealer, score)
    display_all_cards(hsh)
  end
end

def string_in_range(str, range)
  test_string = range.join(' ').split
  string = str.strip.downcase
  string if test_string.include?(string)
end

def val_user_input(str, data_arr)
  string_in_range(str, data_arr)
end

def match_winner?(hsh)
  hsh.value?(5)
end

def select_valid_cards(hsh)
  hsh.select { |_key, val| val.size > 0 }
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

def ace?(card)
  card == 'A'
end

def modify_ace_value!(arr)
  arr.delete('11')
  arr[2] = 1
end

def will_user_bust?(total_arr)
  #if total_arr == []
  #  false
  #else
  total_arr.sum >= 11
  #end
end

def reassign_ace!(hsh, user, arr)
  arr.each do |sub_arr|
    if sub_arr[2] == 11
      sub_arr[2] = 1
    end
  end
  hsh[user][:hand_total][0] = total_value_cards(hsh, user).sum
end

def hold_on_seventeen(cached_total)
  cached_total if cached_total >= 17
end

def bust?(hsh, user, cached_total)
  values = []
  cards = hsh[user][:cards]
  cards.select { |item| values << item[2] } # best method to use?
  if cached_total > 21 && values.include?(11)
    reassign_ace!(hsh, user, cards)
    false
  else
    cached_total > 21
  end
end

def twentyone?(cached_total)
  cached_total == 21
end

def who_busted(hsh)
  player = :player
  dealer = :dealer
  dealer_total = hsh[:dealer][:hand_total].sum
  player_total = hsh[:player][:hand_total].sum
  if !!bust?(hsh, player, player_total)
    [player, dealer]
  elsif !!bust?(hsh, dealer, dealer_total)
    [dealer, player]
  end
end

def total_value_cards(hsh, user)
  total = hsh[user][:cards].each_with_object([]) do |inner_array, arr|
    arr << inner_array[2]
  end
end

def display_winner(user)
  user_capitalize = user.to_s.capitalize
  display_banner "#{user_capitalize} wins hand!"
end

def compare_hands(hsh, player, dealer, score)
  player_total = hsh[player][:hand_total].sum
  dealer_total = hsh[dealer][:hand_total].sum
  if player_total > dealer_total
    display_winner(player)
    score[player] += 1
  elsif dealer_total > player_total
    display_winner(dealer)
    score[dealer] += 1
  else
    display_banner "Push!"
  end
end

def ask_hit_stay
  prompt "Would you like to (h)it or (s)tay?"
  reply = gets.chomp.downcase
  val_user_input(reply, ['s', 'S', 'H', 'h'])
end

def hit(hsh, user, cached_total)
  if user == :dealer
    sleep(2)
  end
  deal(hsh, user)
  sleep(1)
  clear_screen
  if twentyone?(cached_total)
    prompt "#{user.to_s.capitalize} got 21!"
    sleep(2)
  end
end

def stay
  prompt "Player chooses to stay!"
  sleep(1)
  clear_screen
end

def user_turn(hsh, user)
  loop do
    total_arr = hsh[user][:hand_total]
    break if bust?(hsh, user, total_arr.sum) || twentyone?(total_arr.sum)
    display_banner(display_user_turn(user))
    if user == :player
      break if player_turn(hsh, user, total_arr.sum) == 'stay'
    else
      break if bust?(hsh, :player, hsh[:player][:hand_total].sum)
      break if dealer_turn(hsh, user, total_arr.sum) == total_arr.sum
    end
  end
end

def player_turn(hsh, user, cached_total)
    display_initial_hands(hsh)
    action = ask_hit_stay
    clear_screen
    if action == 'h'
      hit(hsh, user, cached_total)
    elsif action == 's'
      display_banner("Player stays with #{cached_total}")
      sleep(2)
      clear_screen
      'stay' 
    else
      prompt "Sorry, valid inputs are 'h, or s'"
    end
end

def dealer_turn(hsh, user, cached_total)
    display_all_cards(hsh)
    return cached_total if hold_on_seventeen(cached_total)
    hit(hsh, user, cached_total)
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
  gets.chomp
end

def continue
  message = <<~MSG
  press return
  when ready to continue
  MSG
  prompt message
  gets.chomp
  clear_screen
  sleep(1)
end

def display_score(hsh)
  "21 Match Score:
  Dealer: #{hsh[:dealer]}
  Player: #{hsh[:player]}"
end

def display_visual_spacer
  puts "\n"
end

def ask_another_hand
  prompt "shuffle and deal again?(y/n)"
  answer = gets.chomp.downcase
  val_user_input(answer, ['y', 'n'])
end

loop do
  welcome_message
  score = initialize_score
  loop do
    round = initialize_twenty_one
    initial_deal(round, :player, :dealer)
    initial_count(round)
    clear_screen
    user_turn(round, :player) # can we make one method call for both players?
    user_turn(round, :dealer)
    clear_screen
    inspect_hands(round, :player, :dealer, score)
    display_visual_spacer
    display_banner(display_score(score))
    if match_winner?(score)
      prompt display_match_summary(score)
      return closing_message
    else
      continue 
    end
    display_visual_spacer
  end
  break if ask_another_hand == 'n'
end
closing_message
