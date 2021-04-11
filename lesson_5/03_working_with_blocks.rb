[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end

# => 1
# => 3
# => [[1, 2], [3, 4]]

=begin
Line 1: Call the `Array#each` method to iterate through the multi-dimensional
array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and
assigned the variable `arr`. The `Array#first` method is called on `arr` and
returns the object at index `0` of the current array - in this case the
integers `1` and `3` respectively.

The `puts` method outputs a string representation of the integer. `puts`
returns `nil` and, since it is the last evaluated statement within the block,
the return value of the block is `nil. `each`, however doesn't do anything
with the return value of the block as the return value of `each` is the
calling object, in this case the nested array [[1, 2], [3, ]] is returned.
=end

