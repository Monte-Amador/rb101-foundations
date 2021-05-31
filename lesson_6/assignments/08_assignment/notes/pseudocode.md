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
- [x] LOOP: player inputs 'hit' for new card. 
  - [x] break if player chooses to 'stay' || 'busts'
- [x] VALUES: all cards are standard values face values and 10(jack, queen, king) except ace
- [x] aces equate to 1 or 11 upon context
  - [x] ace = 11 unless total value of array busts, otherwise ace = 1
  - [x] how do we assign the value of ace if we have both values in an array?
- [x] bust = lose
- [x] COMPARE:whoever is closest to 21 without busting = win
- [x] DEALER TURN: decides to hit or stay after player stays
  - [x] dealer must hit until 17 >= total
- [x] not necessarily a bug, but whoever busts wins due to the fact that their total number of cards is higher. need to add additional logic to first test if player busted or won with 21 to begin with.

## Aces Method
first need to think about the aces array as it currently stands, since there is only one ace for each suit it doesn't make sense to have two values inside of the ace to specify 1, 11. 

if we simplify the function, what we are looking for is to assign the default value of any ace to 11 unless the player will bust. If the player will bust the the value for ace is 1.

during the deal, we return the value from a valid_cards array via the select method. the card value is actually sampled from that array that we assign to the valid_cards variable.

- [x] get the total value of current cards[array]
- [x] upon having an ace, ace = 11 unless user_hand of cards > 21; then ace = 1

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
# 21 
what happens when the initial deal deals a player 21? The game isn't over yet, the dealer could have 21 and push. This is what to come back to and map out next.
- [x] initial deal
- [x] count player cards
- [x] if 21 display "21" and move to dealer move
- [x] dealer show hand
- [x] dealer hits or stays
- [x] compare cards and exit hand

## Data organization
currently, we get a list of valid cards by returning an array of all suits keys that haave a size greater than 0 inside the deck of cards hash. 

deck=>suit=>cards[1, 2]

## Hide Dealer first card
1. first card displays as "|X|" or hide completely

2. must not show total for dealer

3. when dealer's turn, re-display dealer's hand to show all cards and total

4. find a way to also display player's cards for comparison (user interface enhancement)

5. Dealer's hand: |X| card

6. Player's Hand: AC(11), FS(7) >>> Total: 12

7. would you like to hit or stay?

8. input

9. clear screen

10. show single card

11. reload total hand display (repeat)


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

- [x] if we inspect the card's value and find that it begins with an 'A' then we know it is an ace.
- [x] if it is an ace, we need to inspect the current total of the player's hand (maybe we already pass that in during the deal) and if the ace(11) will make the player bust, then we re-assign the value of that ace to 1. (needs testing to ensure re-assignment will work since we later pass the value back when we delete it from the original deck)



## Refactor Deal Method
Select a card from the deck of cards which holds it's suit and value and append to the user's hand.

Outlined below is the current state of the deal method broken down into 7 separate functions that can be abstracted into their own methods. The method as a whole works on collecting hash values and creates a temporary container (local to method array) to hold the information that can be later organized and passed to the user's hand of cards which permanently alters the user's hand.

- [x] 1. Assign variables to hash values and method processes that assembled together return an array holding the `new_card` data and append to the `user_hand` array. 

- [x] 2. Select valid cards based on their `array.size values > 0`. This ensures that the arrays are not empty and are therefore a valid option to choose a card from.

- [x] 3. Inspect the card variable to find out if the return value has a necessary two index integer (i.e. `:'10' => card[0] + card[1]`) or not. Return value defaults to `card[0]` otherwise.

- [x] 4. Append all variables into `new_card` array based on order (card, suit, value). 

- [x] 5. Append card and suit variables to string output for display purposes when showing the card that is dealt (without value). 

- [x] 6. If the optional parameter `hide` is an empty array (nothing has been passed into it) then display the individual card upon deal without value attached to the string output.

- [x] 7. return `new_card` array to `user_hand` array. This return will permanently
modify the `user_hand` array.

- [x] test if card_display is an ace and if user will bust with 11. if so, modify ace value's.

- [x] refactor the display_single_card parameter to take the new_card as an argument. Note that the new_card object is a nested array like: [["3", "H", 3]]

- [x] BUG: Aces are working, with the exception that the ace is assigned as an 11 from the deal like it should, it keeps that value through the next hit. So for example, the hand is an ace, 2, and 10 => 13. but instead it counts the initial ace as 11 instead of changing it to a 1.
  - [x] perhaps when totaling the hand to see if a player busts, we take into account if they have a card with a value of 11 (an ace). if with the 11 they bust, reassign the 11 to a 1 and re-total.

## Refactor output for displaying cards with better readability

- [ ] need to make better separation between user turns and dealer turns so that it's visually more clear what is happening. Look at bringing in the prompt method.

- [ ] create heredoc for all visual separation elements like code blocks to inform the user what is happening.

- [ ] Create main loop to keep score and only show the welcome message once. 
- [ ] clear out puts in place of prompts
