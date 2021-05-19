# Computer Turn Refinements
I really can't say I'm proud of the code at all at the moment, but I am proud of how I got there. All in all the logic is correct, and more importantly, it's becoming easier and therefore I'm getting the hang of it better. Muscle memory in the mind remapping stages of the day. The largest challenge has been the breaks in-between and losing that seemingly very fragile focus point. Of course I better understand this now, after being humbled by the same thing a few times over. That's pretty much what I would imagine is normal.

Some of the best places for me to have the growth I'm looking for came by way of actually refactoring and therefore re-reading my own logic after these small breaks. In particular with the TTT bonus features game, things started to get pretty complicated for me to follow and this was a great reminder on how to go back in and deconstruct the problem to better understand the solution. As well, deconstructing became very fruitful as I now more thoroughly understand the whole necessity of readable code.


## Refactor todos UI:
- [ ] rubocop with 0.86
- [ ] add numbers for individual squares so that the user interface can help improve the user experience.
- [ ] BOARD NUMBERS: this could be as simple as replacing the INITIAL_MARKER with the `num` value from the initializing method. I got this to work but it would be a lot nicer if the numbers were only there for a specified amount of time considering the distraction. Or maybe until there is a mark on the board then the numbers could go back to being just empty strings.

## Refactor Logic Practice:
- [h] Let's take out the redundancy of the round_loop multiple break statements and see if it's possible (it is) to break it into a single move and break statement.
- [ ] refactor the joiner and validate joiner method correctly
- [x] Let's work on abstracting the logic that is happening within the round loop beginning with the case statement.

- [x] the computer will currently always take square 5 as it's first move. This may not necessarily be a bug but it's a bit of a side-effect. Perhaps better to skip the square 5 if the board is empty first and instead opt for a random square? --this works using the random choice and having the computer go first so it follows that it would work as well with selecting that the computer goes first, however it isn't working when the user goes first. It should pick 5 if the user has already marked a square and 5 is still available.-- testing in `irb` in how to chain conditions through an if/elsif statement. As I thought the multi-conditional if/elsif statement does support that logic. 

- [x] If this works, there is still the matter of letting the board update after the user has made a selection and _then_ move onto the computer move. So in effect, there is a break to apply the user move to the board itself (both visually and in the hash).-- got it working, however I'm noticing that there is a new bug when the match number defaults to 1, upon a tie it stated that the user won and actually ends the match instead of carrying on. However when a user actually puts in the same number as the default (1) then it behaves correctly by continuing on if a tie has been encountered. 

- [x] the fix was an ad-hoc to isolate the issue, however it looks like that whole match_rules can definitely be cleaned up. Start by testing the messaging method in irb, perhaps good make a messaging method that takes one long sentence and breaks it down to multi-lines of specified width? Research this to see if it is available through the Ruby Docs.

