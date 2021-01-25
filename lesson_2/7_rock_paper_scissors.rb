VALID_CHOICES = ['Rock', 'Paper', 'Scissors']

def prompt(message)
  Kernel.puts(">> #{message}")
end

def win?(first, second)
  (first == "Rock" && second == "Scissors") ||
    (first == "Scissors" && second == "Paper") ||
    (first == "Paper" && second == "Rock")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("The computer won!")
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
    if VALID_CHOICES.include?(user_choice)
      break
    else
      prompt("Sorry, that is not a valid choice, let's try again.")
    end
  end

  computer_choice = VALID_CHOICES.sample()
  
  prompt("You chose \"#{user_choice}\" and the computer chose \"#{computer_choice}\":")
  display_results(user_choice, computer_choice)
  
  prompt("Would you like to play again? (y to play again)")
  answer = Kernel.gets().chomp().downcase
  break unless answer == 'y'
end

prompt("Okay, thanks for playing! Come again soon.")
