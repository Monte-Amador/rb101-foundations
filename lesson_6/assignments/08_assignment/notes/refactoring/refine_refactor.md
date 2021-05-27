- [x] bug: choosing anything allows the game to continue.
- [x] clear screen at beginning 
- [x] remove continuous deck and allow for the reshuffle after every iteration of hand.
::LEFT-OFF:: I'm electing to leave the bug for the higher ranking cards as a preference due to the fact the game is logistically working. I want to focus for now on the non-bug priorities starting with the auto win at 21 from the deal like the bust? actions the end of that particular deal (dealer or palyer). Then move through the refactoring and testing to see if any other bugs show up.
- [ ] if player receives 21 at the initial deal, it still asks if the player wants to hit or stay - display 21 message if player gets 21 from deal and go to winner
- [ ] have the dealer's new card show up like the player's new card so that we see the card first before updating the hand.

- [x] aces are simply choosing between 1 of the two values in the array. Perhaps all values for aces are 11 but the method can change the value to 1 if the total would equate to a bust with 11. 
- [ ] display should be in this order:
  - [x] clear screen
  - display all visible cards for both dealer and player
  - if player stays, we see their cards again but that should be removed as the top of the screen still shows the current hand.
- [ ] need to hide the first card of the dealer's hand and not show the total until the compare method shows up 
## refinements
- [ ] Also would be nice to say blackjack if player has a face card and ace upon deal
- [ ] would be nice to only dispaly face cards in current format [JD(10)] and display face values with their value and suit [2H(2)]
- [ ] Need a way to hide first card from dealer
- [ ] make sure we can always see the cards like the ttt board

- [ ] BUG: once the dealer's turn begins the screen gets cleared and updates the current hand with the new card
- [ ] BUG: because of the way the hash pulls it's sampled data, it looks like there's a preference for face cards, but there isn't a preference per se, it's that there's a sample of the available keys choosing to pick a card within a suit. Because there are 5 possible types of cards there is a 1 in 5 chance that the had will include a face value. So that's why it continues to return higher face cards more than face_value cards.
