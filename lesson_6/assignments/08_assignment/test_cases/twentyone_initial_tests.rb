def initialize_twenty_one
  twenty_one = {
    dealer: { cards: [], score: '' },
    player: { cards: [], score: '' },
    deck: { 
      hearts: {
        ace: [1, 11], 
        jack: [10], 
        queen: [10], 
        king: [10], 
        face_cards: [2, 3, 4, 5, 6, 7, 8, 9, 10]
      },
      diamonds: {
        ace: [1, 11], 
        jack: [10], 
        queen: [10], 
        king: [10], 
        face_cards: [2, 3, 4, 5, 6, 7, 8, 9, 10]
      },
      clubs: {
        ace: [1, 11], 
        jack: [10], 
        queen: [10], 
        king: [10], 
        face_cards: [2, 3, 4, 5, 6, 7, 8, 9, 10]
      },
      spades: {
        ace: [1, 11], 
        jack: [10], 
        queen: [10], 
        king: [10], 
        face_cards: [2, 3, 4, 5, 6, 7, 8, 9, 10]
      },
    }
  }
end

def reset_local_var(variable, *vars)
  variable.clear
  if vars
    vars.each(&:clear)
  end
end

def sample_from_deck(hsh, user)
  user_hand = hsh[user][:cards]
  deck = hsh[:deck]
  suit = deck.keys.sample
  valid_cards = deck[suit].select { |key, arr| arr.size > 0 }
  return false if !valid_cards
  card = valid_cards.keys.sample
  value = deck[suit][card].sample
  user_hand << deck[suit][card].delete(value)
end

def initial_deal(hsh, user)
  player_hand = hsh[user][:cards]
  while player_hand.size < 2 
    sample_from_deck(hsh, user)
  end
end

def bust?(hsh, user) 
  hsh[user][:cards].sum > 21 == true
end

def twentyone?(hsh, user) 
  hsh[user][:cards].sum == 21
end
test = initialize_twenty_one
#p test # => returns hash
p initial_deal(test, :player)
p initial_deal(test, :dealer)
p test

