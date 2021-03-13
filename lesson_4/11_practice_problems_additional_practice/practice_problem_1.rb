#[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 1

# Given the array below

# `flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]`

# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# => {"Fred" => 0, "Barney" => 1, "Wilma" => 2, "Betty" => 3, "Pebbles" => 4,
# "BamBam" => 5 }

# get index position for each value
# iterate through array and assign each item as a key and its index as the
# value.
# - each_with_object({}) do |value, hash
# - loop with counter that increases and breaks when same size reaches
# array.size
# - each_with_index gives both the value and index through each iteration. 

new_hash = {}
flintstones.each_with_index do |value, index|
  new_hash[value] = index
end

p new_hash
