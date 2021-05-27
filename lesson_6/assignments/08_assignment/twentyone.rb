def initialize_twenty_one
  twenty_one = {
    dealer: { cards: [], score: '' },
    player: { cards: [], score: '' },
    deck: { 
      hearts: {
        face_values: [2, 3, 4, 5, 6, 7, 8, 9, 10],
        jack: [10], 
        queen: [10], 
        king: [10], 
        ace: [11]
      },
      diamonds: {
        face_values: [2, 3, 4, 5, 6, 7, 8, 9, 10],
        jack: [10], 
        queen: [10], 
        king: [10], 
        ace: [11]
      },
      clubs: {
        face_values: [2, 3, 4, 5, 6, 7, 8, 9, 10],
        jack: [10], 
        queen: [10], 
        king: [10], 
        ace: [11]
      },
      spades: {
        face_values: [2, 3, 4, 5, 6, 7, 8, 9, 10],
        jack: [10], 
        queen: [10], 
        king: [10], 
        ace: [11]
      },
    }
  }
end

def clear_screen(hsh)
  system('clear') || system('cls')
  display_hands(hsh)
end

def display_hands(hsh)
  puts "Dealer's Hand: #{display_cards(hsh, :dealer)}"
  puts "Player's Hand: #{display_cards(hsh, :player)}"
end

def reset_local_var(variable, *vars)
  variable.clear
  if vars
    vars.each(&:clear)
  end
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

def deal(hsh, user)
  new_card = []
  user_hand = hsh[user][:cards]
  deck = hsh[:deck]
  suit = deck.keys.sample
  valid_cards = deck[suit].select { |key, arr| arr.size > 0 }
  return false if !valid_cards # refactor error here?
  card = valid_cards.keys.sample
  value = deck[suit][card].sample
  card_output = card.to_s.capitalize[0]
  suit_output = suit.to_s.capitalize[0]
  new_card << "#{card_output}"
  new_card << "#{suit_output}"
  new_card << deck[suit][card].delete(value)
  if is_ace?(card_output) && will_user_bust?(hsh, user)
    modify_ace_value!(new_card)
  end
  puts new_card.join
  user_hand << new_card
end

def display_cards(hsh, user)
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

def initial_deal(hsh, player, dealer)
  hsh[player][:cards] = []
  hsh[dealer][:cards] = []
  loop do
    deal(hsh, player)
    deal(hsh, dealer)
    break if hsh[player][:cards].size && hsh[dealer][:cards].size == 2
  end
end
###########################################
# reduce redundancy
###########################################

def hold_on_seventeen?(hsh, user)
  total = []
  hsh[user][:cards].select {|item| total << item[2] }
  total if total.sum >= 17 #test the return output = total or nil
end

def bust?(hsh, user) 
  total = []
  hsh[user][:cards].select {|item| total << item[2]}
  #p "#{user.to_s.capitalize} busts!" if total.sum > 21
  total.sum > 21
end

def twentyone?(hsh, user) 
  total = []
  hsh[user][:cards].select {|item| total << item[2]}
  puts "21 to #{user.to_s.capitalize}!" if total.sum == 21
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
def someone_won?(hsh, player, computer)
  !!compare_hands(hsh, player, computer)
end

###########################################
# reduce redundancy
###########################################


def player_turn(hsh, user)
  loop do
    break if bust?(hsh, user) || twentyone?(hsh, user)
    puts "Would you like to (h)it or (s)tay?"
    reply = gets.chomp
    if reply == 'h'
      deal(hsh, user)
      sleep(1)
      puts display_cards(hsh, user)
    elsif reply == 's'
      puts "Player chooses to stay!"
      puts display_cards(hsh, user)
    else
      puts "Sorry, valid inputs are 'h, or s'"
    end
    break if reply == 's'
  end
end

def dealer_turn(hsh, user)
  if bust?(hsh, :player)
    return puts "Dealer wins becaue player busted!"
  end
  puts "Dealer must stay on 17 or higher"
  loop do
    sleep(1)
    break if hold_on_seventeen?(hsh, user) 
    clear_screen(hsh)
    deal(hsh, user)
    puts display_cards(hsh, user)
    clear_screen(hsh)
    sleep(1)
    break if bust?(hsh, user) || twentyone?(hsh, user)
  end
end

def ask_play_again
  puts "play again?"
  answer = gets.chomp
end

def someone_busted(hsh, player, dealer)
  if !!bust?(hsh, player)
    dealer.to_s.capitalize
  elsif !!bust?(hsh, dealer)
    player.to_s.capitalize
  end
end

loop do 
  round = initialize_twenty_one
  initial_deal(round, :player, :dealer)
  clear_screen(round)
  sleep(1)
  player_turn(round, :player)
  sleep(1)
  dealer_turn(round, :dealer)
  if !someone_busted(round, :player, :dealer)
    compare_hands(round, :player, :dealer)
  else
    puts "#{someone_busted(round, :player, :dealer)} Wins! Due to opponent bust"
  end
  break if ask_play_again == 'n'
end
