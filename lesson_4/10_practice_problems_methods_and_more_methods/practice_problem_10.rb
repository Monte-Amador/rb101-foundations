# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 10
# What is the return value of the following code? Why?
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# The return value is [1, nil, nil] because on the first iteration it num > 1
# equates to false, and therefore falls back on the else statement of making
# the implicit return value of the object num which. So on the first
# iteration, num is the actual returned value from the block. The following
# two evaluate to nil due to being true in the if statement, however the puts
# method doesn't return anything. 