- [x] abstract the `computer_places_piece!` method and find a way to either use case (which probably won't work due to the multiple condition situation) but maybe this is a good place to look at the use of explicit return values?

- [x] Add a fallback setting for the user to go first if no choice is given? Note that this would presumably work from within the calling of the method or the method itself?


- [x] Change the PLAYER_MARKER and COMPUTER_MARKER to PLAYER1_MARKER and PLAYER2_MARKER respectively. This is a good idea but the objective is that `X` should always be the mark of the first player. So any changes to this should be verified to actually help the readability.

## Assigning which player goes first
Since I already have a first_player and second_player method established, assign the PLAYER_1 marker to first_player and the PLAYER_2 marker to the second_player within those respective methods. 

```ruby
round_loop => first_player => player_places_piece! => brd[square]
round_loop => second_player => computer_places_piece! => offense?/defense?/square 5?/random  => brd[square]
```

## Detection Block Deconstruction:
The `computer_places_piece!(brd, valid_squares, computer_marker, opponent_marker)` method in turn calls other methods that verify offensive and defensive priorities and ultimately end up with choosing a random marker if none of the other priorities evaluate to true.

## Going through each priority of the `computer_places_piece!` method

1. detect_offense
  detect_offense => valid_offense => priority => computer_squares => computer_marker from valid_squares (available squares) 
  
  `detect_offense` checks all computer marks from the given board and determines potential winning moves. 
  We get the return array that contains all current markers on the board that match the computer's defined markers and pass them to the priority method to return an array that contains 2 values in a pattern that are defined with the `WINNING_LINES` constant. 
  We take that array and pass it up to the `valid_offense` method to check the array against available squares on the board. This will return an array with values representing all available squares that are in a winning pattern with 2 computer marks already. 
  Within the `computer_places_piece!` method, we test to see if the `detect_offense` method is true and if so we assign a random selection from the `detect_offense` method to the square to place on the board.

2. detect_defense(brd, valid_squares, opponent_marker)
  The `detect_defense` method does the same thing as the `detect_offense` but with the `priority` method getting the `player_squares` and  `player_marker` passed in as arguments to reveal potential wins for the player. This will return an array of potential squares that the computer can sample from and block the player.

3. choose_five(brd, valid_squares, opponent_marker)
  This method will simply make the computer choose square 5 if it is available. The only caveat to this is that it will only return true if it is not the first move of the game. Otherwise it will always start with square 5 if the computer goes first and that makes it a little less interesting. 

This leads us to the final choice of picking a random square if the other three methods return false in their boolean values. This has the advantage of choosing square 5 as well, but as a random and not necessarily deliberate (hard coded) choice.

NOTE: Currently, we are retrieving the scores from the `detect_winner` method that counts the marks in the board and compares to the WINNING_LINES constant, and then we simply hard code the 'player' or 'computer' depending upon if the marks match the values we hard coded earlier. 

The problem is that now that the marks are interchangable depending on who the user decides to go first with, we find that it's not as easy as reading the markers. We need a way to associate the hard-coded string within the `detect_winner` method to a dynamic string that gets passed into the `detect_winner` method. The place where we are passing the PLAYER1_MARKER and PLAYER2_MARKER as arguments comes from the initial `round_loop` from the `user_choice` variable. The user makes a choice and that gets 

-----------------------------------------------------------------------------------------------

NOTE: got the score to update and needs further testing now. It looks like I can consolidate the `first_turn` and `second_turn` assignments into their own methods and clear them in the process since they reside within the `round_loop`. I marked it in the comment within the markers_v2 file

### Bonus Features File List of user inputs to validate:
- [x] ask_who_goes_first (string, %w(p, c, r))
- [x] how many round to play? (defaults to 1, also needs to have a max value of 5)
- [x] choose a square (int (1,9))
- [x] play another match? %w(yes, y, n, no)
- [x] Clear up display messages in order to clarify that the markers that each player will use in the intial show
- [x] the validate input method is working but it has only been tested in `irb` so need to try and implement it throughout all user inputs. Definitely not working at the moment with the way it's implemented. Look at this with some coffee.
- [x] Also, note that the it will validate if the input is, for example, p or player. Let's keep it simple for now but I'd really like it to be flexible without adding too much conditional code.
- [x] the return value from the validate method inside the ask_who_goes_first needs to be appended to the `str` variable.

## input_validation test file
- [x] now testing out the integer range or specific number as a data_range
- [x] implement into codebase via different methods. currently I'm trying to break down the test.rb file correctly as the master method is working correctly, but I want to abstract the validate integer range method and then include that into the master method.
- [x] might be nice to be able to add an array to hold the string values for readability?
- [x] double check if I can use flatten on the data_range parameter
- [x] return values for integer is self unless false or nil
- [x] return value for string is self unless false or nil
- [x] go through each example output to verify and understand the return values and how they go.
- [x] return values for integer_validation and integer_in_range all okay for deeper understanding. Now look into whether or not we want to make the range array an optional parameter


## Disabling the `set_user` method from the `first_player` method. 

What I discovered through testing, was that the set_user method was working correctly, except that it wasn't able to set the user until the first_player method had been called, since that is where the method was being called. So removing it from the first_player method and setting the user earlier within the round_loop (right after we update the board and before we display the score) was what gave the expected result.

- [x] bug with continuing the game by choosing yes again. Both player and computer work correctly even when playing again. It is therefore isolated to the `user_choice` of 'r' (random), which means it may not be setting the `computer_choice` correctly. After the initial fix, it looks like it worked for the first round, but then switched players on or after the second round when the computer engaged in it's turn. This implies that the variable for `computer_choice` is not persistent.

So instead of trying to see if the error happens again, I'm going to pause on this for a moment and walk through my display_players_markers method:

1. First we check the user_input to see what the user chose for the first player as it's required it will always be true.

2. Depending upon what the `user_input`, they can choose player, or computer or random. 'p' and 'c' are straight forward and assign the player and computer to `player1` and `player2`.

3. If the user picks 'r' for a random choice, the computer will assign either 'p' or 'c' to the computer_choice variable by sampling from a `valid_choices` array.

4. Although the `computer_choice` variable gets cleared in the action of ending a round by a match win, it is still retained while working through the loop (this makes more sense if you think about the situation where a user goes first and the round results in a tie. The user should go first again for the next tie-breaking round). 

5. The current bug at the moment is related to the fact that we first run the `display_players_markers` at the head of each turn to illustrate who has 'X' and who has 'O' as a courtesy.  In so doing, I didn't allow for the fact that the `computer_choice` may have already been set during the first turn and I didn't check that. In effect, if the user picked 'r' for random, this continuously reset the `computer_choice` to a random value upon every turn. 

6. The patch was simply to return the `computer_choice` if it had already been set. Although at first implementation of this, I discovered that I was merely assigning the variable `random_choice` instead of mutating the variable with `<<` which was what was needed to keep the `random_choice` variable persistent throughout the round.

This has been a great cool project to understand the benefit of mutating the caller and how that can be very useful in a program like this.

In order to remove the redundancy, we need a way to call a single method and have that method call the first_player and second_player method depending on who's turn it is. So for example, if the player is player1 then the first move is first_player. the round_loop tests to see if someone has won or there is a tie, if not we iterate through the roun_loop again and this time the same method that returned the first_player in the previous iteration now returns the second_player. (can a hash hold a method?) and so forth. 

1. We know that the display_player_markers method assigns the player1 and player2 variables corectly from user input.
2. We also know that first_player and second_player are associated correctly to player1 and player2.
3. We can add a counter to the round loop with it beginning at 0. Then we can create a method that calls either first_player or second_player depending on if the counter is even or odd. Then we update the counter after every turn and reset the counter at the end of the round (counter should never be more than the array.size for available initial squares.

Great, so that worked but now I'm sensing in my gut that anything more than 3 parameters isn't very readable or enjoyable to look at. So the major refactoring here will be to intialize the user choice and the computer choice as their own methods. This way, perhaps I can remove these two items from all the methods that call them and instead pass them in as self-contained methods that return their respective values.

First up: user_choice
Currently the `user_choice` is an empty string, that gets passed to the `round_loop` as a `user_input` parameter. This same parameter gets passed to `display_players_markers`. The `display_players_markers` gets used every iteration within the `round_loop` however, we don't need to case the `user_input` after it's been intialized. Therefore, let's move the case `user_input` into a `user_input(user_choice)` method that can handle the setting of each user once.
This will leave the `display_players_markers` to simply output the markers instead of the heavy lifting it has to do upon each iteration through each round.

1. initialize a user_input(user_choice) method that takes the user_choice string
2. this method should assign the player1 and player2 accordingly based off the input.
3. the return value isn't important as much as the initializing of the match's variables due to the nature of the round_loop _currently_ passing player1 and player2 as parameters. 

Second Up: play_again
We create a local variable to hold the input from the user but we don't necessarily need it. We can just call the ask_play_again without an argument and have the method set it. Currently I have it setting the answer and casing that answer from within the method itself. However it looks like it's taking the input and clearing the screen correctly however it is not starting another round. In fact it even asks you again. WHOA I did not know you can call a method simply by creating a conditional (mindblown) like so `break if ask_play_again == 'n'`

Third up: reset_local_var
We can strip out the player1 and player2 from that since we can instead have the intialize user handle that. Perhaps all of the local variables actually? actually nevermind, resetting the user_choice once the user actually chooses doesn't work.

# ::LEFT-OFF:: 

Fourth up: first_turns and second_turns ::LEFT-OFF::
Currently I'm calling it from all around the methods as so much depends on them. If when I'm initializing the users, I could also create a hash to hold their values, I could then at least get rid of the local varialbes (player1 and player2) and then call them at the very lease as parameters like so: `hsh[:player1]`. 

I think I am making this more complex than necessary. Trying to have a hash evoke a method doesn't seem like a good solution. I know I can re-write the set_user method in order to keep the redundancy down, however it will still contain a multiple condition within. What I really want is to remove the if/else conditional within the case statement that also contains another case statement.

I still think there's something to this hash since it can hold a lot of values. In fact there is already a stash that is holding `:player` and `:computer` so if i were to mold an idea after something like that...

the case statement is all about if this condition is true, than do that so working with the set_user method we can call the method and use a hash to hold the values that are valid_choices (we are already using something like that when we are passing the valid_choices array to the validation method I created ['p', 'c', 'r'] so there's no reason we can't bake this array into the hash itself as the value to the key, value pair `:valid_user_choices => [ 'p', 'c', 'r' ]`.

So let's work through this a little bit for the validate_user_input(str, data_arr, type) method I created. It now takes an input (in the form of a string remember), an _array_ (valid_choices array), and a string to denote what type of validation it needs to perform. A typical method call would normally be: 

validate_user_input(answer, valid_inputs, 'string') but now we could call it:
validate_user_input(answer, hsh[:valid_user_choices], 'string') to validate using the same array.

users = {
  p: 'Player',
  c: 'Computer',
  r: ['p', 'c'],
  valid_user_inputs: [ 'p', 'c', 'r' ],
  user_choice: '',
  computer_choice: '',
  player_1: '',
  player_2: ''
}

One nice side-effect is that we can now call hsh[:r] to return the array ['p', 'c'] which means we can assign as computer_choice = hsh[:r].sample at that will return a string of either 'p' or 'c'.

## set_user method refactor if we simply assign the player1 and player2 within the method (as we currently do) then there's no reason we can't simply set player1 first (always first) and if player1 is already set, then set player2 if it isn't set. If, however both are set, then we need to first clear the values and then set the value passed as player1.

1. call the method and pass three parameters player1, player2, 'users_hsh'.
2. within the method detect if player1 and player2 are both empty?
3. if both are not empty, then clear their values.
4. whichever is the first variable to not be empty gets assigned the argument passed

::LEFT-OFF:: 
The below method hasn't been tested yet, best to try this in a separate file I think to fully test return values. We still need a way to assign and validate the users_choice.

NOTE: that running the method does permanently modify the hash so this should only be run at the start of each match, not round, otherwise we need to reset the user_hsh[:r] value. Also, we need to intialize the users_hsh at the beginning of every match like we do with the board.


If this works, let's look at a better way to handle it. One option would be to hold the hash keys as the :r key like so: :r => [ hsh[:p], hsh[:c] ] and this way would could potentially sample a direct key and return the value?

def computer_chooses(hsh)
  if hsh[:computer_choice] == ''
    hsh[:computer_choice] << hsh[:r].sample
    hsh[:r].delete(hsh[:computer_choice])
  end
  if hsh[:computer_choice] == p
    hsh[:player_1] << hsh[:p]
    hsh[:player_2] << hsh[:c]
  else
    hsh[:player_1] << hsh[:c]
    hsh[:player_2] << hsh[:p]
  end
end

So the longer computer_chooses method worked correctly. Let's work on this idea of returning a hash value that contains another value from the same hash. I'm curious about the delete part. First off it does work, but returns the value which actually be all we need. So the delete method only mutates the [:r] key's array, not the original key from eithers [:p] or [:c]

def get_users_input(hsh)
  puts 'p, c, or r'
  hsh << gets.chomp
end

def reset_local_var(var_1, *vars)
  var_1.clear
  if vars
    vars.each { |item| item.clear }
  end
end

def set_users(hsh)
  if hsh[:player_1] && hsh[:player_2] != ''
    reset_local_var(hsh[:player_1], hsh[:player_2])
  end
  case hsh[:user_choice]
  when 'p'
    hsh[:player_1] << hsh[:p]
    hsh[:player_2] << hsh[:c] 
  when 'c'
    hsh[:player_1] << hsh[:c]
    hsh[:player_2] << hsh[:p]
  when 'r'
    hsh[:r] = [ hsh[:p], hsh[:c] ]
    computer_chooses(hsh)
  end
end

def computer_chooses(hsh)
  if hsh[:computer_choice] == ''
    hsh[:computer_choice] << hsh[:r].sample
    hsh[:r].delete(hsh[:computer_choice])
  end
  hsh[:player_1] << hsh[:computer_choice]
  hsh[:player_2] << hsh[:r].join
end
   
def initialize_users
  {
    p: 'Player',
    c: 'Computer',
    r: [],
    valid_user_inputs: [ 'p', 'c', 'r' ],
    user_choice: '',
    computer_choice: '',
    player_1: '',
    player_2: ''
  }
end

users = intialize_users
get_users_input(users[:user_choice])
set_users(users) 

::WRAP-UP::
This is the right path, yes. by holding all the user data within a users hash we can eliminate a lot of repetition with the strings throughout the program. 

- [x] So with that, I think next steps are to distil these methods into their own testing case so that I can come back to them and modify when needed. The whole irb thing isn't really great for that kind of thing. What a workout!

Major refactoring through the testing file, it's been great clarity for me to work through soemthing that isn't as complex. abstracting so much of the code and using the hash has really been instructive since it helps me de-clutter and it's easier to focus on. So I've never enjoyed player1 and player2 as it gets confusing with Player and Computer. The physical user is the player, and is playing agains the machine user => the computer.

Next will be to implement this into the TTT game. The one thing that stands out for this is that I need to restructure the validate the user input as I mention in my notes above (within the ask_who_goes_first method). This should be relatively easy as the valid choices that are outlined are already in an array format within the users hash. There's a few smaller things I'd like to better simplify with regards to the hash but at this point I feel it's ready. One thing I want to do is find a way to better simplify that double assignment that is happening within the case expressions. I mean, it makes sense given that there needs to be two different assignments, but it would be nice to call a simple assignment method once and have it assign the variables accordingly within that method. I do believe that was the intial ideal to this hash business but I've discovered a much broader use with the hash now.

Also, the fact that we now have all user data encased within the hash means I can cut quite a bit off the parameter and argument chain. This needs to be done across the whole system. So let's break down the parts:

### Refactoring outer player1 and player2 variables and arguments
These are the main current parameters and arguements that get passed in from the game logic and initialization.

1. initialize_users method parameters
2. reset_local_var method passed in from initialize_users
3. set_user method passed in from initialize_users
4. Game Logic variables
5. round_loop method parameters

All of these methods associate the inner methods of the program with the main arguments of player1 and player2. So theroetically we can simply remove these as variables and instead call them from their new hash. However, we no longer need so many parameters later on within the logic of the game, they can now be distilled down through their respective hash values where necessaary.

### Inner method parameters and arguments
1. round_loop defines the player1 and player2 arguments as first_turn and second_turn parameters that it passes to other methods that are called from within the round_loop
  a. display_players_markers
  b. turns
  c. someone_won?
  d. display_round_standings

So it stands to reason to first drop in the new methods and hook them up. set_user(line 404, note that it is origninally set_user) and reset_local_var(line 368) and initialize_users(line 42).

## Done
::WRAPPING-UP:: Good stuff and session. The code feels much cleaner now and I really liked getting deeper with my hash knowledge. There's some smaller refactoring to still be done but I'm ready to have this reviewed. I just gotta get it into the rubocop and maybe look at the way the screen displays (looks like a flicker after the board updates). This flicker does seem to happen only after the user inputs their square choice.:w

# Refactoring round_loop

This doesn't have to be as big as I'm making it out. Pretty cool to be able to define a hash as the only or last parameter in a method and then call the arguments without supplying the curly braces. Heck, without supplying the hash object itself. We just need to be able to specify the same keys in the arguments that will correlate to the necessary hash objects we define in the method.

So with that, starting with the round_loop parameters, I simply added the users_hash as the final argument to that method to start with. 

::LEFT-OFF:: refactored round_loop well. Fun too. Now moving to focus on the heinous computer_places_piece! and refactor the constants and parameters to include instead the cycle parameter from the round loop which is the users hash. The users hash now holds the user markers too so we can use that instead of the constants where applicable. 

With coffee... save as file 13, double check everything is working, commit and refactor the constants out of problematic places starting with computer_places_piece!

first issue when trying to refactor the computer_places_piece is that the way the method is being called right now, it needs to pass two parameters in order to swtich the player marker depeneding on if the computer goes first or second. This seems to be a very primitive way to create the solution in the context of the rest of the refactoring.

what would be nice is to just pass the hash through as is since it holds both values or similarly as with the player marker being passed as one parameter. However that's being passed as one key value pair from the intial hash, would that still give us access to the whole hash? The answer is no.

the next option would be to pass the whole hash in and have the computer_places_piece sort through it but that seems to be a waste of the case method that we are using for determining first and second player through those two methods.

So with that being stated, I think the answer would like it rebuilding the first and second player methods in a way that is more portable than the current setup. Once we establish the first user, we should be able to just set the second user since there are only two users. No need to duplicate the case statment again. I think we have something already in line with this with the former set_users method where the create_user_one is a one liner and the create_user_two is a simple two liner for assignment.

Part of the confusion seems to be that the first_player method is actually being used to assign a marker for the first player even though it's already been setup from the beginning. so [:user_1]=>'Player' will always be PLAYER1_MARKER due to the way the game is set up. If the computer goes first then [:user_2]=>'Player' will always be PLAYER2_MARKER. so if [:user_1]=>'Computer' then computer mark will be [:mark][:user1]

after further exploration, it looks as though my approach to this was in error. What i'm really trying to do is limit the amount of arguments that need to be passed. if the computer_places_piece method has 3 parameters, it still creates a larger method to do the assignments. A better approach is abstracting the logic into separate methods at this point.

So the way forward was to realize that I had made a mistake early on wtih the creation of the valid_squares parameter thinking that it had to be there to pass along. I completely forgot that the method didn't need to be passed into an argument, it can be called from inside the method itself. Now with that knowledge, I will refactor the following three methods called from within the computer_places_piece! method.

detect_offense
detect_defense
select_five

Refactoring refactoring and understanding more and more. Love it all. Just left off with refactoring the computer_places_piece and it's okay now, but I think I should still abstract the definition of the opponent marker to its own method. 

NOTE: Cool way to rename a key in ruby:

`hash[:new_key] = hash.delete(:old_key)`

This assigns the old_key to the new_key while creating the new_key.

K, back to it, I am experimenting now with being able to pass just the symbol as an argument and see if that will work. This would be a great way to cut down on parameter length and make it more readable too.

One thing that is certain, I have to stick with user_1(player or computer) or user1(X or O) but not both.
:markers could be better defined within the board hash
