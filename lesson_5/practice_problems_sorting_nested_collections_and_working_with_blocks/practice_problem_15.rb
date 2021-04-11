# Practice Problem 15

# Given this data structure write some code to return an array which contains
# only the hashes where all the integers are even.

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# NOTES:
# arr = array made up of inner hashes with each key as symbol and each value stored in a single
# array.
#
# Return: array made up from Selected hashes
# Selection: all integers are even
# Conditional Logic: if integer % 2 == 0
#
# #map seems to be the right solution for the outer method as we need an array as the return
# value, but we need to #select on the hash value on an inner block so that
# it can pass its return value to the outer block.
# Iterate through each inner hash value and test if each element modulus == 0
# (even).
# if #all? elements are even, export hash to new array.

test = arr.map do |sub_hash|
  sub_hash.select do |_, value|
    value.all? do |num|
     num % 2 == 0
    end
  end
end
# 
p test
# test = arr.select do |sub_hash|
#   sub_hash.all? do |k, v|
#     v.all? do |num|
#       num % 2 == 0
#     end
#   end
# end
# p test
