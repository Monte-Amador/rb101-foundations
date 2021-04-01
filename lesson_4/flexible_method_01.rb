puts " => General Select Method:"
produce = {
  'apples' => 'Fruit',
  'broccoli' => 'Vegetable',
  'pear' => 'Fruit',
  'asparagus' => 'Vegetable',
  'chocolate' => 'Snack'
}
# Notes:
# Match all values with selection_criteria given
# Return a new list with key, value pairs from only the criteria specified

def general_selection(product_list,selection_criteria)
  product_keys = product_list.keys
  criteria_selection = {}
  counter = 0
  loop do
    break if counter == product_list.size
    if product_list[product_keys[counter]] == selection_criteria
      criteria_selection[product_keys[counter]] = product_list[product_keys[counter]]
    end
    counter += 1
  end
  criteria_selection  
end

puts general_selection(produce, 'Vegetable')
