initialize_users
display_welcome_message
ask_who_goes_frist
create_users
ask_how_many_rounds
display_match_rules
initialize_score
intialize_board
round_loop
display_match_summary
ask_play_again
display_closing

=============================
## init
reset_local_var
initialize_users
intialize_board
display_board
intialize_score

## retrieve/inspect
joiner_iteration
validate_joiner_array => toss?
joiner
validate integer_input
integer_in_range
string_in_range
validate_user_input
empty_squares
board_full
someone_won
detect_winner
match_winner
selection
priority
valid_offense
detect_offense
valid_defense
detect_defense
select_five

## output
display_error
display_invalid_choice
display_welcome_message
display_match_rules
display_match_summary
display_round_standings
display_score
display_available_choices
display_closing

## user input
ask_who_goes_first
ask_how_many_rounds
ask_play_again

## modify values
create_user_one
create_user_two
establish_user_order
computer_chooses
assign_users
update_score
player_places_piece
computer_places_piece
first_player
second_player
iterate_users 
display_players_markers
round_loop

## Example
I would like to order the methods in a way where you can read the flow of the progam either from bottom to top or top to bottom since the game logic will be at the bottom. For example, currently round_loop is above the game logic and moving up you can see user_iteration which calls the first and second player which calls the user_places_piece, etc. This is what you want.
- [x] make sure to go through any last refactor notes
