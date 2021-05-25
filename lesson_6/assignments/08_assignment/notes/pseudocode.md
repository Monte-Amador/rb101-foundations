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
- [x] 21 > bust
- [x] INITIAL_DEAL: both player and dealer receive 2 cards each
  - [ ] player can view both cards, but only one card(first) from dealer
- [ ] LOOP: player inputs 'hit' for new card. 
  - [ ] break if player chooses to 'stay' || 'busts'
- [x] VALUES: all cards are standard values face values and 10(jack, queen, king) except ace
- [x] aces equate to 1 or 11 upon context
  - [x] ace = 11 unless total value of array busts, otherwise ace = 1
  - [x] how do we assign the value of ace if we have both values in an array?
- [x] bust = lose
- [ ] COMPARE:whoever is closest to 21 without busting = win
- [ ] DEALER TURN: decides to hit or stay after player stays
  - [ ] dealer must hit until 17 >= total
- [ ] not necessarily a bug, but whoever busts wins due to the fact that their total number of cards is higher. need to add additional logic to first test if player busted or won with 21 to begin with.
  - [ ] wire up the detect_winner and bust? methods after every deal. If user won (21) or busted (> 21) exit the hand and declare winner. With a two player game we don't need any further dealing to other players.
  - [ ] got it wired up but is is messy. ::LEFT-OFF:: start from cleaning up the logic and abstracting to simpler methods.
  - [ ] if we make the optional parameter in the display_hand method, we can access the users as needed from the array that gets passed. E.g passing :player as an argument to an optional parameter returns the argument inside of an array [:player]. So we can pass that to the hash inside the method when we state it like: hsh[arr[0].to_sym] which turns the argument into a symbol.
## Coding up the Ace Method
- [ ] get the total value of current cards[array]
- [ ] upon having an ace, ace = 11 unless user_hand of cards > 21; then ace = 1

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
  - if user is dealer, hold on 17 and greater => dealer_hit_or_stay(hsh,user)
  - if user is player, need to invoke ask_hit_or_stay method
    - (future thought: nice to have the option to choose who is dealer)

## Coding up the deal method
We can set the variables as deck, suit, card and value in a method that first clears them if there are any values and then re-assigns them (as well as delete from the main hash) to their respective variables. We can then chain the variables together to target the specific value and modify the hash.

While working with the concept within the sample_from_deck method below, I came to an issue regarding the ace,jack,queen and king cards. Although it was simple enough to sample and remove the value while passing it to the user's hand, what would happen if the card that was chosen had an empty array (as it had already been chosen). That first came to mind because it's easy enough to use Hash#delete to remove the key,value pair, but we dont' want to do that if there are more values from the same key as is the case with the face_cards. So the idea now is iterate using the Hash#select method and pass through the criteria to select only those key,value pairs that have an array with a size greater than zero. This will return a new hash from which we can use to pick the card from, knowing it has at least one item in it's value to pass over to the user. Within the method, we can assign this new returned hash to a variable and have the card sample the keys from that method. Then we go ahead and continue on with the method assigning a value to append to the users hand and remove the same value from the original hash.

The below pseudocode is working in part. I need to return and start testing from this initial place. One think I'm noticing however, is that it would be good to have the card show up along with the value. Right now, for example hsh[:player][:cards] returns an array of their value like so: [10, 11] but it would be ideal to have it look like [['K', 10], ['A', 11]] in order to be able to flatten them when looking at the user's cards. Yet we can still add up the sum of the value by targeting the inner arrays since their integers would always be in inner array[1].

## Example Desired Output 
what we want here is for the cards hash to return an array with the card and it's value? Or rather the suit and the card would be better. We could hold their values in a separate array so we can work accordingly by returning the sum of the arrays. So we ultimately want the output to look something like Clubs: Jack 10. It's just an example for now so think about the desired output and work backwards. If we instead wanted the final values displayed as the card and the value, no nevermind that won't work as it would get confusing seeing the value along side of the face_value cards. 2 might look like 22. but this does pose the possibility of displaying the current total for the user to have so they know exactly where they are standing.

start working out the way to achieve the preferred output below
After having fixed the sample_from_deck behavior, now we'll turn our focus to the output. I know that I would like to have something along the lines of Suit, Card(s) and a rolling total like this: 

    D-J(10), S-2(2) >>> Total: 12
in the cards array we can specify the objects within their own arrays (nested) as the cards value. A first approach for each card within the parent :cards array:

:cards=> [[suit[0], card[1], value[2]]]

and we can total up the value of each by totaling each nested array[2] to arrive at a hand total like so:

[:cards][0][2]

we'll need to iterate through the [:cards] parent array and retrieve all the values from their respective positions. Thinking this through, providing a Array#select method would work as it would return an array with truthy values that can be denoted by being an integer or just calling the integer's position

_Upon first looks with fresh eyes it also looks like I can make use of the joiner method I wrote with [ttt_bonus_features.rb](file:///Users/monte/Projects/launch-school/rb101-programming-foundations/lesson_6/assignments/07_assignment/ttt_bonus_features.rb) when thinking of how to customize the output where necessary_

## Bust || 21
- [x] work out the bust? and twentyone? methods so that we can wire up the hit method.

## Aces

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

## May 24, 2021 Changes
- change hash values from face_cards to face_values, added methods clear_screen, display_hands for more clear user interface. 
- Debug and refactor display_cards method to include custom output string (need to abstract extra logic into new method). i
- Deal method has a new approach (not yet integrated) to show the new single card dealt to user. 
- debug bust? and twentyone? methods. 
- Creation of match loop and hand loop for the implementation of score keeping
  also allows us to use one deck during a round (if necessary).

## refinements
- [ ] Also would be nice to say blackjack if player has a face card and ace upon deal
- [ ] would be nice to only dispaly face cards in current format [JD(10)] and display face values with their value and suit [2H(2)]
- [ ] Need a way to hide first card from dealer
- [ ] make sure we can always see the cards like the ttt board

## Blog post
there's a sense of wonder now that the road blocks have gotten fewer and further between. I remember when i started the prepatory course and I could just sit there unawares of what I had just learned. I questioned many times whether i could stick through it as I continually felt lost. That's the bulk of how i went to bed every night for the 8 weeks it took me to finish. 

Now, I feel like this sense of wonder is sstarting to grow some serious tendrils and I have no idea what to expect. But I so enjoy the process I can't wait to see this fly. I feel like... the music sounds better with you[video]

Lately, I am starting to feel the wonder of that boy in the video. So excited, dedicated, jamming, a little nervous but more than anything, wonder.
