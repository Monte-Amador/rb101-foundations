puts "=> Select Fruits Method:"
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(hsh)
  selected_fruits = {}  
  hsh.each do |key, value|
    if value == 'Fruit'
      selected_fruits[key] = value    
    end
  end
  selected_fruits
end

puts select_fruit(produce) # => {"apple" => "Fruit", "pear" => "Fruit"}

puts "=> Double Numbers Method:"

def double_numbers(arr)
  counter = 0
  doubled_numbers = []
  loop do 
    break if counter == arr.size
    doubled_numbers << (arr[counter] * 2)
    counter += 1
  end
  p doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers(my_numbers)

puts "=> Double Numbers Mutate Method:"
def double_numbers_mut(arr)
  counter = 0
  loop do 
    break if counter == arr.size
    arr[counter] = (arr[counter] * 2)
    counter += 1
  end
  p arr
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers(my_numbers)
