#[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 3

# In the age hash:

# `ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }`

# remove people with age 100 and greater.

#### DESTRUCTIVE APPROACH
# Get age values
# Compare age values >= 100
# Delete (mutate) key,value pairs.  
# USING `Hash#delete_if` METHOD
  # If a block given, calls the block with
  # each key\-value pair; deletes each entry for which the block returns a
  # truthy value; returns `self`:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.delete_if { |_,value| value >= 100 }

# This returns the now mutated `ages` hash with a value of => {"Herman"=>32,
# "Lily"=>30, "Eddie"=>10}

#### NON-MUTATING APPROACH 
# Get age values
# Compare age values < 100
# Save to new hash 
# USING `Hash#select` METHOD
  # Returns a new Hash object whose entries are those for which the block
  # returns a truthy value:


filtered_ages = ages.select { |key, value| value < 100 }
# The filtered_ages variable contains the truthy values of the `select`
# block, in this case all values < 100.

# Note that the provided solution using the `.keep_if` method is comparable
# to the approach I outline using the `delete_if` method.
