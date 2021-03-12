[Launch School - an online school for Software
Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 3

# What is the return value of `reject` in the following code? Why?

[1, 2, 3].reject do |num|
  puts num
end

## My answer
# I expect that it will return [1, 2, 3] because the last expression
# evaluates to falsey. Based on the fact that reject returns a new array of
# objects that evaluate to not true i.e. falsey.
# Contrasting the block of code above, if you remove puts and instead call
# `p` then it will return an empty array.
