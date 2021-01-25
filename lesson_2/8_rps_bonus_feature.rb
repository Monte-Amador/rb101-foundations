VALID_CHOICES = ['Rock', 'Paper', 'Scissors']

VALID_ABBREVIATIONS = ['R', 'P', 'S']

TERMS = {rock: ['scissors', 'lizard'], paper: ['rock', 'spock'], scissors: ['paper', 'lizard'], lizard: ['spock', 'paper'], spock: ['scissors', 'rock']}

def prompt(message)
  Kernel.puts(">> #{message}")
end

def winner(user_input, computer_input)
  if TERMS[:"#{user_input}".downcase].include?(computer_input.downcase)
    prompt("Player won!")
  elsif TERMS[:"#{computer_input}".downcase].include?(user_input.downcase)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

prompt("Welcome to #{VALID_CHOICES.join(', ')}!")
loop do # main loop
  user_choice = ''
  
  loop do # verification loop
    prompt("Please choose one: #{VALID_CHOICES.join(', ')}.")
    user_choice = Kernel.gets().chomp().capitalize()
    puts user_choice.inspect
    if VALID_CHOICES.include?(user_choice) || VALID_ABBREVIATIONS.include?(user_choice)

      break
    else
      prompt("Sorry, that is not a valid choice, let's try again.")
    end
  end

  computer_choice = VALID_CHOICES.sample()
  
  prompt("You chose \"#{user_choice}\" and the computer chose \"#{computer_choice}\":")

  winner(user_choice, computer_choice)
  
  prompt("Would you like to play again? (y to play again)")
  answer = Kernel.gets().chomp().downcase
  break unless answer == 'y'
end

prompt("Okay, thanks for playing! Come again soon.")
