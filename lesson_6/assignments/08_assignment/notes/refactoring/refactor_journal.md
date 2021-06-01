- [x] bug: choosing anything allows the game to continue.
- [x] clear screen at beginning 
- [x] remove continuous deck and allow for the reshuffle after every iteration of hand.
- [x] BUG: I'm electing to leave the bug for the higher ranking cards as a preference due to the fact the game is logistically working. I want to focus for now on the non-bug priorities starting with the auto win at 21 from the deal like the bust? actions the end of that particular deal (dealer or palyer). Then move through the refactoring and testing to see if any other bugs show up.
- [x] if player receives 21 at the initial deal, it still asks if the player wants to hit or stay - display 21 message if player gets 21 from deal and go to winner
- [x] have the dealer's new card show up like the player's new card so that we see the card first before updating the hand.
- [x] aces are simply choosing between 1 of the two values in the array. Perhaps all values for aces are 11 but the method can change the value to 1 if the total would equate to a bust with 11. 
- [x] display should be in this order:
  - [x] clear screen
  - [x] display all visible cards for both dealer and player
  - [x] if player stays, we see their cards again but that should be removed as the top of the screen still shows the current hand.
- [x] need to hide the first card of the dealer's hand and not show the total until the compare method shows up 

## refinements
- [ ] Also would be nice to say blackjack if player has a face card and ace upon deal
- [x] would be nice to only dispaly face cards in current format [JD(10)] and display face values with their value and suit [2H(2)]
- [x] Need a way to hide first card from dealer
- [x] make sure we can always see the cards like the ttt board
- [x] BUG: once the dealer's turn begins the screen gets cleared and updates the current hand with the new card
- [x] BUG: because of the way the hash pulls it's sampled data, it looks like
  there's a preference for face cards, but there isn't a preference per se,
it's that there's a sample of the available keys choosing to pick a card within
a suit. Because there are 5 possible types of cards there is a 1 in 5 chance
that the had will include a face value. So that's why it continues to return
higher face cards more than face_value cards.

## Refactor Deal Method Select a card from the deck of cards which holds it's
suit and value and append to the user's hand.  Outlined below is the current
state of the deal method broken down into 7 separate functions that can be
abstracted into their own methods. The method as a whole works on collecting
hash values and creates a temporary container (local to method array) to hold
the information that can be later organized and passed to the user's hand of
cards which permanently alters the user's hand.

- [x] 1. Assign variables to hash values and method processes that assembled
  together return an array holding the `new_card` data and append to the
`user_hand` array. 
- [x] 2. Select valid cards based on their `array.size values > 0`. This
  ensures that the arrays are not empty and are therefore a valid option to
choose a card from.
- [x] 3. Inspect the card variable to find out if the return value has a
  necessary two index integer (i.e. `:'10' => card[0] + card[1]`) or not.
Return value defaults to `card[0]` otherwise.
- [x] 4. Append all variables into `new_card` array based on order (card, suit,
  value).
- [x] 5. Append card and suit variables to string output for display purposes
  when showing the card that is dealt (without value). 
- [x] 6. If the optional parameter `hide` is an empty array (nothing has been
  passed into it) then display the individual card upon deal without value
attached to the string output.
- [x] 7. return `new_card` array to `user_hand` array. This return will
  permanently modify the `user_hand` array.
- [x] test if card_display is an ace and if user will bust with 11. if so,
  modify ace value's.
- [x] refactor the display_single_card parameter to take the new_card as an
  argument. Note that the new_card object is a nested array like: [["3", "H",
3]]
- [x] BUG: Aces are working, with the exception that the ace is assigned as an
  11 from the deal like it should, it keeps that value through the next hit. So
for example, the hand is an ace, 2, and 10 => 13. but instead it counts the
initial ace as 11 instead of changing it to a 1.
  - [x] perhaps when totaling the hand to see if a player busts, we take into
    account if they have a card with a value of 11 (an ace). if with the 11
they bust, reassign the 11 to a 1 and re-total.

## Refactor output for displaying cards with better readability

- [x] need to make better separation between user turns and dealer turns so
  that it's visually more clear what is happening. Look at bringing in the
prompt method.
- [x] create heredoc for all visual separation elements like code blocks to
  inform the user what is happening.
- [x] Create main loop to keep score and only show the welcome message once. 
- [x] clear out puts in place of prompts
- [x] if player busts, dealer's hand shouldn't be shown 
- [x] More separation for Match Score, think of putting that into the same header display. In fact, perhaps we pass an argument like the prompt works into the header display. That would alleviate the need for manually customizing the header everytime and create some consistency too.
- [x] Add closing message
- [ ] Add basic rules?
- [x] BUG: if dealer busts, all cards should be displayed with total
- [x] BUG: display_banner method seems to be returning an extra line
- [x]  Cleaned up display by adding display_banner method that takes the input and creates a visual block to inform user what is happening.
- [x] change last message verification to exit game entirely
- [ ] input validation

