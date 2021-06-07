SUITS_ARRAY = [:hearts, :clubs, :spades, :diamonds]
FACE_CARDS = [:jack, :queen, :king, :ace]

def init_twentyone(user1, user2)
 { 
    "#{user1}": { cards: [], hand_total: [0] },
    "#{user2}": { cards: [], hand_total: [0] }, 
    deck: init_suits(SUITS_ARRAY)
 }
end

def init_suits(array)
  suits = array.each_with_object({}) do |item, hash|
    hash[item] = init_cards(FACE_CARDS)
  end
end

def init_cards(arr)
  cards = (2..10).each_with_object({}) do |num, hash|
    hash[:"#{num}"] = [num]
  end
  arr.each do |card|
    if card != :ace
      cards[:"#{card}"] = [10]
    else
      cards[:"#{card}"] = [11]
    end
  end
  {cards: cards}
end

puts init_twentyone('dealer', 'player')
