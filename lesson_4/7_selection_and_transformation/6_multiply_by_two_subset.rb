def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0
  
  loop do
    break if counter == numbers.size
    current_number = numbers[counter]
    current_number *= 2 if current_number.odd?
    doubled_numbers << current_number 
    counter += 1
  end
  doubled_numbers
end
num = [1,2,3,4,5] # => [2, 2, 6, 4, 10]
p double_odd_numbers(num)
