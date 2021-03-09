produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(hsh)
  hsh.select { |_k,v| v == 'Fruit' }
end
p produce
p select_fruit(produce)
