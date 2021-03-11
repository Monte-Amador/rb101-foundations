produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(hsh)
  hash_keys = hsh.keys
  selected_fruit = {}
  counter = 0
  loop do 
    break if counter == hsh.size
    current_item = hash_keys[counter]
    current_value = hsh[current_item]
    if current_value == 'Fruit'
      selected_fruit[current_item] = current_value
    end
    counter += 1
  end
  selected_fruit
end


p select_fruit(produce)
