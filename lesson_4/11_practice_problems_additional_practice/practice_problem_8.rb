# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

# What happens when we modify an array while we are iterating over it? What would be output by this code?
# `numbers = [1, 2, 3, 4] numbers.each do |number| p number numbers.shift(1) end`

# What would be output by this code?
# `numbers = [1, 2, 3, 4] numbers.each do |number| p number numbers.pop(1) end`

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# The block will typically return its caller [1, 2, 3, 4] after printing out each
# number through each iteration. However since we are mutating the original
# method through each iteration, it looks like returning the caller may in
# fact return an empty array after all the shifts.

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# [1, 2]

# Fascinating Explanation

# first one...

  #  1
  #  3
    

# second one...

  #  1
  #  2
    

# To better understand what is happening here, we augment our loop with some additional "debugging" information:

# `numbers = [1, 2, 3, 4] numbers.each_with_index do |number, index| p "#{index} #{numbers.inspect} #{number}" numbers.shift(1) end`

# The output is:

  #  "0  [1, 2, 3, 4]  1"
  #  "1  [2, 3, 4]  3"
    

# From this we see that our array is being changed as we go (shortened and shifted), and the loop counter used by `#each` is compared against the current length of the array rather than its original length.

# In our first example, the removal of the first item in the first pass changes the value found for the second pass.

# In our second example, we are shortening the array each pass just as in the first example...but the items removed are beyond the point we are sampling from in the abbreviated loop.

# In both cases we see that iterators DO NOT work on a copy of the original array or from stale meta-data (length) about the array. They operate on the original array in real time.
