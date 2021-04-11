# Practice Problem 4
# For each of these collection objects where the value `3` occurs, demonstrate how you would change this to `4`.

arr1 = [1, [2, 3], 4]

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

hsh1 = {first: [1, 2, [3]]}

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

# 1. arr1 is an multi-dimensional array. Therefore we need to address element
# [1] for the inner array and the index of [1] for the number 3. A simple
# reassignment would be a destructive way of going about it.
arr1[1][1] = 4

# 2. arr2 is a multi-dimensional array with a subset of two hashes and one
# integer. Similar to arr1 example, a simple reassignment would work
# (destructively).
arr2[2] = 4

# 3. hsh1 is a single hash with a symbol for the key and a nested array for
# the value. The number to change is located in the array at index [2][0]:
hsh1[:first][2][0] = 4

# 4. hsh2 is a hash made up of two different types of hashes. The first uses
# an array with a string as the key and the value is a hash with a symbol for
# the key, and an array for the value. The second hash item has two hashes
# nested inside with a symbol for the first key and an array for its value,
# the second inner hash has a symbol for the key and an integer for a value.
# Finally, the last hash has
# uses a string for the symbol and the value is an integer. 
hsh2[['a']][:a][2] = 4
