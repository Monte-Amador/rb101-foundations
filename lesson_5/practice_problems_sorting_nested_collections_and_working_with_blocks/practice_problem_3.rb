# Practice Problem 3
# For each of these collection objects demonstrate how you would reference the letter `'g'`.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

arr3 = [['abc'], ['def'], {third: ['ghi']}]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# arr1: an array containing 3 elements with last elemetnt being a nested
# array so you would have to reference
arr1[2][1][3] # => 'g'

# arr2: array containing 2 hashes each hash has a symbol for a key followed
# by an array of 3 strings
arr2[1][:third][0] # => 'g'

# arr3: array containing 2 arrays and a hash that contains a symbol for a key
# and an array with one string as a value. Because it's a single string, you
# would also have to specify the integer of the letter you want to reference:
arr3[2][:third][0][0] # => 'g'

# hsh1: contains 3 key value pairs and each key is a string and each value is
# an array of two strings.
hsh1['b'][1]

# hsh2: a single hash made up of 3 keys and 3 inner hashes for values. Each
# inner hash has a string for a key and an integer for a value.
hsh2[:third].key[0]

