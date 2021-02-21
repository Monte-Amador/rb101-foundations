=begin
## Question 1

What would you expect the code below to print out?

  numbers = [1, 2, 2, 3]
  numbers.uniq

puts numbers
=end

## Answer
I would expect to see the following:
  1
  2
  2
  3
due to the fact that `#uniq` is not mutating the caller and we are therefore
calling the puts method with the numbers variable as an argument. Puts by
default returns a string.

