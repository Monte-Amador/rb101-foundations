=begin
Question 5

Depending on a method to modify its arguments can be tricky:
  def tricky_method(a_string_param, an_array_param)
    a_string_param += "rutabaga"
    an_array_param << "rutabaga"
  end

  my_string = "pumpkins"
  my_array = ["pumpkins"]
  tricky_method(my_string, my_array)

  puts "My string looks like this now: #{my_string}"
  puts "My array looks like this now: #{my_array}"

Whether the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.

How can we change this code to make the result easier to predict and easier for the next programmer to maintain?
=end

# def tricky_method(a_string_param, an_array_param)
#   a_string_param << "rutabaga"
#   an_array_param << "rutabaga"
# end

def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

=begin
Ideally, we need a way to perform the same kind of change on both the method's local variables. 

The easiest way is to change the String+= assignment to string so that a user knows and expects that the method will mutate the caller.

Otherwise, to do this in a way that the method does not mutate the caller we can keep the String+= operation and instead assign the an_array_param = ["pumpkins", "rutabaga"]. This way we have assigned two completely different objects instead of the original references that our variables point to.
=end