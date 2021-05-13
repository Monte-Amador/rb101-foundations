=begin
The goal of this self-assignment was to better undertand a couple points. Mostly it's about understanding more about me and the way I work through a problem. I map it out in theory, then find it gets close and a bug displays itself. It's a challenge not to get too focused on the bug (needs more work) and also not push forward for every success without better documenting the whole process push-by-push. This is in lieu of line-by-line because it may be a better reminder to stop along the development path and document where I am at with it. I also wanted a way to just build and create with the limited knowledge I have to make sure I have these core concepts/fundamentals down enough to get down with it all.

So yes, the following methods were created as a way to validate input provided by the user. It's basic in it's logic but helpful for a few things. Namely, we can verify if an input is indeed an integer and return the integer version from the string. Next, we can also verify that the integer falls between a range of possible valid integers when necessary. (This is currently not optional but that will be the next iteration.)

The string validation method is handy in that it can be given an array of valid strings to test the user input against. That's been a goal of mine, to simplify the validation points so that maybe we can hold all valid string inputs in an array and provide a method to do the heavy lifting.

Finally, we have a method that also takes all input and passes it accordingly to their respective sub-methods based on how the method is called.
=end

def prompt(msg)
  puts "=> #{msg}"
end

def display_error
  error = <<~MSG
  please check input type (string/integer) 
  and all valid input strings 
  (e.g. ['Yes y no n'])
  MSG
  prompt error
end

def validate_integer_input(int)
  return false if int.to_i.to_s != int
    int.to_i
end

def integer_in_range(str, range)
  return false if !validate_integer_input(str)
  int = str.to_i
  case range.size
  when 2
    int if int.between?(range[0], range[1])
  when 1
    int if range.join.to_i == int
  else
    display_error
    return nil
  end
end

def string_in_range(str, range)
  test_string = range.join(' ').split
  string = str.strip.downcase
  return string if test_string.include?(string)
  return false
end

def validate_user_input(str, data_arr, type)
  case type.downcase
  when 'integer'
    integer_in_range(str, data_arr)
  when 'string'
    string_in_range(str, data_arr)
  else
    display_error
  end 
end

###################################################################

test_string = 'Yes'
test_string_range = %w(y yes n no)

test_number = "9"
test_new_number = "10"
p validate_user_input(test_number, [1,9], 'integer') # => 9
p validate_user_input(test_new_number, [1,9], 'integer') # => nil/out of range
p validate_user_input(test_string, test_string_range, 'string') # => string:yes
p validate_integer_input(test_number) # => integer
p integer_in_range(test_number, 8) 
