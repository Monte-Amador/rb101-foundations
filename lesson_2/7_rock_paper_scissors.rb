VALID_CHOICES = ['Rock', 'Paper', 'Scissors']

def prompt(message)
  Kernel.puts(">> #{message}")
end

def display_results(player, computer)
  if (player == "Rock" && computer == "Scissors") || (player == "Scissors" && computer == "Paper") || (player == "Paper" && computer == "Rock")
    prompt "You won!"
  
  elsif (player == "Rock" && computer == "Rock") || (player == "Scissors" && computer == "Scissors") || (player == "Paper" && computer == "Paper")
    prompt "It's a tie!"
  
  else
    prompt "The computer won!"
  end
end



prompt("Welcome to #{VALID_CHOICES.join(', ')}!")

loop do # main loop
  user_choice = ''

  loop do # verification loop
    prompt("Please choose one: #{VALID_CHOICES.join(', ')}.")
    user_choice = Kernel.gets().chomp().capitalize

    if ( VALID_CHOICES.include?("#{user_choice}") )
      break
    else
      puts "Sorry, that is not a valid choice, let's try again."
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
