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
  match.to_a().flatten().first().to_s() if match != {}
end

def display_valid_choices
  titles = VALID_CHOICES.select { |_k, v| v }
  choices = titles.to_a().map { |arr| arr[1][1].capitalize }
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

def results(user, computer)
  if GAME_TERMS[:"#{user}"].include?(computer.to_s)
    "Player won!"
  elsif GAME_TERMS[:"#{computer}"].include?(user.to_s)
    "Computer won!"
  else
    "It's a tie!"
  end
end

def update_score(score_hash, results_string)
  score_hash[:player] += 1 if results_string.include?("Player")
  score_hash[:computer] += 1 if results_string.include?("Computer")
end

def clear_screen
  system('clear') || system('cls')
end

welcome_prompt = <<~MSG
Welcome to #{display_valid_choices}!
Please enter your name:
MSG
prompt(welcome_prompt)

name = ''
loop do
  name = Kernel.gets().chomp().strip()
  if name.empty?()
    prompt("Hmmm, sorry, please enter a valid name.")
  else
    break
  end
end

begin_game_prompt = <<MSG
Alright then #{name},
let's play a match, best of 5 wins!!!
MSG
prompt(begin_game_prompt)

score = { player: 0, computer: 0 }
loop do # main
  user_choice = ''
  computer_input = GAME_TERMS.to_a().flatten().sample()
  loop do # validation
    prompt("Please choose one: #{display_valid_choices}")
    user_input = gets().chomp().downcase
    user_choice = validate_input(user_input)
    clear_screen
    break unless user_choice.nil?()
    prompt(display_invalid_prompt)
  end

  summary_prompt = <<~MSG
  #{name} chose: #{user_choice.capitalize}
  and the COMPUTER chose: #{computer_input.capitalize}
  MSG
  prompt(summary_prompt)
  
  results_output = results(user_choice, computer_input)
  update_score(score, results_output)
  if (score[:player] < 5) && (score[:computer] < 5)
    prompt(results_output)
    prompt("Current Scores:")
    score.each { |key, val| prompt("#{key} => #{val}") }
  end
  break if (score[:player] == 5) || (score[:computer] == 5)
  invite_to_continue_prompt = <<~MSG
  Shall we continue #{name}?
  (Press y to play another round
  or any other key to end).
  MSG
  prompt(invite_to_continue_prompt)
  
  answer = gets().chomp()
  break unless answer.downcase == "y" || answer.downcase == "yes"
end

prompt("#{name} won the match!") if score[:player] == 5
prompt("Computer won the match!") if score[:computer] == 5
prompt("Thank you for playing #{name}, the final score is: ")
score.each { |key, val| prompt("#{key} => #{val}") }
