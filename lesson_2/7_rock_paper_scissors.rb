VALID_CHOICES = ['Rock', 'Paper', 'Scissors']

def prompt(message)
  Kernel.puts(">> #{message}")
end

prompt("Welcome to #{VALID_CHOICES}!")

loop do # main loop
  user_choice = ''

  loop do # verification loop
    prompt("Please choose one: #{VALID_CHOICES}.")
    user_choice = Kernel.gets().chomp()

    # lowercase_sensitive_input = VALID_CHOICES.map {|str| str.downcase}
    # uppercase_sensitive_input = VALID_CHOICES.map {|str| str.upcase}

    if ( VALID_CHOICES.include?("#{user_choice}".capitalize) )
      break
    else
      puts "Sorry, that is not a valid choice, let's try again."
    end
  end


  computer_choice = VALID_CHOICES.sample()
  prompt("You chose \"#{user_choice.capitalize}\" and the computer chose \"#{computer_choice}\":")

  if (user_choice.capitalize == "Rock" && computer_choice == "Scissors") || (user_choice.capitalize == "Scissors" && computer_choice == "Paper") || (user_choice.capitalize == "Paper" && computer_choice == "Rock")
    puts "You won!"
  elsif (user_choice.capitalize == "Rock" && computer_choice == "Rock") || (user_choice.capitalize == "Scissors" && computer_choice == "Scissors") || (user_choice.capitalize == "Paper" && computer_choice == "Paper")
    puts "It's a tie!"
  else
    puts "The computer won!"
  end

  prompt("Would you like to play again? (y to play again)")
  answer = Kernel.gets().chomp().downcase
  
  break unless answer == 'y'
end

# refactor:
# consolidate