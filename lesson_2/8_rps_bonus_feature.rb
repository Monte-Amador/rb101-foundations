VALID_CHOICES = {
  rock: ['r', 'rock'],
  paper: ['p', 'paper'],
  scissors: ['sc', 'scissors'],
  lizard: ['l', 'lizard'],
  spock: ['sp', 'spock']
}

GAME_TERMS = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock']
}

def prompt(message)
  Kernel.puts(">> #{message}")
end

def validate_input(str)
  match = VALID_CHOICES.select { |_key, val| val.include?(str) }
  match.to_a().flatten().first().to_s if match != {}
end

def display_valid_choices
  titles = VALID_CHOICES.select { |_k, v| v }
  choices = titles.to_a.map { |arr| arr[1][1].capitalize }
  choices.join(', ')
end

def display_invalid_prompt
  <<-MSG
  Sorry, that was not a valid choice.
  Please choose one of the following:
  #{display_valid_choices}
  (hint: you can also use the abbreviations:
  'R', 'P', 'SC', 'L', 'SP' respectively).
  MSG
end

def display_results(user, computer)
  return "Player won!" if GAME_TERMS[:"#{user}"].include?("#{computer}")
  return "Computer won!" if GAME_TERMS[:"#{computer}"].include?("#{user}")
  "It's a tie!"
end

prompt("Hello, let's play a game.")
score = { player: 0, computer: 0 }

loop do # main loop
  user_choice = ''
  computer_input = GAME_TERMS.to_a.flatten.sample()
  loop do # validation loop
    prompt("Please choose one: #{display_valid_choices}")
    user_input = gets.chomp.downcase
    user_choice = validate_input(user_input)
    break unless user_choice.nil?
    prompt(display_invalid_prompt)
  end

  prompt("You chose: #{user_choice.capitalize} and the computer chose #{computer_input.capitalize}:")

  prompt(display_results(user_choice, computer_input))

  score[:player] += 1 if display_results(user_choice, computer_input).include?("Player")
  score[:computer] += 1 if display_results(user_choice, computer_input).include?("Computer")
  score.each { |key, val| prompt("#{key} => #{val}") }
  
  break if (score[:player] == 5) || (score[:computer] == 5)
  prompt("Wanna play again? (y to play again)")
  answer = gets.chomp
  break unless answer.downcase == "y"
end

prompt("Thank you for playing, the final score is: ")
score.each { |key, val| prompt("#{key} => #{val}") }
