# Breaking down the method

Ideally, I'm looking for a simplified set of instructions from within the method. Currently it returns three separate values that get passed to another round of conditionals. 

1. Return value #1: `current_squares_player` as an array (contains the player's currently selected squares)

2. Return value #2: `potential_threats` as an array (contains any possible threats based on the player's currently selected squares against the WINNING_LINES constant

3. Return value #3: `threats` if conditionals are met. (contains all possible threats that are valid and available choices).

I see three candidates for abstracting their logic into separate methods. That would make it far more readable.

def player_selected_squares(brd)
  # => array containing the player's currently selected squares
  # Instructions: iterate through the board and find all hash values that are equal to PLAYER_MARKER and save to a new array.
end


def potential_threats(player_selected_squares)
  # => array containing possible threats based on the player's currently selected squares
  # Instructions: take the return value form player_selected_squares and compare against the WINNING_LINES variable.
end


def valid_threats(potential_threats, available_valid_choices)
  # => array containing all possible threats that are valid and available choices
  # take the return value of the potential_threats and compare against empty squares to choose from.
end

You could assemble all the methods into one method but that seems to defeat the purpose of such abstraction (or does it?). I can look more into that later, however breaking down the method is good practice for when it comes to understanding the logic of the code. This is what I'm all about right now.

Abstracting detect_threats method logic into 3 parts means they affect other parts of the code that call that method currently and pass through their values as well. in the computer_places_piece! method it takes brd and slot which is then currently passed to the detect_threat method that also takes a brd and slot. So in this case it makes sense to keep the detect_threats method in order to keep the parameters in place and not need to change the computer_places_piece method? Let's try that out as a starting point.

It would be a good idea to keep the state of the board available for at least a few seconds (1.. 2?) and display who won in text so there's a moment of reflection, even if it results in a tie.

DEBUG: player_selected_squares is not getting the argument that is declared passed through to the method.
- each chaining method needs to return a value or nil. If the arrays are empty, Ruby still considers them to be truthy so they won't equate to nil. It's best to return the value at the end of each chaining method if the values are not empty instead of nil.
- add the pry binding to explore the return values
- it looks like the crux of the problem is that I have to continue passing the parameters for each call to the chained methods inside of detect_threat.

- now add the sleep (longer) to look at the board and temporarily remove the clear method to keep watch on the game's values.

DEBUGGED: player_selected_squares was not receiving the correct arguments because none were being passed. Although I was passing them through the computer_places_piece! method, the detect_threat method didn't specifically call them. That's very clearly a beginner oversight. Although this gave me the opportunity to understand more deeply how I don't need to call each specific method within the detect_threat method. I can call just the last one and supply the arguments (although this looks ridiculously long).

REFACTOR part 2:
- [x] clean up the extra outputs and untangle the code.
- [x] rename methods that are called within the detect_threat 
- [ ] Look at extracting each loop into its own method as a way of making the action more succint. Or perhaps better to abstract all the logic _within_ the loop, and thereby keep the loop as a way of looping over the method multiple times? 
- [ ] Need to validate integer for user input
