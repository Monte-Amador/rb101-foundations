def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size
    current_num = numbers[counter]
    doubled_numbers << current_num.to_i * 2
    counter += 1
  end
  doubled_numbers
end

num_set = [1,4,2,3,4,5]
p double_numbers(num_set)
