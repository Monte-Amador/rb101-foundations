=begin
Question 2

What is the result of the last line in the code below?
  greetings = { a: 'hi' }
  informal_greeting = greetings[:a]
  informal_greeting << ' there'

  puts informal_greeting  #  => "hi there"
  puts greetings

=end

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings # this too will change to "hi there"