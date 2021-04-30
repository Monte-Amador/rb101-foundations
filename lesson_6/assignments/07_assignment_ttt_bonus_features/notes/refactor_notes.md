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

It would be a good idea to keep the state of the board available for at least a few seconds (1.. 2?) and display who won in text so there's a moment of reflection, even if it results in a tie.
