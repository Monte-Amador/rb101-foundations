=begin
#### Question 4

The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

  numbers = [1, 2, 3, 4, 5]

What do the following method calls do (assume we reset `numbers` to the original array between method calls)?

  numbers.delete_at(1)
  numbers.delete(1)
=end

numbers = [1, 2, 3, 4, 5]

puts numbers.delete_at(1)
puts numbers.delete(4)
puts numbers
