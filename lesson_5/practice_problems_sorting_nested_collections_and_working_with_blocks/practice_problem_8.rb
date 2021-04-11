# Practice Problem 8

# Using the `each` method, write some code to output all of the vowels from the strings.

hsh = {
  first: ['the', 'quick'], 
  second: ['brown', 'fox'], 
  third: ['jumped'],
  fourth: ['over', 'the', 'lazy', 'dog']
}
#
# iterate over each array and split each word
# need to compare every letter and test if it is a vowel
# if it is a vowel, append to empty array.
# return array with Array#puts method

# hsh.each do |_, arr|
#   arr.each do |word|
#     letters = word.split('')
#     p letters
#   end
# end
# hsh.each do |_, arr|
#   arr.each do |word|
#     word.chars do |char| # String#chars can take a block but this is deprecated
#       p char if 'aeiouAEIOU'.include?(char)
#     end
#   end
# end

hsh.each do |_, arr|
  arr.each do |word|
    word.chars.each do |letter|
      p letter if 'aeiou'.include? letter
    end  
  end
end
