def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size
    numbers[counter] *= 2
    counter += 1
  end
 numbers 
end

num_set = [1,4,2,3,4,5]
p double_numbers!(num_set)
