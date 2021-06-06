## refinements
- [ ] Also would be nice to say blackjack if player has a face card and ace upon deal
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

  together return an array holding the `new_card` data and append to the
`user_hand` array. 
  ensures that the arrays are not empty and are therefore a valid option to
choose a card from.
  necessary two index integer (i.e. `:'10' => card[0] + card[1]`) or not.
Return value defaults to `card[0]` otherwise.
  value).
  when showing the card that is dealt (without value). 
  passed into it) then display the individual card upon deal without value
attached to the string output.
  permanently modify the `user_hand` array.
  modify ace value's.
  argument. Note that the new_card object is a nested array like: [["3", "H",
3]]
  11 from the deal like it should, it keeps that value through the next hit. So
for example, the hand is an ace, 2, and 10 => 13. but instead it counts the
initial ace as 11 instead of changing it to a 1.
    account if they have a card with a value of 11 (an ace). if with the 11
they bust, reassign the 11 to a 1 and re-total.

## Refactor output for displaying cards with better readability
  that it's visually more clear what is happening. Look at bringing in the
prompt method.
  inform the user what is happening.

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

x. deal cards => initial_deal
x. count cards => initial_count #create
3. player turn => player_turn
4. update count => deal
5. dealer turn => dealer_turn
6. update count => deal
7. compare counts => inspect
- [ ] the ace reassignment is working, but for some reason the dealer stopped at 12 when it should have continued 
- [ ] The reassignment of the ace object when the dealer is about to bust works by inspecting the values of the dealer's cards and if it finds any 11s and the dealer is about to bust, it will change in place the value of the 11 to 1. This will keep the dealer from busting and it updates the score correctly as well as the card values, however the total value seems not to be getting updated until the next iteration after the hit, which makes sense as it was designed this way. 

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

- [ ] 21 announcement is working but this should be in the banner 
- [ ] would be nice to keep the match score persistent?

- [ ] MAYBE: ideally, we just contain both the player and the dealer into one method instead of having to call it twice, even within the current abstracted setup we still need to call the method twice in the game loop. Much better would be to call a single play_hand(round) method that would go through each player in succesion since if follows that the palyer will always go first, and the dealer second. 
  - [ ] create one user turn iteration for both dealer and player by abstracting the individual parts for player and dealer to their own more succint methods
- [ ] MAYBE: abstract the initialization of the deck hash. It seems that there are 4 identical inner hashes except for their suits. Would be great to come up with a method to integrate that concept.
- [ ] minimize all the total methods that are creeping up

maybe discovered a way to go about the massive amount of variable declaration, perhaps it's worth testing to see if I can create a hash to hold all of them and just include the hash as a parameter?

::LEFT-OFF:: rewrite the following order into an order that I currently have as a way of double checking the logic of the cached_total variable that is being passed around. We want to only declare the actual total method once or twice but nothing more as the cached_total object is being held in a hash we can easily (read inexpensively) mutate it and that updates all instances of the variable that points to that object (big lesson learned on this one).
- [ ] 1. variables are assigned in main loop
- [ ] 2. variables are passed into each user turn for modification
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

- [ ] refactor note: one thing I am noticing is the lack of consistency between calling an ideal single total parameter for the particular user, and other methods that require the use of two separate parameters because of the need for both totals (e.g. dealer_turn => display_all_cards(hsh, p_total, d_total). I'd love to just pass the parameter of total as either an array with both cached variables or a single value. It's too hard to maintain this current way.
- [ ] need two separate totals in:
  - [ ] inspect_hands
  - [ ] compare_hands
  - [ ] display_all_cards

ACE REASSIGNMENT INITIAL DEBUG NOTES:
