# scope.rb

a = 5             # variable is initialized in the outer scope

3.times do |n|    # method invocation with a block
  a = 3           # is a accessible here, in an inner scope?
end

puts a # => 3 because a has been reassigned within the block.
# Also note that had the block initialized `a` instead of `n` then variable
# shadowing would have taken place, effectively stopping the reassingment of
# the outer scoped variable `a`. This would have returned `5` for the last
# expression of the program `puts a`.
