# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 5

# In the array:

# `flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)` 
# Find the index of the first name that starts with "Be"

# Given: flinstones is an array
# Iterate: through the array's values
# Compare: if first two elements of string == "Be"
# Return: idex upon first match

index_string = ""
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.each_with_index do |name, index|
  if name[(0..1)] == "Be"
    index_string = index
  end
end

p index_string

# I notice that although my solution works, each_with_index will not return
# the value because that's the nature of the method `each_with_index' so the
# provided solution is far better in this case. Specifically with the quote
# below

# "When both argument object and a block are given, calls the block with each
# successive element; returns the index of the first element for which the
# block returns a truthy value"
