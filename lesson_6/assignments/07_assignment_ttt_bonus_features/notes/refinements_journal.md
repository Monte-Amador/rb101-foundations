# Computer turn refinements
I really can't say I'm proud of the code at all at the moment, but I am proud of how I got there. All in all the logic is correct, and more importantly, it's becoming easier and therefore I'm getting the hang of it better. Muscle memory in the mind remapping stages of the day. The largest challenge has been the breaks in-between and losing that seemingly very fragile focus point. Of course I better understand this now, after being humbled by the same thing a few times over. That's pretty much what I would imagine is normal.

Some of the best places for me to have the growth I'm looking for came by way of actually refactoring and therefore re-reading my own logic after these small breaks. In particular with the TTT bonus features game, things started to get pretty complicated for me to follow and this was a great reminder on how to go back in and deconstruct the problem to better understand teh solution. As well, deconstructing became very fruitful as I now more thoroughly understand the whole necessity of readable code.


## Refactor todos UI:
- [ ] add numbers for individual squares so that the user interface can help improve the user experience.
- [ ] BOARD NUMBERS: this could be as simple as replacing the INITIAL_MARKER with the `num` value from the intializing method. I got this to work but it would be a lot nicer if the numbers were only there for a specified amount of time considering the distraction. Or maybe until there is a mark on the board then the numbers could go back to being just empty strings.

## Refactor Logic Practice:
- [x] Let's work on abstracting the logic that is happening within the round loop beginning with the case statement.

- [x] the computer will currently always take square 5 as it's first move. this may not necessarily be a bug but it's a bit of a side-effect. Perhaps better to skip the square 5 if the board is empty first and instead opt for a random square? --this works using the random choice and having the computer go first so it follows that it would work as well with selecting that the computer goes first, however it isn't working when the user goes first. It should pick 5 if the user has already marked a square and 5 is still available.-- testing in irb in how to chain conditions through an if/elsif statement. As I thought the multi-conditional if/elsif statement does support that logic. 

- [x] If this works, there is still the matter of letting the board update after the user has made a selection and _then_ move onto the computer move. So in effect, there is a break to apply the user move to the board itself (both visually and in the hash).-- got it working, however I'm noticing that there is a new bug when the match number defaults to 1, upon a tie it stated that the user won and actually ends the match instead of carrying on. However when a user actually puts in the same number as the default (1) then it behaves correctly by continuing on if a tie has been encountered. 

- [x] the fix was an ad-hoc to isolate the issue, however it looks like that whole match_rules can definitly be cleaned up. Start by testing the messaging method in irb, perhaps good make a messaging method that takes one long sentence and breaks it down to multi-lines of specified width? Research this to see if it is available through the Ruby Docs.

