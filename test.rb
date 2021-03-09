def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0
  
  loop do
    break if counter == numbers.size
    current_number = numbers[counter]
    current_number *= 2 if numbers[counter].odd?
    doubled_numbers << current_number
    counter += 1
  end
end  

num = [1,2,3,4,5] #=> [1,4,3,8,5]
p double_odd_indices(num)
