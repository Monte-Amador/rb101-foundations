[Launch School - an online school for Software
Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 2

# How does `count` treat the block's return value? How can we find out?

['ant', 'bat', 'catepillar'].count do |str|
  str.length > 4
end

## My Answer
# The return value should be 1. Count is returning the number of elements
# that are truthy in the block.
