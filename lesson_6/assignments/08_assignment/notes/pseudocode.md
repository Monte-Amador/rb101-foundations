# Pseudo-code for 21

## Data Structure V1
if we use a data structure of a hash, it can hold both the dealer and player objects as separate hashes as well as hold all 52 cards in relation to their respective suits as nested hashes or arrays or a combination of both (example structure):

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

Because each user (player, dealer) will first be dealt two cards, it makes sense to keep all cards in their own array. That way the initial deal will always refer to the respective player's `:cards[0]` and `:cards[1]`.

We can also run the `Array#sample` method on the specified arrays to retrieve a random integer and run `hsh.keys.sample` and `hsh.values.sample` to retrieve random key/value pairs when necessary.

## Operations
- [ ] 21 > bust
- [ ] INITIAL_DEAL: both player and dealer receive 2 cards each
  - [ ] player can view both cards, but only one card(first) from dealer
- [ ] LOOP: player inputs 'hit' for new card. 
  - [ ] break if player chooses to 'stay' || 'busts'
- [ ] VALUES: all cards are standard values face values and 10 except ace
- [ ] aces equate to 1 or 11 upon context
  - [ ] if total value  
- [ ] bust = lose
- [ ] COMPARE:whoever is closest to 21 without busting = win
- [ ] DEALER TURN: decides to hit or stay after player stays
  - [ ] dealer must hit until 17 >= total
