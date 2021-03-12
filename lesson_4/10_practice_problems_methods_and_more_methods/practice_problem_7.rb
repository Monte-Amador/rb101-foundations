# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 7

# What is the **block**'s return value in the following code? How is it
# determined? Also, what is the return value of `any?` in this code and what
# does it output?
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# Block's return value is true. It's determined by the any? method that
# returns true. 
