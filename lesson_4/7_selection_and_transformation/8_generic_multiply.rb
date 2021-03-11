def multiply(numbers_arr, multiplier)
  transformed_arr = []
  counter = 0
  loop do
    break if counter == numbers_arr.size
    current_number = numbers_arr[counter]
    current_number *= multiplier
    transformed_arr << current_number
    counter += 1
  end
  transformed_arr
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]
