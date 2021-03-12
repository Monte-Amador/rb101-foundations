[Launch School - an online school for Software
Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 4

# What is the return value of `each_with_object` in the following code? Why?
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

## My Answer
# I imagine {'cat' => 'cat'} because hash[cat[0]] = cat would be the last
# expression in the block's iteration. It keeps reassigning 0 as the index
# which is strange since hashes don't work with the index format. In fact I
# expect it to return nil since thinking about it at more length, it seems
# that this is an error.

# After re-reading the answer, I see I had assumed incorrectly although I
# followed the answer. I simply forgot about being able to return an index
# from a string.  
