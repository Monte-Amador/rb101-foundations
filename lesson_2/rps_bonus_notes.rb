=begin
# Keep score of the player's and computer's wins. When either the player or computer reaches five wins, the match is over, and the winning player becomes the grand winner. Don't add your incrementing logic to display_results. Keep your methods simple; they should perform one logical task — no more, no less.

# create counter for user and computer scores
- [x]  define method scoreboard
- [x] create a hash to hold score = {:player => 0, :computer => 0}
- [x] increment hash value += 1 when user or computer wins
- [ ] pass results to scoreboard and test who won to see who wins and push to #score[:key]

- [ ] encase in master loop as way for exiting game when either player reaches 5
- [x] add score announcement (maybe to current statement that asks if you want to continue)

This was a great challenge that encompassed everything that I've learned thus far. I was actually surprised to see how far I got with the bit I know so far. But as painstaking slow as it was, it was completely worth it as i was concerned I wouldn't be able to get enough practice in during lesson 2. I laugh at myself now but am much better for it. I really enjoy this type of growth.

Takeaways:
- hashes: the use of hashes in this assignment was really encouraging. I was surprised how quickly I got the logic piped into the hashes for a first draft of the idea.

- user_input: I wanted a way for the user to enter one letter or the word, regardless what case it was in. I feel it is a better user experience that way. In order to do this, I created another hash for the user input and modeled the logic from the hash that I created to display the winning combinations. This gave me the chance to work with the #select method on the hash and create a new hash to work on. I'm sure there are far more elegant ways to handle this kind of logic, but these served as good exercises.
- Tracking score with the scoreboard method: this one took the longest.

=end

VALID_CHOICES = {rock: ['r', 'rock'], paper: ['p', 'paper'], scissors: ['sc', 'scissors'], lizard: ['l', 'lizard'], spock: ['sp', 'spock']}

GAME_TERMS = {rock: ['scissors', 'lizard'], paper: ['rock', 'spock'], scissors: ['paper', 'lizard'], lizard: ['spock', 'paper'], spock: ['scissors', 'rock']}
def prompt(message)
  Kernel.puts(">> #{message}")
end

def validate_input(str)
  match = VALID_CHOICES.select {|key, val| val.include?(str)}
  match.to_a().flatten().first().to_s if match != {}
end

def display_valid_choices()
  titles = VALID_CHOICES.select {|k,v| v}
  choices = titles.to_a.map {|arr| arr[1][1].capitalize}
  choices.join(', ')
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
    return "Player won!" if GAME_TERMS[:"#{user}"].include?("#{computer}")
    return "Computer won!" if GAME_TERMS[:"#{computer}"].include?("#{user}")
    return "It's a tie!"
end

def scoreboard(str)
  # move extraneous logic here after sleep
end

prompt("Hello, let's play a game.")

score = {player: 0, computer: 0}
print_current_score = ''
loop do # main loop
  user_choice = ''
  
  # have to move computer_input into the main loop to avoid a series of same answers which seems strange
  computer_input = GAME_TERMS.to_a.flatten.sample()
  
  loop do # validation loop
    prompt("Please choose one: #{display_valid_choices}")
    user_input = gets.chomp.downcase
    user_choice = validate_input(user_input)
    break unless user_choice == nil
    prompt(display_invalid_prompt)
  end

  prompt("You chose: #{user_choice.capitalize} and the computer chose #{computer_input.capitalize}:")

  prompt(display_results(user_choice, computer_input))

  score[:player] += 1 if display_results(user_choice, computer_input).include?("Player")
  score[:computer] += 1 if display_results(user_choice, computer_input).include?("Computer")
  score.each {|key, val| prompt("#{key} => #{val}")}
  
  score
  
  break if (score[:player] == 5) || (score[:computer] == 5)
  prompt("Wanna play again? (y to play again)")
  answer = gets.chomp
  break unless answer.downcase == "y"

end

prompt("Thank you for playing, the final score is: ")
score.each {|key, val| prompt("#{key} => #{val}")}
