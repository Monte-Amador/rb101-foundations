# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 7

# Create a hash that expresses the frequency with which each letter occurs in this string:

# `statement = "The Flintstones Rock"`

# ex:
# `{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }`


# Split: statement to create an array of characters
# Remove: white space in split array?
# Iterate: through array and count frequency of each element that is not a
# single whitespace.
  # This would be a good try with each_with_object({}) do | letter, hash|

# Upon testing, a regular loop could do this.
statement = "The Flintstones Rock"
array = statement.split('')
array.delete(' ')
frequency_hash = {}
counter = 0
loop do
  frequency = array.count(array[counter])
  frequency_hash[array[counter]] = frequency
  counter += 1
  break if counter == array.size
end
# Although I actually feel my method was a little easier to understand, I see
# the potential of combining the provided solution with mine too. I could
# replace the counter, loop with a simple #each method.
array.each do |letter|
  frequency = array.count(letter)
  frequency_hash[letter] = frequency
end

