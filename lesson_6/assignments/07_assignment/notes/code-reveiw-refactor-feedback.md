## User Experience/Game Play

- [x] It's a good idea to clear the screen at the start of the game in case there is already a significant amount of text in the console.
- [x] I like that you let the player choose who goes first and the number of rounds they want to play! This is a good segue into the game itself. 👏
- [x] Good work displaying the current score for both the player and computer throughout the game.
- [x] Consider making the numberings of the board squares always visible on the board, unless a marker is placed on that square.
- [x] Perhaps only allow integer values as valid square numbers. As-is, values like `2.2` are considered valid.
- [x] Great job displaying the overall winner of the tournament at the end.
- [x] Another feature to possibly include is letting the player choose their marker. There is some input validation required for this as well.
- [x] I think there could be a little more visual separation between the player markers, the current scores, and the list of available squares.

## Rubocop

- [x] No offenses; that's what I like to see!

## Source Code
::LEFT-OFF:: 
- [x] Your main game loop is very nicely abstracted and your methods are focused and single-purpose. Awesome work!
 
- [x] I like the way you've abstracted the user input validation at different levels; good job thinking through this. 👌
 
- [x] Nice use of heredocs for the formatting of multi-line strings.
- [x] You've made good use of `?` and `!` to indicate when a method returns a boolean or performs a destructive action.
- [x] The logic in `valid_offense` and `valid_defense` appears to be very similar. Could you instead just define the method once and pass the appropriate object as the second argument when you want to check for valid offense/defense? The same goes for the `detect_offense` and `detect_defense` methods. There seems to be an opportunity to reduce the duplication of logic here.
- [x] Instead of using comments, let the code speak for itself through the use of well-named variables and methods. I think you've generally done a good job of this, though there are a few areas where there could be more clarity around the method/variable names. e.g.,
    - [x] `selection` could be `selected_squares` (just like the local variable name you used!)
    - [x] `priority` could be something more descriptive
    - [x] `attention` within `priority` could also be more descriptive
    - [x] `select_five` could be `select_square_five` or `select_middle_square`

- [x] Consider using constants for some of the values like the array passed to `ask_how_many_rounds` on line 498 and the array passed to `ask_play_again` on line 508. This will make it easy to update these values in the future, since you'd only need to change them in one place.


## Overall Thoughts

It looks like you have a great game of TTT, Monte! I like that you've made the player experience customizable by allowing the player to choose who goes first and the number of rounds they want to play. There are a few nit-picky items related to the source code that you can address in the refactor, but overall I think this is a job well done!

— Mia

code folding with global in vim:
`:g/\[x\]/norm zf%` will fold all lines that contain a [x] block



- [x]  abstract the case into its own method and pass that return value from method to the marker_preference variable
- [x]  got it all working with the exception if the player chooses random and then chooses x as the marker and the computer goes first, the computer becomes x
- [x]  computer going first overrides the player marker choice.
- [x]  test for case sensitivity

## Final Touches
- [x] double check all methods are focused and single-purpose
- [x] double check the detection methods for single-purpose focus
- [x] double check the constants and any stray/duplicate variables that could be converted
- [ ] rubocop
- [x] ::LEFT-OFF:: with passing the markers constant array values to represent the player1_marker
- [ ] maybe think about moving the ask_who_goes_first hash for valid inputs into a constant too?
