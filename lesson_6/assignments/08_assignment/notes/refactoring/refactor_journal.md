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
- [x] BUG: if dealer busts, all cards should be displayed with total
- [x] BUG: display_banner method seems to be returning an extra line
- [x]  Cleaned up display by adding display_banner method that takes the input and creates a visual block to inform user what is happening.
- [x] change last message verification to exit game entirely
- [x] input validation
- [x] keep an eye on the ace in the dealer's initial hand, it should be showing up as 1/11 

- [ ] look at renaming the display_initial_hands method as it is the only one being called during the player_turn method. It might be a bit confusing since we continue looping back to it so it's not really the initial hands by the second iteration, it will display the modified hand.

## Caching the total

within the main loop we can call the current values of both the dealer and player in their own variables and pass them as arguments that need to have acccess to them. This is an advantage for performance and just good natural hygiene when refactoring. Note that these _outer_ variables will be updated permanently from the inner iterations that happen for each user's turn, and even have their updated values passed back while still in the loop.

In this situation, each of the methods listed below use the exact same approach to finding their totals within each method. This is a great way to inspect repetitive uses. By each method, I explain how that method uses each total so that we can look at whether or not a caching solution would be the best approach.

1. `display_user_cards` contains a string that uses an internal total array. This method provides an output of the user cards and their respective total for the user to have a handy count available. If it is not the user's turn, caching the total output would be ideal making this a great candidate for the caching approach. 
- note that this method is already user agnostic, it should be used when wanting to show all cards for each user and includes the total as well. Knowing this and with the idea of creating the outer loop cached variables that can be manipulated from within the inner user's turn loop, we can remove the need to call on totalling the sum within this method and instead pass in the cached variable as an argument 
  - The values of the user's hand will also change depending on if the user has an ace and how that player decides to proceed with the hand (hit or stay).

will_user_bust? uses a total array within the method to return a boolean indicating whether the current hand of the user is greater than or equal to 11. this method would benefit from a caching total passed in as an argument as it is only used within the deal method when checking for an ace. 

hold_on_seventeen uses the same approach as the will_user_bust? method however it does not return a boolean value. This would also benefit from the caching total being passed into the method as an argument. 

bust? By invoking the actual total method within the user's turn method, we assign the local variable (to the outer loop) from within the inner loop (user's turn iteration). Because we pass the cached total as an argument, we are getting the _live_ value upon each iteration as long as we ask for the total _after_ we have modified it. regarding the extra login within the bust? method, as long as we also inspect the cards's value to return the total.include?(11) method call when reassignment of the ace is in order. 

twentyone? also uses the same approach as the bust? method in how it uses its own internal array, and is a perfect candidate

