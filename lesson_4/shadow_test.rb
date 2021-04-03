# Variable shadowing in Ruby relates specifically to when a *block* parameter of the same name is used. In the below tests, I have initialized two local variables `a` and `b` respectively and these are considered outer scope as opposed to the inner scope within the block further down. We can see the object_ids from them as they remain intact throughout the program. Once we enter the block we essentially initialize a new variable of the same name in a different scope. The existence of this variable effectively prevents access to the `a` initialized first in the outer scope.

a = 4
b = 2

puts "Created two local variables 'a' and 'b' respectively." 
puts "The value of 'a' is: #{a}"
puts "The value of 'b' is: #{b}"

puts "The object_id of (outer scoped) a is: #{a.object_id}"
puts "The object_id of (outer scoped) b is: #{b.object_id}"

3.times do |a|
  puts "Iteration #: #{a} inside the block - this (inner scoped) 'a' currently has the object_id of: #{a.object_id}"
  a = 5 # a is now reassigned
  puts "Still in the block, after reassignment 'a' has an object_id of => #{a.object_id}"
  puts "This means that the (inner scoped) variable 'a' inside the block gets reassigned from the initial iteration that is assigned in the block."
end

puts "Now outside of the block (outer scope),this should result in the original object_id from 'a' declared in
the outer scope: #{a.object_id}"

puts "And this should result in the original object_id from 'b' declared in
the outer scope: #{b.object_id}"
