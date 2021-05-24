# Pseudo-code for 21

## Data Structure V1
Let's start with a data structure of a hash, it can hold both the dealer and player objects as separate hashes as well as hold all 52 cards in relation to their respective suits as nested hashes or arrays or a combination of both (example structure):

```ruby
hsh = { 
  dealer: { cards: [], score: '' },
  player: { cards: [], score: '' },
  suits = {
    hearts: {
    ace: [1, 11], 
    jack: 10,
    queen: 10,
    king: 10,
    face_values: [2, 3, 4, 5, 6, 7, 8, 9, 10]
    } 
  }
}

Because each user (player, dealer) will first be dealt two cards, we can keep all cards in their own array. That way the initial deal will always refer to the respective player's `:cards[0]` and `:cards[1]`. this also helps when we want to sum up user's hands as we can run Array#sum for the array.

We can also run the `Array#sample` method on the specified :deck hashes and their arrays to retrieve a random integer and run `hsh.keys.sample` and `hsh.values.sample` to retrieve random key/value pairs when necessary.

## Implementation Steps
1. INITIALIZE: Deck
2. Deal cards to player and dealer
3. PLAYER TURN: choose to hit or stay
  - REPEAT: until bust or stay
4. IF: player busts, dealer wins
5. DEALER TURN: choose to hit or stay
  - dealer must hit until total >= 17
6. IF: dealer busts, player wins
7. COMPARE: cards and declare winner

## Operations
- [ ] 21 > bust
- [ ] INITIAL_DEAL: both player and dealer receive 2 cards each
  - [ ] player can view both cards, but only one card(first) from dealer
- [ ] LOOP: player inputs 'hit' for new card. 
  - [ ] break if player chooses to 'stay' || 'busts'
- [ ] VALUES: all cards are standard values face values and 10(jack, queen, king) except ace
- [x] aces equate to 1 or 11 upon context
  - [x] ace = 11 unless total value of array busts, otherwise ace = 1
  - [x] how do we assign the value of ace if we have both values in an array?
- [ ] bust = lose
- [ ] COMPARE:whoever is closest to 21 without busting = win
- [ ] DEALER TURN: decides to hit or stay after player stays
  - [ ] dealer must hit until 17 >= total

## Coding up the Ace Method
- get the total value of current cards[array]
- upon having an ace, ace = 11 unless user_hand of cards > 21; then ace = 1

def aces(user, ace_arr)
  example = hsh[:diamonds][:ace] # => [1, 11]
  user_hand = hsh[user][:cards] # => array
  # get total of user_array
  if user_hand.sum >= 11
    ace_arr[0]
  else
    ace_arr[1]
  end
end

## Coding up the player turn
- ideal to have one generic method that iterates from the player to the dealer.
  - need a conditional to test which user is up (player/dealer) and choose method based on that
  - each user will need the ability to hit (invokes method)
  - if user is dealer, hold on 17 and greater
  - if user is player, need to invoke input 
    - (future thought: nice to have the option to choose who is dealer)

def player_turn(hsh, user)
  player_hand = hsh[user][:cards] # => array
  loop do
    puts ask_hit_or_stay
    reply = gets.chomp # valid_choices: ['h', 's']
    hit if reply == 'h' # => return hash {ace: [1, 11]]
    if hit == [1, 11]
      aces(user, ace_arr) 
    else
      hit
    end
    break if reply == 's'
    break if bust? || twentyone?
  end
end

## Coding up the deal method
We can set the variables as deck, suit, card and value in a method that first clears them if there are any values and then re-assigns them (as well as delete from the main hash) to their respective variables. We can then chain the variables together to target the specific value and modify the hash.

While working with the concept within the sample_from_deck method below, I came to an issue regarding the ace,jack,queen and king cards. Although it was simple enough to sample and remove the value while passing it to the user's hand, what would happen if the card that was chosen had an empty array (as it had already been chosen). That first came to mind because it's easy enough to use Hash#delete to remove the key,value pair, but we dont' want to do that if there are more values from the same key as is the case with the face_cards. So the idea now is iterate using the Hash#select method and pass through the criteria to select only those key,value pairs that have an array with a size greater than zero. This will return a new hash from which we can use to pick the card from, knowing it has at least one item in it's value to pass over to the user. Within the method, we can assign this new returned hash to a variable and have the card sample the keys from that method. Then we go ahead and continue on with the method assigning a value to append to the users hand and remove the same value from the original hash.

The below pseudocode is working in part. I need to return and start testing from this initial place. One think I'm noticing however, is that it would be good to have the card show up along with the value. Right now, for example hsh[:player][:cards] returns an array of their value like so: [10, 11] but it would be ideal to have it look like [['K', 10], ['A', 11]] in order to be able to flatten them when looking at the user's cards. Yet we can still add up the sum of the value by targeting the inner arrays since their integers would always be in inner array[1].

## Example Desired Output ::LEFT-OFF:: 
what we want here is for the cards hash to return an array with the card and it's value? Or rather the suit and the card would be better. We could hold their values in a separate array so we can work accordingly by returning the sum of the arrays. So we ultimately want the output to look something like Clubs: Jack 10. It's just an example for now so think about the desired output and work backwards. If we instead wanted the final values displayed as the card and the value, no nevermind that won't work as it would get confusing seeing the value along side of the face_value cards. 2 might look like 22. but this does pose the possibility of displaying the current total for the user to have so they know exactly where they are standing.

::LEFT-OFF:: start working out the way to achieve the preferred output below
After having fixed the sample_from_deck behavior, now we'll turn our focus to the output. I know that I would like to have something along the lines of Suit, Card(s) and a rolling total like this: 

    D-J(10), S-2(2) => Total: 12
in the cards array we can specify the objects within their own nested array as the :cards value [ [suit[0], card[1], value[2]] ]and we can total up the value of each by totaling each nested array[2] to arrive at a hand total.

## Next up get total
work out the bust? and twentyone? methods so that we can wire up the hit method.

def initialize_twenty_one(hsh)
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
  # check to make sure the values are being cleared upon every call for the method
  deck = hsh[:deck]
  suit = deck.keys.sample
  valid_cards = deck[suit].select { |key, arr| arr.size > 0 }
  return false if !valid_cards
  card = valid_cards.keys.sample
  value = deck[suit][card].sample
  deck[suit][card].delete(value)
  user_hand << value if value
  user_hand
end

def initial_deal(hsh, player, dealer)
  player_hand = hsh[player][:cards]
  dealer_hand = hsh[dealer][:cards]
  while player_hand.size < 2 
    player_hand << sample_from_deck(hsh, player)
  end
  while dealer_hand.size < 2 
    dealer_hand << sample_from_deck(hsh, dealer)
  end
end

def bust?(hsh, user) 
  if hsh[user][:cards].sum > 21 == true
end

def twentyone?(hsh, user) 
  if hsh[user][:cards].sum == 21
end

## Blog post
there's a sense of wonder now that the road blocks have gotten fewer and further between. I remember when i started the prepatory course and I could just sit there unawares of what I had just learned. I questioned many times whether i could stick through it as I continually felt lost. That's the bulk of how i went to bed every night for the 8 weeks it took me to finish. 

Now, I feel like this sense of wonder is sstarting to grow some serious tendrils and I have no idea what to expect. But I so enjoy the process I can't wait to see this fly. I feel like... the music sounds better with you[video]

Lately, I am starting to feel the wonder of that boy in the video. So excited, dedicated, jamming, a little nervous but more than anything, wonder.
