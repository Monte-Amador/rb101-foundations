arr = ['10', '11', '9', '7', '8']

# Practice Problem 1: How would you order this array of number strings by
# descending numeric value?  Output Example # => ['11', '10', '9', '8', '7'] 
#
# Notes:
# `arr` is an array made up of strings, not numbers
# strings are compared by characters, so `'11' <=> '09' # => 1 '11' is
# greater` due to the fact that 0 comes before 1. Similarly `'11' <=> '105'
# => 1` also sees `'11'` as being greater yet `'11' <=> '7' # => -1` shows us
# that `'11'` is seen as lesser.

# Methods:
# `Enumerable#sort_by` can generate the set of keys, in this case we can turn
# the individual object to integers and return the value of the array in
# order of numeric integers.

# the `Array#sort` method can evaluate each element pair, so we can swap the
# pair to output the descending numerical value.
# "With a block, calls the block with each element
# pair; for each element pair `a` and `b`, the block should return an
# integer:"

# It also follows that if we can call the `.to_i` on each of the elements
# then we can also sort in a descending, numeric based way.

output = arr.sort do |a, b|
  b.to_i <=> a.to_i
end

p output
