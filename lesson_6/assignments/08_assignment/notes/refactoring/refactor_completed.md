# COMPLETED REFACTORS
note that the below _order_ is in context of building the game and is here for archiving purposes. It is not in a step-by-step approach for the most part. Just a place to create notes on the fly when I was focusing on something else and discovered something I wanted to pin for later.


## refinements
- [x] there's a preference for face cards, but there isn't a preference per se, it's that there's a sample of the available keys choosing to pick a card within a suit. Because there are 5 possible types of cards there is a 1 in 5 chance that the had will include a face value. So that's why it continues to return higher face cards more than face_value cards.

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
- [x] would be nice to only dispaly face cards in current format [JD(10)] and display face values with their value and suit [2H(2)]
- [x] Need a way to hide first card from dealer
- [x] make sure we can always see the cards like the ttt board
- [x] BUG: once the dealer's turn begins the screen gets cleared and updates the current hand with the new card
- [x] BUG: because of the way the hash pulls it's sampled data, it looks like
- [x] 1. Assign variables to hash values and method processes that assembled
- [x] 2. Select valid cards based on their `array.size values > 0`. This
- [x] 3. Inspect the card variable to find out if the return value has a
- [x] 4. Append all variables into `new_card` array based on order (card, suit,
- [x] 5. Append card and suit variables to string output for display purposes
- [x] 6. If the optional parameter `hide` is an empty array (nothing has been
- [x] 7. return `new_card` array to `user_hand` array. This return will
- [x] test if card_display is an ace and if user will bust with 11. if so,
- [x] refactor the display_single_card parameter to take the new_card as an
- [x] BUG: Aces are working, with the exception that the ace is assigned as an
  - [x] perhaps when totaling the hand to see if a player busts, we take into
- [x] need to make better separation between user turns and dealer turns so
- [x] create heredoc for all visual separation elements like code blocks to
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
- [x] initiate cache objects to the player's hash as their own key/value pairs
- [x] each cache object holds a single array
  - [x] each single array will contain a single integer that can be mutated
- [x] pass cache objects to each user turn
- [x] each user turn is an iteration where they can receive a new card or stay.
- [x] each iteration begins with an inspection to see if the user has reached 21 or has busted.
- [x] if neither of those conditions have been met, we continue to iterate (note that the single array can return an integer without calling the index if you add the Array#sum method to the array. I have done this on the player's turn line 370
- [x] each iteration gives the user a choice to hit or stay
  - [x] if a user hits, that invokes the deal method that will assign a random card to the user with a new value.
  - [x] if the user stays, we exit the iteration and move to the next user (if there is one, otherwise we wrap up the hand).
- [x] if a user receives a new card, the new card's value will change the cached object that needs to be updated before the next iteration. 
  - [x] the new_card array holds the value of the new card in index [2].
  - [x] new_card[2] needs to add to and reassign the value in the cached object before the next call to iterate with the user's turn.
- [x] when player busts, dealer still gets turn
- [x] initial total is working, but doesn't update
- [x] rename num to cached_total
- [x] someone_busted >> who_busted
- [x] after reaching 5, the game should exit out instead of having to hit return
- [x] create total(user) method or assign accordingly

## Creation of single user_turn method

- [x] build out singular user turn and pass the dealer and player in as their own arguments that will call upon their respective methods (need to come up with them by abstracting the current player and dealer_turn methods respectively).
  - [x] dealer's break is at the bottom of the method. What is the side effect of calling it at the top? Since it's in a loop, it should be the same as the final break immediately moves to the next iteration of the loop. Now that I know the cached object is working as expected, it should be fine.
  - [x] refactoring the player_turn method to incorporate the cached object works with moving the break bust? method to the bottom of the loop.
  - [x] it looks like the user_turn method doesn't need to have its own loop if we provide that within the specific user's method. This helps with the break values too. 
  - [x] Although the previous note about not creating another loop within the user_turn method, that's not the right decision for me because what I'm after is a single loop from which we can input the individual parts of the player and dealer methods as the hands move forward.
  - [x] DEBUG: I orginally had the right idea of inspecting the return value from the player_turn method and if it equated to a specific string then it should break the loop. The logic worked but I appended the conditiaonal inspection along with the other two (bust? and twentyone?) conditions. This meant that the player_turn method was getting called twice. The solution was to move the break condition into the method call itself so that the break condition inspecting the method would call the method. This worked.
    - [x] the solution was to move the break condition to the method call so that we can test the return value upon each iteration. The side effect of this is that it no longer specifies that the user decided to stay. This can be a line of text that is printed to the screen from within the method before it returns 'stay'
  - [x] Moving onto refactoring the dealer portion of the user_turn. In looking at the inner break condition of the original method, I had it setup explicitely to break the dealer_turn loop if hold_on_seventeen returned something. Following the player_turn approach to breaking out of the user_turn loop, we might be able to simply break out of the loop if the return value is the cached_total at this point.
- [x] just noted that the player is being asked to stay when they have 21, when it should be breaking. Perhaps this is why it's better to move the break methods to the top of the loop iteration inside the user_turn method. Moving it to the top created an 'undefind local variable or method 'total_arr' error on line 399
- [x] need to acknowledge when the user chooses to stay and pause
- [x] dealer header missing on dealer turn
- [x] Bug: dealer not holding on seventeen
- [x] still getting the will_user_bust? error as it looks like the num is coming in as an array... sometimes. it's looking like it may be during the deal method calling of will_user_bust? while I'm passing in the initial empty array and it gets triggered when an ace is on deck maybe?
- [x] hit gave an ace worth 11 instead of 1. It should have reassigned it so that means the will_user_bust or ace? methods didn't perform correctly.
- [x] further inspection shows that the outer variables are not updating.
- [x] this is happening because you can't modify the outer variables from within the method, presumably because they are integers and not strings. A trip to irb will help this. Integers are immutable. That's that... now I need to refactor the caching objects to be arrays.

## ACE REASSIGNMENT INITIAL DEBUG NOTES:
### Documenting the lesson of variable assignments
- [x] the ace reassignment is working, but for some reason the dealer stopped at 12 when it should have continued 
- [x] The reassignment of the ace object when the dealer is about to bust works by inspecting the values of the dealer's cards and if it finds any 11s and the dealer is about to bust, it will change in place the value of the 11 to 1. This will keep the dealer from busting and it updates the score correctly as well as the card values, however the total value seems not to be getting updated until the next iteration after the hit, which makes sense as it was designed this way. 

1. get the current total and cache the object (passed to inner methods: hold_on_seventeeen(total), hit(hsh, user, total), bust?(hsh, user, total) and twentyone?(total) )
2. break if player busted earlier
3. clear the screen
4. display the user's turn
5. display all user's cards
6. break if total >= 17
7. hit
8. reassign the total (with this it works)
9. break fi bust or twentyone 

numbers 8 and 9 are where I am getting confused so let's take a look a little
deeper here. Prior to 8, we have the total that is updated at the beginning of
every iteration and passes `total` to the hold_on_seventeen, hit(for testing if
a user gets 21) and then at the end bust(to test the total against being over
21) and then finally to the twentyone? method as a way to test if the user is
at 21.

That all works fine, with the exception as to when a user looks like
they will bust because the bust method calls it and then inspects the user's
hand to see if they have an 11 that can be reassigned to a 1 since it is an
ace. If it does, then the 11 gets reassigned to 1 and the method returns false.
However, it is at that point where we go to the next iteration and that
total(cached object) is still holding the last value it had with the 11 instead
of the 1. this is what is triggering the hold_on_seventeen(total) even though
everything else is showing the correct value. So the problem lies in the cache
object not being updated after the hit (though it does in the deal method at
the end) and before the bust method sets itself up to reassign the variable.

I just ran a test inside of irb and found that declaring a cached object within
a loop will update as hoped for. the next test is to add a method inside of the
loop to update the outer hash and see if the irb loop continues to update
accordingly. Probably better at this point to move it all to a test file.

As hoped for, I was able to mutate the hash's value permanently and the cached_object was able to continue using the updated value while inside of the loop. So the value isn't getting updated at the end of the deal as previously thought it seems.

OKAY, I GOT THE BUG! it looks like the issue was because the assignment of the `total` variable wasn't referencing the actual value from the hash `hsh[user][:hand_total]` where the cached object lived, it was referencing that object with the Array#sum method chained onto the return value in order to modify the return value as a straight integer, in other words, an entirely different object.id.  I never noticed this in the player_turn method because there was no break unless the user did actually bust, stay or score 21. This became more obscure because the bust? method was correct in testing the total against any aces and re-assigning the value of the ace, however that cached object didn't update until the next iteration in the loop, which worked out in this case 

This meant that after a hit the hand would increase correctly, but inside the dealer_turn loop, the `total` was still referencing a different object that looked like it was the same thing. That's what was passed onto the bust method and that's why it wouldn't get reassigned correctly until the next iteration which did reassign the total correctly at the beginning of the loop but if in the case it was a bust, we didn't check that until the hold_on_seventeen method was finished checking, and in this case breaking so the ace reassignement that is triggered from the bust? method wouldn't catch the ace and reassign the value and update the total until the very end of the loop --- due to the break for bust being at the end of the loop iteration.

In other words, the variable wasn't pointing to the same place in memory as it was pointing to the _sum_ of the same place in memory that meant it was pointing to a different object altogether. This is an important slip up and one that took a couple days of debugging to finally understand exactly what was happening. The fix was to remove that assignemnt to the sum version of the array I was referencing and in this case, just handing the variable that acutally returns (correctly) the array from the :hand_total and chaining the Array#sum method to that. That, in effect would create and pass the cached object as simple integer that would _only_ get updated when the hash's array was permanently modified. why didn't i just use an integer instead of an array to work with and not have to append the Array#sum method over and over? Well, integers are immutable and I needed to be able to modify and update the value of the user's hand upon every deal of cards. To keep it all together I'll change the player_turn method to reflect this since I'm idealling going to marry both methods into one with only their distinct logic parts abstracted into theri individual methods.

## Refactor Deal Method 
Select a card from the deck of cards that holds it's suit and value and append to the user's hand. Outlined below is the current state of the deal method broken down into 7 separate functions that can be abstracted into their own methods. 

The deal_method as a whole works on collecting
hash values and creates a temporary container (local to method array) to hold
the information that can be later organized and passed to the user's hand of
cards which permanently alters the user's hand and total value of cards.

- [x] return an array holding the `new_card` data and append to the `user_hand` array. 
- [x] ensure that all arrays from are not empty and are therefore a valid option to choose a card from.
- [x] there is one edge case with return values, the method returns one character from the card (e.g. A for ace, 9, for 9, but 1 for 10 doesn't work) so it's necessary to return a two index integer (i.e. `:'10' => card[0] + card[1]`) or the Return value defaults to `card[0]` otherwise.
- [x] permanently modify the `user_hand` array by appending the new card array to the user's `cards` array. The value of `hsh[:player][:cards] => [['3', 'H', 3], ['10', 'C', 10], ['6', 'S', 6]]`
- [x] modify ace value. we have to set a default value of 11 for the ace, but if the user will bust, the ace's value should be changed to a `1` ensuring that the ace can represent either 1 or 11 respectively.

## Caching the total
Note that the process of understanding the problem deeply in this situation was a very steep learning curve and a good excercise in being humbled. I write about the process itself below this part where I explain my solution first:

## My solution
I wanted to call the method that totals up the calculation as few times as possible. Because I am already using a hash as my data structure for the game, it made sense to add separate key, value pair where I would create a key for the cached_object titled `:hand_total` and the value woudl be an array with an intialized value of 0.

Beginning with the initial deal, we invoke the initial_count method and this does the calculation from each user's set of cards once and modifies the cached_object to reflect the user's grand total of current cards. 

After the initial_count we move into the play_round method that consists of first the player's turn and then the dealer's turn. Both of these invoke a hit method that invokes the deal_method. 

The deal_method is the method where access the cached_obeject and store it to use throughout the method's invocations. At one point in the deal method, we inspect the card to see if it is an ace, and if the user will bust if we pass the default value of 11 to the ace. It is here we use the cached_object to inspect the user's total and see if we need to modify the new ace's value that we are dealing. 

After this, we next modify the cached_object upon appending the new_card to the user's cards array. Finally, in the deal method we also return a statement if the user reached 21 during the deal.

> I like this way of creating a cached object as it resides in a data structure I already have but most importantly, it's easy to modify where needed and the cached object is passed correctly throughout the game since it is referencing the array. Any time I need to pass the total of that array to a method as an integer, I can simply chain the Array#sum method to it.

Once we go through the deal method, we are already inside a loop that inspects the user's hands at the beginning of each iteration because I wanted a way to make sure that if the player was dealt a 21 in the intial deal, we could break over to the dealer's attempt at a push. It's in the inspection of the bust? method that I reassigned the ace when needed. 

Inside the bust? method, there's a conditional that tests the cached_total value against whether or not any cards in the user's hand is an 11 (ace) and if it is run the reassign_ace! method and then return false so that the bust? method doesn't return true. 

Inside the reassign_ace! method, we iterate through each nested array of the user's hand and look for values of 11, then reassign that to 1. It is after that iteration tha we re-total the hand by modifying it's value -10 to account for the change from 11 to 1. I think a more elegant solution was to re-total the cards with the initial total method however I wanted to see how far I could take the cached_object. 

In the end I was able to use and update the cached_object throughout the entirety of the game with only invoking the original total method once.

## Preliminary processing of the problem
In this situation, each of the methods listed below use the exact same approach to finding their totals within each method. This is a great way to inspect repetitive uses. By each method, I explain how that method uses each total so that we can look at whether or not a caching solution would be the best approach.

1. `display_user_cards` contains a string that uses an internal total array. This method provides an output of the user cards and their respective total for the user to have a handy count available. If it is not the user's turn, caching the total output would be ideal making this a great candidate for the caching approach. 
- note that this method is already user agnostic, it should be used when wanting to show all cards for each user and includes the total as well. Knowing this and with the idea of creating the outer loop cached variables that can be manipulated from within the inner user's turn loop, we can remove the need to call on totalling the sum within this method and instead pass in the cached variable as an argument 
  - The values of the user's hand will also change depending on if the user has an ace and how that player decides to proceed with the hand (hit or stay).

will_user_bust? uses a total array within the method to return a boolean indicating whether the current hand of the user is greater than or equal to 11. this method would benefit from a caching total passed in as an argument as it is only used within the deal method when checking for an ace. 

hold_on_seventeen uses the same approach as the will_user_bust? method however it does not return a boolean value. This would also benefit from the caching total being passed into the method as an argument. 

bust? By invoking the actual total method within the user's turn method, we assign the local variable (to the outer loop) from within the inner loop (user's turn iteration). Because we pass the cached total as an argument, we are getting the _live_ value upon each iteration as long as we ask for the total _after_ we have modified it. regarding the extra login within the bust? method, as long as we also inspect the cards's value to return the total.include?(11) method call when reassignment of the ace is in order. 

twentyone? also uses the same approach as the bust? method in how it uses its own internal array, and is a perfect candidate


total_value_cards it is worth thinking about using this as the master total method that we can use for caching purposes. Though note it does not return a sum. Instead it returns an array of the values(int) within the players cards. This array is then passed to the compare_hands method and the Array#sum function is invoked on the arrays there. Some tweaking will be necessary to return a simple sum for display purposes.

Walkthrough:
- [x] deal cards => initial_deal
- [x] count cards => initial_count #create
- [x] player turn => player_turn
- [x] update count => deal
- [x] dealer turn => dealer_turn
- [x] update count => deal
- [x] compare counts => inspect

===================================================
## Creating one play_round method
### Stepping through the vision
- call the play_hand(hsh)
  - assign player and dealer to their hashes
- play_hand is not a loop, it's a set of instructions from the initiation of the game to its sub-parts, encompassing all other methods maybe. Or, it's just for the players.
- We want to streamline the individual hand methods into something that will remove a lot of the duplication. The player turn has different needs than the dealer and vice versa.
==================================================

- [x] would be nice to keep the match score persistent?
- [x] 21 announcement is working but this should be in the banner 

## REBUILD DECK OF CARDS HASH
- [x] Ideally, we just contain both the player and the dealer into one method instead of having to call it twice, even within the current abstracted setup we still need to call the method twice in the game loop. Much better would be to call a single play_hand(round) method that would go through each player in succession since if follows that the player will always go first, and the dealer second. 
- [x]  each player(2) gets their own hash that contains two key, value pairs. note the values are arrays.
- [x]  deck of cards is a hash containing 4 separate hashes(suits) that contain one hash(cards) made up of keys(strings) and values(arrays) representing the numerical value of each card. 
- [x]  given that the cards hash is equivalent across the deck, these could be removed to be called by the individual suit.
- [x]  the suits can call a general cards method that will input the cards hash into the suit's hash.
- [x]  perhaps handy to use an array to hold the strings of the suits and run an iteration to create each hash's suit.
  1. initialize_twentyone calls players
  2. initialize_twentyone calls deck init_deck(SUITS_ARRAY)
  3. deck calls suits(SUITS_ARRAY) init_suits(SUITS_ARRAY)
  4. suits calls cards. init_cards
- [x] the cards method can be called from within the suits method without passing it an argument since it's a method that we define. 
==================================================

