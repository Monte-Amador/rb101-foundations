# Practice Problem 2
# How would you order this array of hashes based on the year of publication
# of each book, from the earliest to the latest?
#

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

# Example Output:
# books = [ 
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
# ]
#
# Target: change order of array based on inner hash's published key value
# (string)
# 
# iterate through array and access each sub_hash. Compare each sub_hash
# against the other specifying which key, value pair to use
#
# Method Enumerable#sort_by when invoked on a hash needs two arguments
# representing the key, value pair respectively. 
#
# we can specify the key by matching it to :published symbol by realizing the
# symbol will be compared as a string, i.e. character by character. 

# However, in looking at the output, what we really want is to sort it by the date it
# was published and in this case the published date is a string, and we can
# sort it by the string which would output it from earliest to latest.

# output = books.sort_by do |sub_hash|
#   sub_hash.sort_by do |_, value|
#     value
#   end
# end

output = books.sort_by do |sub_hash|
  sub_hash[:published]
end
# LS ANSWER: We can use `sort_by` and access a particular value in each hash
# by which to sort, as long as those values have a `<=>` method.

# Note in my previous solution I missed the ability to reference the value
# simply by using the standard hash[key] call.

# TAKEAWAYS:
# very happy I could work more with the
# sort_by method while learning how to work with a hash more. There wasn't
# really enough examples on this for me to lock it into place better. Also,
# it looks like you can define multiple parameters to sort_by when working
# with a hash which is very valuable. For example: 
# [sub_hash[:published].to_i, sub_hash[:title].capitalize]

p output

mazic amaze faze refaze
