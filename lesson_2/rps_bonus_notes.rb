TERMS = {rock: ['scissors', 'lizard'], paper: ['rock', 'spock'], scissors: ['paper', 'lizard'], lizard: ['spock', 'paper'], spock: ['scissors', 'rock']}

VALID_CHOICES = {rock: ['r', 'rock'], paper: ['p', 'paper'], scissors: ['sc', 'scissors'], lizard: ['l', 'lizard'], spock: ['sp', 'spock']}

user_choice = ''

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

user_input = gets.chomp.downcase
if validate_input(user_input)
  validate_input(user_input)
else
  puts(display_invalid_prompt)
end


user_choice = validate_input(user_input)
computer_input = TERMS.to_a.flatten.sample()





puts"User chose: #{user_choice} and Computer chose #{computer_input}:"
if TERMS[:"#{user_choice}"].include?(computer_input)
  puts "Player won!"
elsif TERMS[:"#{computer_input}"].include?(user_choice)
  puts "Computer won!"
else
  puts "It's a tie!"
end

# def test(hi)
#   if VALID_ABBREVIATIONS.include?(hi.capitalize)
#     VALID_CHOICES.each do |choice|
#       choice.split('').first == hi.capitalize
#     end
#   end
# end

# if VALID_ABBREVIATIONS.include?(user_input.capitalize)
#   VALID_CHOICES.each do |choice|
#     choice if choice.split('').first == user_input.capitalize
#   end
# end
