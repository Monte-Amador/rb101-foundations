=begin
Question 2

The result of the following statement will be an error:

    puts "the value of 40 + 2 is " + (40 + 2)

Why is this and what are two possible ways to fix this?
=end

puts "the value of 40 + 2 is " + (40 + 2).to_s

=begin
At first, this raises a TypError (no implicit conversion of Integer into String) so it's having a problem with the integer operation. This is due to the fact that #puts creates a string out of everything it outputs. 

One solution is to directly convert the integer operation into a string with the Integer#to_s

The other solution I couldn't come up with but the solution of using string interpolation is an elegant surprise.
=end