a = 1 # local outer scope variable
puts "object id for 'a': #{a.object_id}"
loop do # the block following the invocation of the `loop` method creates an inner scope
  puts a # => 1
  a = a + 1 # "a" is re-assigned to a new value
  break # necessary to prevent infinite loop
end # end of inner scope block

puts a
puts "object id for a: #{a.object_id}" # => outputs '2' because of the re-assignment in the method's inner scope
