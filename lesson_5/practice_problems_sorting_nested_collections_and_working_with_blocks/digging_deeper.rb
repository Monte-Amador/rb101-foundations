# Understanding deeper with Array#select

dogs = {
  'Lulu' => {weight: '49.8 lbs', colors: ['black', 'white'], age: 9, size:
'considered large, but mostly small'},
  'Kona' => {weight: '80 lbs', colors: ['dark grey', 'light grey', 'black'],
age: 5, size: 'large'},
  'Einstein' => {weight: '80 lbs', colors: ['dark grey', 'light grey', 'black'],
age: 15, size: 'large'},
  'Blue' => {weight: '75 lbs', colors: ['light grey', 'white'],
age: 12, size: 'large'}
}

# The objective here is to return elements of the hash in a real world
# setting and look deeper at how certain methods work.

# Simple reference
# p dogs['Lulu'][:colors]

# Simple Enumerable#map
# This not only returns an array from the return value of the block, but also
# passes the parameter as an array within the block, allowing us to perform
# array methods on it.. 
# calling Array#select on the inner block array gives us a the option for a
# key, value pair or a singular parameter will return the keys in the hash.
# upon further inspection this seems to really only work on a 1 level deep
# hash so probably not the best solution.
# dogs.map do |dog|
#   puts "\n" # => line break for readability
#   # p dog.kind_of?(Array) # => true
#   dog[1].select do |item, value|
#     p value if item.to_s == 'colors' 
#   end
# end

# Using map with a key, value pair does not return an array from the block
# but instead returns each inner hash
# dogs.map do |key, value|
#   # puts "\n"
#   # p key.kind_of?(String) # => true
#   # p value.kind_of?(Hash) # => true
#   p "#{key} ===> #{value}"
# end
#
# One method that gives me a little more pause than I expect is how the
# String#include? method works. x.include?(y) tests if y is a substring of
# x. so 'hello'.include?('lo') # => true. Note that it is testing if the
# whole word exists in the substring. This is why 'hello'.include?('aeiou')
# # => false. For this reason you cannot simply test, for example, if a
# string has any character from the string you provide as a substring. In
# order to use the include? method like that a simple example will suffice:

# vowels = 'aeiouAEIOU'
# # => "aeiouAEIOU"
# vowels.chars # Need to break each letter apart into their own array to iterate through
# # => ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
# vowels.chars.each do |vowel| # Remember that the return value of this will be the entire calling object
#   p vowel if 'hello'.include?(vowel)
# end
# => "e"
# => "o"
# => ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

test1 = dogs.map do |_, value|
  if value[:size].include?('small') 
    value[:colors].map do |color|
      color.capitalize
    end
  end
end
# => [[\"black\", \"white\"], nil, nil, nil] be careful with the nil
p "value of test1: #{test1}"

# Now the last example worked, however it returns nil for the objects that
# don't match the include statement because we are using the map method. So
# unless we follow the conditional with a fallback we will always get some
# sort of nil if the conditional returns false.
#########################################################

test2 = dogs.each_with_object([]) do |(key, value), array|
  if value[:size].include?('small')
    array << value[:colors]
  end
end

p "value of test2: #{test2}"


#########################################################
#
# This approach seems most approachable at the moment working with the
# #each_with_object() method as it saves the object within the
# method and you can assign that to a variable to call back later. 
# 
# Working with the nested data hash 'dogs' we can immediately iterate through
# the inner hashes (and still have access to the original key) with a
# conditional to test values. Note the benefit of including the #map method
# while in the inner block so that we can transform the output as necessary (on
# the array, not the string as we do in the else statement. One thing I
# noticed was that using string interpolation as useful as it is, does return
# an actual string that we call the #map method on later.

test3 = dogs.each_with_object([]) do |(key, value), array|
  if value[:size].include?('small')    
    export = value[:colors].map do |color|
      color.capitalize
    end
    export.prepend("#{key}: ")
  elsif
    value[:size] == 'large'
    export = "#{key}: " + "#{value[:weight]}".upcase
  end
  array << export
end

puts "value of test3: #{test3}"

#########################################################
