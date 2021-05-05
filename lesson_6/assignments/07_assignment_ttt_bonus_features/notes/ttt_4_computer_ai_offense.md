The defensive minded AI is pretty cool, but it's still not performing as well as it could because if there are no impending threats, it will pick a square at random. We'd like to make a slight improvement on that. We're not going to add in any complicated algorithm (there's an extra bonus below on that), but all we want to do is piggy back on our `find_at_risk_square` from bonus #3 above and turn it into an attacking mechanism as well. The logic is simple: if the computer already has 2 in a row, then fill in the 3rd square, as opposed to moving at random.

We need a way to detect a potential winning scenario for the computer with the current state of the board.

After that, if it is the computer's turn then choose the 3rd square for the win.

- [x] player_squares(brd) method has the right logic to pipe to a computer version. 
- [x] potential_win(player_range) currently returns an array (potential_threats) of the lines that contain 2 consecutive matching marks (currently player). This can be adapted to return potential_winning values for the computer matching marks.
- [x] on first considerations, it looks like once it is the computer's turn, we should first look for a winning move, then a defensive move. currently we test to see if there is a threat to make the defensive move and move accordingly if it is. We can adapt a conditional system to first look for potential wins and if none exist look to see if the computer needs to move defensively. 

- [x] if the potential_win can be used interchangably then we need to rename it accordingly. Like potential_action/attention

- [x] don't forget to create a method to validate the integer input 

## Testing Phase
Overall I'm happy with the progress. I knnwo that I can perhaps integrate the separate methods into one but i like where i'm at and understanding how to name them correctly which helps me understand the logical path of the application.

- [x] I've noticed that the joiner method seems to be adding a space after the comma
- [x] rename the detect_threat to detect_defense
