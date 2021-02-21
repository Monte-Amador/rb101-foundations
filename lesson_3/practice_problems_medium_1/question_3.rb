=begin
Question 3

Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.
Bonus 1

What is the purpose of the number % divisor == 0 ?
Bonus 2

What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?
=end

def print_factors(number)
  factors = []
  (1..number).each do |v| 
    factors << v if number % v == 0
  end
  factors
end

p print_factors(0)

# Note that my solution was differnet than the provided solution, however I think the takeaway was the same.

# Bonus 1: The purpose is to test if the number leaves no remainder after the quotient division
# Bonus 2: The purpose to implicitly return the factors array