- [x] abstract the computer_places_piece! method and find a way to either use case (which probably won't work due to the multiple condition situation) but maybe this is a good place to look at the use of explicit return values?

- [x] Add a fallback setting for the user to go first if no choice is given? Note that this would presumably work from within the calling of the method or the method itself?


- [x] Change the PLAYER_MARKER and COMPUTER_MARKER to PLAYER1_MARKER and PLAYER2_MARKER respectively. This is a good idea but the objective is that `X` should always be the mark of the first player. So any changes to this should be verified to actually help the readabiltiy.

Since I already have a first_player and second_player method established, assign the PLAYER_1 marker to first_player and the PLAYER_2 marker to the second_player within those respective methods. 

```ruby
round_loop => first_player => player_places_piece! => brd[square]
round_loop => second_player => computer_places_piece! => offense?/defense?/square 5?/random  => brd[square]
```

## Detection Block Deconstruction:
We call the `computer_places_piece!` method which calls other methods to verify offensive and defensive priotities. First call: the `detect_offense` method which uses the `computer_squares` method to detect `computer_marks` on the board that are in position to win (2 consecutive `computer_marks` defined within the `WINNING_LINES` constant).

```ruby
# method return values passing map
computer_squares(brd, computer_marker) => priority(range_arr) => valid_offense(win_range, valid_squares) => detect_offense(brd, valid_squares, computer_marker) 

# method chaining
first/second player computer_places_piece! => detect_offense => detect_defense => choose_five => random
```

The detect defense method uses the player_squares method to detect any player_marker values that are in position to win (2 consecutive player_markers in a winning_line defined pattern and an available square to win).

player_squares(brd, player_marker) => priority(range_arr) => valid_defense(threat_range, valid_squares) => detect_defense(brd, valid_squares, player_marker)

If `detect_defense` returns false we then check to see if square five is available with the `choose_five` method. This method not only chooses square 5 if it is available, it also deliberately chooses square 5 only if it is not the first turn for the computer. This way the computer is not always choosing 5 when the computer goes first.

This leads us to the final choice of picking a random square if the other three methods return false in their boolean values. This has the advantage of choosing square 5 as well, but as a random and not necessarily deliberate (hard coded) choice.

NOTE: the detect_winner method needs help in distinguishing who the player is (user, computer) as we've established that each first player will get the X and the second player will get the O. We need this in order to keep score instead of the current player1 and player2

NOTE: Currently, we are retrieving the scores from the `detect_winner` method that counts the marks in the board and compares to the WINNING_LINES constant, and then we simply hard code the 'player' or 'computer' depending upon if the marks match the values we hard coded earlier. So the problem is that now that the marks are interchangable depending on who the user decides to go first with, we find that it's not as easy as reading the markers. We need a way to associate the hard-coded string within the `detect_winner` method to a dynamic string that gets passed into the `detect_winner` method. The place where we are passing the PLAYER1_MARKER and PLAYER2_MARKER as arguments comes from the initial `round_loop` from the `user_choice` variable. The user makes a choice and that gets 


current_score comes from the intialize_score method which is a simple hash { player: 0, computer: 0 } and current_score gets passed through to most of the methods via the round_loop.

REMEMBER: we can only access variables outside of methods by passing them in as arguments

got the score to update and needs further testing now. It looks like I can consolidate the `first_turn` and `second_turn` assignments into their own methods and clear them in the process since they reside within the `round_loop`. I marked it in the comment within the markers_v2 file


- [x] check that detect_offense and detect_defense methods are okay with returning nil if no action is needed

- [x] create a feedback method to abstract the if/else statement at the end of the round_loop.

- [x] add the final score to just before the good-bye message

- [m] Make a validation method to test all user input and make case insensitive validation. Test for integers and also specific strings.

- [x] Find the correct version of rubocop and see if I can update that with my ruby environment (install adjacently instead of overwriting it the same way I can use chruby accordingly).

- [x] Need to validate an integer between 1..10 for how many rounds will be played, and also provide a fallback if the user simply presses return.

- [ ] refactor the joiner and validate joiner method correctly
- [ ] LEFT OFF: looks like the rounds method isn't working properly with the given valid inputs. for example, if you input 7 it will start playing instead of erring out and looping through again.

### List of user inputs to validate:
- [x] ask_who_goes_first (string, %w(p, c, r))
- [ ] how many round to play? (defaults to 1, also needs to have a max value of 5)
- [ ] choose a square (int (1,9))
- [ ] play another match? %w(yes, y, n, no)

- [h] Let's take out the redunancy of the round_loop multiple break statements and see if it's possible (it is) to break it into a single move and break statement.

- [ ] Clear up display messages in order to clarify that the markers that each player will use in the intial show
- [ ] rubocop with 0.86
- [x] the validate input method is working but it has only been tested in `irb` so need to try and implement it throughout all user inputs. Definitely not working at the moment with the way it's implemented. Look at this with some coffee.
- [x] Also, note that the it will validate if the input is, for example, p or player. Let's keep it simple for now but I'd really like it to be flexible without adding too much conditional code.

- [x] the return value from the validate method inside the ask_who_goes_first needs to be appended to the `str` variable.

## test.rb
- [x] now testing out the integer range or specific number as a data_range
- [x] implement into codebase via different methods. currently I'm trying to break down the test.rb file correctly as the master method is working correctly, but i want to abstract the validate integer range method and then include that into the master mehtod.
- [x] might be nice to be able to add an array to hold the string values for readability?
- [x] double check if I can use flatten on the data_range parameter
- [x] return values for integer is self unless false or nil
- [x] retunr value for string is self unless false or nil
- [x] go through each example output to verify and understand the return values and how they go.
- [x] return values for integer_validation and integer_in_range all okay for deeper understanding. Now look into whether or not we want to make the range array an optional parameter
