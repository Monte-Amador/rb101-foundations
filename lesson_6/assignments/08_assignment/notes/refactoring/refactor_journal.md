- [x] Refactor output for displaying cards with better readability

- [ ] look at renaming the display_initial_hands method as it is the only one being called during the player_turn method. It might be a bit confusing since we continue looping back to it so it's not really the initial hands by the second iteration, it will display the modified hand.
- [x] rename hidden to hide
- [x] change user_total in deal method to total_arr
- [ ] see about abstracting the logic of the deal method if that is possible. 

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

- [x] the test is how to permanently change the outer variable and still use it (as an argument) when the loop goes through another iteration.
- [x] so that works simply by looping through and adding the output to the total array on each turn.

total_value_cards it is worth thinking about using this as the master total method that we can use for caching purposes. Though note it does not return a sum. Instead it returns an array of the values(int) within the players cards. This array is then passed to the compare_hands method and the Array#sum function is invoked on the arrays there. Some tweaking will be necessary to return a simple sum for display purposes.

Walkthrough:

  x bust?(hsh, user, total) # update all occurences
    x dealer_turn
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
x. player turn => player_turn
x. update count => deal
x. dealer turn => dealer_turn
x. update count => deal
x. compare counts => inspect


- [ ] 21 announcement is working but this should be in the banner 
- [ ] would be nice to keep the match score persistent?

- [ ] MAYBE: ideally, we just contain both the player and the dealer into one method instead of having to call it twice, even within the current abstracted setup we still need to call the method twice in the game loop. Much better would be to call a single play_hand(round) method that would go through each player in succesion since if follows that the palyer will always go first, and the dealer second. 

===================================================
## Creating one play_round method

- [ ] create one user turn iteration for both dealer and player by abstracting the individual parts for player and dealer to their own more succint methods.

### Stepping through the vision
- call the play_hand(hsh)
  - assign player and dealer to their hashes
- play_hand is not a loop, it's a set of instructions from the intiation of the game to its sub-parts, encompassing all other methods maybe. Or, it's just for the players.
- We want to streamline the indidvidula hand methods into something that will remvoe a lot of the duplication. The player turn has different needs than the dealear and vice versa.
- [ ] ::LEFT-OFF:: user_turn is growing unkindly
- [x] The combination of user_turns is a good idea but each user needs their own iteration to account for their hit/stay processes. 
- [x] play_hand calls two different user_turn methods, one for each user.
- [x] cached_total >>> total
- [x] total_arr >>> cached_total
- [x] dealer_total could benefit from creating a new method called dealer_sum that takes the hsh as an argument and return the sum of the dealer's :hand_total.sum. Same with the player and we can further abstract the .sums up into their own methods where necessary.
- [x] a little more separation after player gets 21 because too often the game is over without really understanding thate the dealer's turn is up. More sleep separation involved. 

- [ ] MAYBE: abstract the initialization of the deck hash. It seems that there are 4 identical inner hashes except for their suits. Would be great to come up with a method to integrate that concept.

- [x] minimize all the total methods that are creeping up

- [ ] refactor note: one thing I am noticing is the lack of consistency between calling an ideal single total parameter for the particular user, and other methods that require the use of two separate parameters because of the need for both totals (e.g. dealer_turn => display_all_cards(hsh, p_total, d_total). I'd love to just pass the parameter of total as either an array with both cached variables or a single value. It's too hard to maintain this current way.
- [ ] need two separate totals in:
  - [ ] inspect_hands
  - [ ] compare_hands
  - [ ] display_all_cards


