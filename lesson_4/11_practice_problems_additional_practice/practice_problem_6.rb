# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 6

# Amend this array so that the names are all shortened to just the first three characters:

# `flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)`

# Iterate: through array values
# Cut: 4th and more characters
# Re-Assign each value with first 3 elements of each value

flintstones.map! { |name| name = name[0,3] }
