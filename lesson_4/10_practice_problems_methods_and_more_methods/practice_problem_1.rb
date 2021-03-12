# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)
# What is the return value of the `select` method below? Why?

[1, 2, 3].select do |num|
  num > 5
  'hi'
end

## My Answer
# Given that `select` returns a truthy expression from the block, I think it
# will be ['hi', 'hi', 'hi'] although originally I thought it would return an
# empty array.

## Revised Answer
# I see now that it returns [1, 2, 3] which makes sense since 'hi' evaluates
# to true and select is selecting each element.
