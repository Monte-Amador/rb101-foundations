# [Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)

#### Practice Problem 9

# As we have seen previously we can use some built-in string methods to change the case of a string. A notably missing method is something provided in Rails, but not in Ruby itself...`titleize`. This method in Ruby on Rails creates a string that has each word capitalized as it would be in a title. For example, the string:

# `words = "the flintstones rock"`

# would be:

#`words = "The Flintstones Rock"` Write your own version of the rails `titleize` implementation.

# My own method would be:
# Take: a string
# Split: string into an array
# Iterate: through each item in the array
# Capitalize!: each item
# Join: the array.join(' ')
# Additionally: re-assign the original string if necessary.

words = "the flintstones rock"
def titlecase(str)
  array = str.split
  array.each { |item| item.capitalize! }
  array.join(' ')
end

titlecase(words)
words = titlecase(words)
