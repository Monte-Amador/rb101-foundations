puts "==> ## Referencing collection elements"
puts "==> Setting up the arr variable and locating the associative object_ids"
arr = [[1, 3], [2]]
p "arr.object_id = #{arr.object_id}"
p arr[0] # => [1, 3]
p "arr[0].object_id = #{arr[0].object_id}"
p "arr[0][1] = #{arr[0][1]}" # => 3
p "arr[0][1].object_id = #{arr[0][1].object_id}"

puts "==> ## Updating Collection Elements"
puts "==> arr[1] will get a destructive action of assignment"
p "arr[1].object_id = #{arr[1].object_id}"
p arr[1] = "hi there"
p "arr[1].object_id = #{arr[1].object_id}"
p "arr.object_id = #{arr.object_id}"

# Take a look at the following example and make sure to understand that it
# begins like a "chained reference" but it's not. 

arr = [[1, 3], [2]] # => local variable declaration
arr[0][1] = 5 
p arr
p  "arr.object_id = #{arr.object_id}"
# => arr[0] is the element reference that returns the inner array [1, 3]
# => However, the second part [1] = 5 is the same as [1, 3][1] = 5 which is
# element update, not reference. 
# So this can be considered a "chained action" `arr[0][1] = 5` but important
# to note the first part of that chain is element reference followed by
# element update. Also note that the object_id of the arr variable has
# changed in the last line.

# Variable reference for nested collections

a = [1, 3] # => pointing to array object
p "==> variable a.object_id = #{a}"
b = [2] # => pointing to array object
p "==> variable b.object_id = #{b}"
arr = [a, b]
p arr # => [[1, 3], [2]]

a[1] = 5 # => Modifies the array object because `a` still points to the same
# array object. So when you update the element (not the same as re-assigning)
# you are updating the array object.
p arr [[1, 5], [2]]

# Understanding a couple things going on here in the variable references
# inside of arrays. [Reference:
# variables_as_pointers](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
# Note that the variable is still pointing to the same array object that's in
# *arr*. If you modify the array object or the variable, you are modifying
# the array object at the same time. This is not the same as re-assignment
# because we are creating and pointing to a new object altogether.

# > This is the major point of this section: some operations mutate the
# address space in memory, but others simply change the variable to point to
# a different address space.
# 
# > This also applies to variables that point to arrays, hashes, or any data
# structure that has methods that mutate the caller. If you call a method
# that *mutates the caller*, it will change the value in that address space,
# and any variables also pointing there will be affected. Therefore, always
# pay attention whether your variables are pointing to the same object (space
# in memory) or if they are dealing with copies that occupy different address
# space in memory. 

# > Remember when we're passing in arguments to a method, we're essentially
# assigning a variable to another variable, like we did with `b = a`. Working
# with `b` in the `test` method may or may not modify the `a` in the outer
# scope, depending on whether we modify the address space in memory that `a`
# is pointing to.
# 
# > This is all you need to know for now. It's almost guaranteed that you'll
# run into bugs in the future related to this topic, so the important thing
# here isn't to memorize the rules, but to understand the concept and be able
# to jump into `irb` to refresh your memory.

# Shallow Copy
# When copying entire collections, you can use the `dup` and `clone` methods
# to save the original - as a new object for example - before major
# modifications are applied. These methods create a shallow copy of the
# object which means, that only the object that the method is called on is
# copied. If the object contains other objects, then those objects are
# *shared*, not copied.
