# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 4

# Pick out the minimum age from our current Munster family hash:

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
# "Marilyn" => 22, "Spot" => 237 }

# Get values -> ages.values => [32, 30, 5843, 10, 22, 237 ]
# Compare values
  # assign `minimum_age` variable to initial index value -> `ages.values[0]` => 32
  # iterate through array and compare each value to variable
  # if new value is less than variable re-assign variable
  # -> `ages.values.each { |num| minimum_age = num if num < minimum_age }` =>
  # `minimum_age = 10'
  # return variable `minimum_age`



ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
minimum_age = ages.values[0]
ages.values.each { |num| minimum_age = num if num < minimum_age }
p minimum_age

# So the provided solution was a surprise and a lesson to know that the
# `Array#min` is not on the Hash docs. Very cool.
