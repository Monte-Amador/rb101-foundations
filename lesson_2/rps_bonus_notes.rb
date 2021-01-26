=begin
# Keep score of the player's and computer's wins. When either the player or computer reaches five wins, the match is over, and the winning player becomes the grand winner. Don't add your incrementing logic to display_results. Keep your methods simple; they should perform one logical task — no more, no less.

# create counter for user and computer scores
- define method scoreboard
- create a hash to hold score = {:user => 0, :computer => 0}
- increment hash value += 1 when user or computer wins
- pass displayed results to scoreboard and test who won to see who wins and push to #score[:key]

# encase in master loop as way for exiting game
# add score announcement (maybe to current statement that asks if you want to continue)














=end

VALID_CHOICES = {rock: ['r', 'rock'], paper: ['p', 'paper'], scissors: ['sc', 'scissors'], lizard: ['l', 'lizard'], spock: ['sp', 'spock']}

TERMS = {rock: ['scissors', 'lizard'], paper: ['rock', 'spock'], scissors: ['paper', 'lizard'], lizard: ['spock', 'paper'], spock: ['scissors', 'rock']}

def prompt(message)
  Kernel.puts(">> #{message}")
end

def validate_input(str)
  match = VALID_CHOICES.select {|key, val| val.include?(str)}
  if match != {}
    match.to_a().flatten().first().to_s
  end
end

def display_valid_choices()
  titles = VALID_CHOICES.select {|k,v| v}
  new_titles = titles.to_a
  refactored_choices = new_titles.map {|arr| arr[1][1].capitalize}
  refactored_choices.join(', ')
end

def display_invalid_prompt() 
  <<-EOF
  Sorry, that was not a valid choice.
  Please choose one of the following:
  #{display_valid_choices}
  (hint: you can also use the abbreviations: 
  'R', 'P', 'SC', 'L', 'SP' respectively).
  EOF
end

def display_results(user, computer)
  # loop do
    return "Player won!" if TERMS[:"#{user}"].include?("#{computer}")
    return "Computer won!" if TERMS[:"#{computer}"].include?("#{user}")
    return "It's a tie!"
  # end
end 

prompt("Hello, let's play a game.")

loop do # main loop
  user_choice = ''
  computer_input = TERMS.to_a.flatten.sample()
  
  loop do # user validation loop
    prompt("Please choose one: #{display_valid_choices}")
    user_input = gets.chomp.downcase
    user_choice = validate_input(user_input)
    # puts validate_input(user_input).inspect
    break unless user_choice == nil
    prompt(display_invalid_prompt)
  end

  prompt("User chose: #{user_choice.capitalize} and Computer chose #{computer_input.capitalize}:")

  prompt(display_results(user_choice, computer_input))

  prompt("Wanna play again? (y to play again)")
  answer = gets.chomp
  break unless answer.downcase == "y"
end

prompt("Thank you for playing")
