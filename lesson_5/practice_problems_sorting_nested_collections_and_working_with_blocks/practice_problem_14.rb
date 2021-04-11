# Practice Problem 14 Given this data structure write some code to return an
# array containing the colors of the fruits and the sizes of the vegetables.
# The sizes should be uppercase and the colors should be capitalized.

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# The return group should look like this:
# => [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

# NOTES:
# HSH is a nested hash with 5 key, value pairs. 
## Each key is a string
## Each value is its own hash with 3 key, value pairs
### Each key is a symbol
### Each value is a string, or array (of strings).

# RETURN group is an outer multi-dimensional array with 5 indices
### COLORS are separated in their own array and call the Array#capitalize
### method.
## SIZES are simple strings in the outer array and call the String#upcase
## method  
#
# MAP: Using Enumerable#map on the hsh, we create an outer block to iterate through each inner
# hash nested as its own array. This gives us the advantage of specifying the
# index that we want to work with (e.g. [1] in this case) and call the
# Array#select method to return the inner block's selection criteria to the outer block
#  
# EACH_VALUE is also a way to forego the initial key in the hsh, however the return
# value of Hash#each_value is self so we would need to create an empty array
# and push the block return values to the empty array. 
#
# EACH_WITH_OBJECT is the best way to define an array and iterate through
# each key value pair matching the criteria for the new array. Is it possible
# to have a conditional so that we can do one or the other in every
# iteration?

# colors = hsh.each_with_object([]) do |(key, value), array|
#   array << value[:colors]
# end

# WORKS! ####################################################
new_array = hsh.each_with_object([]) do |(key, value), array|
  if value[:type] == 'fruit'
    array << value[:colors]
  elsif
    value[:type] == 'vegetable'
    array << value[:size]
  end
end
# => [["red", "green"], "medium", ["red", "green"], ["orange"], "large"]


# we still need a way to map through the return values and apply the
# transformation to the objects. One way suggests using two maps for the
# multi-dimensional array

# colors.map do |set|
#   set.map do |color|
#     color.capitalize
#   end
# end

###########################################################################
# So my solution feels like it could definitely be streamlined but this is
# what I have come up with so far. The return value from the each_with_object
# method is a new_array with the referenced values, yet it needs to be
# transformed with all the individual strings in the outer array in uppercase
# and the strings within the inner arrays capitalized (title case). The best
# solution I could find was to test whether an object was a string or an
# array but I know there's a better way to go about this. But this was my
# attempt.

transformed = new_array.map do |item|
  if item.kind_of?(String)
    item.upcase
  elsif
    item.kind_of?(Array)
    item.map do |element|
      element.capitalize
    end
  end
end
# => [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
p transformed