Depending on where we assign the caching variable will depend on how it is used. For instance, since we know we need a way to live update the total during a deal for each user, we could assign the local variable (located in the main loop outside of the user's method loops?) that get's updated upon each iteration through the user's hand. One drawback is that we are continuously calling the total during that method, however it's only one place and it's in the place where we actually need it to be. 
  - the test is how to permanently change the outer variable and still use it (as an argument) when the loop goes through another iteration.
- so that works simply by looping through and adding the output to the total array on each turn.

total_value_cards it is worth thinking about using this as the master total method that we can use for caching purposes. Though note it does not return a sum. Instead it returns an array of the values(int) within the players cards. This array is then passed to the compare_hands method and the Array#sum function is invoked on the arrays there. Some tweaking will be necessary to return a simple sum for display purposes.

Walkthrough:

- [x] initiate cache objects to the player's hash as their own key/value pairs
- [x] each cache object holds a single array
  - [x] each single array will contain a single integer that can be mutated
- [x] pass cache objects to each user turn
  x bust?(hsh, user, total) # update all occurences
    - dealer_turn
    x someone_busted
      x display_bust
  x twentyone?(total) # update all occurences
    x dispaly_user_cards(hsh, :player, num)# update all occurences
    x display_all_cards(hsh, num)# update all occurences, ahh.. yes this method needs to be able to take 2 different parameters. However since we are alreday passign the hash as a parameter, we can just assign that from within and need not pass the `num` parameter
  x hit(hsh, user, total)# update all occurences
    x deal(hsh, user, num)# update all occurences
      x will_user_bust?(num)# update all occurences
  x initial_deal (amend method to assign local variables to the method for the total values of each player).
- [x] each user turn is an iteration where they can receive a new card or stay.
- [x] each iteration begins with an inspection to see if the user has reached 21 or has busted.
- [x] if neither of those conditions have been met, we continue to iterate (note that the single array can return an integer without calling the index if you add the Array#sum method to the array. I have done this on the player's turn line 370
- [x] each iteration gives the user a choice to hit or stay
  - [x] if a user hits, that invokes the deal method that will assign a random card to the user with a new value.
  - [x] if the user stays, we exit the iteration and move to the next user (if there is one, otherwise we wrap up the hand).
- [x] if a user receives a new card, the new card's value will change the cached object that needs to be updated before the next iteration. 
  - [x] the new_card array holds the value of the new card in index [2].
  - [x] new_card[2] needs to add to and reassign the value in the cached object before the next call to iterate with the user's turn.

x. deal cards => initial_deal
x. count cards => initial_count #create
3. player turn => player_turn
4. update count => deal
5. dealer turn => dealer_turn
6. update count => deal
7. compare counts => inspect
- [x] when player busts, dealer still gets turn
- [x] initial total is working, but doesn't update
- [ ] the ace reassignment is working, but for some reason the dealer stopped at 12 when it should have continued 
- [ ] The reassignment of the ace object when the dealer is about to bust works by inspecting the values of the dealer's cards and if it finds any 11s and the dealer is about to bust, it will change in place the value of the 11 to 1. This will keep the dealer from busting and it updates the score correctly as well as the card values, however the total value seems not to be getting updated until the next iteration after the hit, which makes sense as it was designed this way. 
::LEFT-OFF:: Look at with fresh eyes and make the change necessary not to have multiple calls to the method

1. get the current total and cache the object
2. break if player busted earlier
3. clear the screen
4. display the user's turn
5. display all user's cards
6. break if total >= 17
7. hit
8. reassign the total (with this it works)
9. break fi bust or twentyone 

- [ ] still getting the will_user_bust? error as it looks like the num is coming in as an array... sometimes. it's looking like it may be during the deal method calling of will_user_bust? while I'm passing in the initial empty array and it gets triggered when an ace is on deck maybe?
- [ ] minimize all the total methods that are creeping up
- [ ] add back the 21 announcement for the player
- [x] create total(user) method or assign accordingly

maybe discovered a way to go about the massive amount of variable declaration, perhaps it's worth testing to see if I can create a hash to hold all of them and just include the hash as a parameter?

- [ ] 1. variables are assigned in main loop
- [ ] 2. variables are passed into each user turn for modificaation
- [ ] 3. user turns mutates the outer scoped cached variables by invoking the total_value_cards method. Inside the user turn method we also pass to the following three methods:
  - [ ] bust?
  - [ ] twentyone?
  - [ ] will_user_bust
  - [ ] display_user_cards 

- [ ] 4. caches used in inspect_hands(hsh, player, dealer, score) method
  a. someone_busted(hsh) => bust?(hsh, player)
  b. display_bust(someone_busted(hsh), score, hsh)
  c. compare_hands(hsh, dealer, player, score)
  d. display_all_cards(hsh) => display_user_cards

- [ ] refactor note: one thing I am noticiing is the lack of consistency between calling an ideal single total parameter for the particular user, and other methods that require the use of two separate parameters because of the need for both totals (e.g. dealer_turn => display_all_cards(hsh, p_total, d_total). I'd love to just pass the parameter of total as either an array with both cached variables or a single value. It's too hard to maintain this current way.
- [ ] need two separate totals in:
  - [ ] inspect_hands
  - [ ] compare_hands
  - [ ] display_all_cards

## one turn for both user? It looks as if you can use the hold_on_senveteen method by using a one liner if statement if the user is :dealer

DEBUG:
- [ ] hit gave an ace worth 11 instead of 1. It should have reassigned it so that means the will_user_bust or ace? methods didn't perform correctly.
- [ ] further inspection shows that the outer variables are not updating.
- [ ] this is happening because you can't modify the outer variables from within the method, presumably because they are integers and not strings. A trip to irb will help this. Integers are immutable. That's that... now I need to refactor the caching objects to be arrays.
