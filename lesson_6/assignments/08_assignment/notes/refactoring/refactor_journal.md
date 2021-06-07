- [ ] rubocop this baby
- [ ] user_turn is getting very unwieldy => strip this down to separate methods.
  - 4 different break conditions
  - 2 if/else statements
  - 1 loop
    ## walk the dog
At first glance the counter seems superfluous. I think I can make this happen inside of it's own method or just restructure the sleep(2) to be the return value of the player's turn. This would also give me the possibility of removing one of the break statements. 

What about the possibility of having just one user_turn by interpolating the user parameter? That may help remove one of the if statements.

  - currently, i have i have implemented another method that helps with abstracting the conditional statement to find out which player is going. It seems to be working, however I'm running into a similar problem as before when the player has an ace worth 11, hits and conceivably busts, but the program is supposed to detect it and change the value from 11 to 1. it does this, but what looks like on the next iteration of the dealer's turn. This points to the fact that the end of the loop was reading the break condition that the player had busted before it iterated through to the break statement where the ace would get reassigned. The solution to this should be to remove that expression where it counted the current status of the players cards and then broke from the loop. Instead, I have the dealer_method test for the value in its own method and return 'p_bust' from there and pipe that into the user_turn method as another break condition.::LEFT-OFF:: test this out more thoroughly and code review this puppy.

    1. Initialize a counter for the sole purpose of adding a sleep method for the dealer's beginning of the turn, just to give a moment of consideration about breaking if the user has busted already.
    2. The master break statement needs to be at the top of the method to test upon the iteration as well as the initial player's turn _after_ the initial deal. This is important because we want the user to pass if they get a 21.
    3. Output the banner for display purposes
    4. Conditional to test if current user is player.
      4.1 call the player_turn method by breaking if the return value is 'stay'
      4.2 else it is the dealer's turn and we need to first see if the user busted, then break if the user did so that we bypass the dealer's turn
      4.3 increase the count by 1
      4.4 again call the method to see if the user busted
    5. Call the dealer_turn method by breaking if the return value matches the hold_on_seventeen's return value.
   

- [ ] see about abstracting the logic of the deal method if that is possible. 
- [x] Abstract the initialization of the deck hash. It seems that there are 4 identical inner hashes except for their suits. Would be great to come up with a method to integrate that concept.


