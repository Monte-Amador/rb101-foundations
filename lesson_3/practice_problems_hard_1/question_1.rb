=begin
Question 1

What do you expect to happen when the greeting variable is referenced in the last line of the code below?
  if false
    greeting = "hello world"
  end

  greeting
=end
if false
  greeting = "hello world"
end

p greeting

=begin
I got what I was expecting because it will never equate to false since Ruby considers nearly everything truthy (except false and nil)
=end