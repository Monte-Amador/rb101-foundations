def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0
  
  loop do
    break if counter == numbers.size
    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    # current_number *= 2 if current_number.odd?
    doubled_numbers << current_number 
    counter += 1
  end
  doubled_numbers
end
num = [1, 4, 3, 7, 2, 6] # => [1, 8, 3, 14, 2, 12]
p double_odd_numbers(num)
