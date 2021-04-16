=begin
Write a method called `joiner` that will produce the following result:

1. joiner([1, 2]) => '1 or 2' if only 2 elements either or
2. joiner([1, 2, 3]) => '1, 2, or 3' add 'or' before last element
3. joiner([1, 2, 3], '; ') => '1; 2; or 3' be able to change defaults to ','
4. joiner([1, 2, 3], ', ', 'and') => '1, 2, and 3' gives us the ability to
change two defaults with the delimiter and the conjunction

joiner(array, delimiter, conjunction) gets 3 arguments

step 1 is currently a simple working example
we have defaults setup for the two strings that act as delimiter and
conjunction.

if we Array#pop the element off of the array and store that as a varaible it
is a destructive method and will not work because we still need to access the
non modified array.

Now I am noticing too that when making the insert method it may be modifying
the original array.

What I'm thinking now is how to insert the string just before the last item
in the array and save this to a new array for display purposes. The
Array#insert method works like this. 

got the Array#insert method to work, however when using Array#join to print
the array that is including the delimiter at the end of the inserted string.

***************************************************************************
Array#each_with_index can give us both the value and index so we can push the
value if the index is the same as the array.size - 1. This keeps the original
array intact and gives us a variable:

First Step:

arr = [4, 5, 6]
new_arr = []
arr.each_with_index do |item, idx|
  new_arr << item if idx < (arr.size - 1)
end
# new_array => [4, 5]

Next Step:
So it follows that there is most likely a method that exists in order to
achieve the result, but all I really want to do is write my own joining
method, so let's look at how to take all the elements of an array, and turn
them into a string. 

iterate: through the array and append each item concatenated with the
specified/default delimiter value to an empty string.

Last Step: 
now we can start to create the output by appending the last item in the same
way to the new_array:

arr.each_with_index do |item, idx|
  new_arr << item if idx == (arr.size - 1)
end

# new_arr => [4, 5, 6]

So we can run the insert command on the new_arr without concern for mutating
the original array. Note that we should leave this part (appending the last
item to the array as the end of the process because we still need to work
with the joining limitation.



=end
def validate_joiner_argument(arr)
  !!arr.is_a?(Array)
end

def joiner(arr, del=', ', conj='or')
  if validate_joiner_argument(arr)
    string_output = ''
    case arr.size
    when 0 then ''
    when 1 then string_output << "#{arr[0]}"
    when 2 
      string_output << ("#{arr[0]}" + ' ' + "#{conj}" + ' ' + "#{arr[1]}")
    else
      arr.each_with_index do |item, idx|
        if idx < (arr.size - 1)
          string_output << ("#{item}" + "#{del}")
        else
          string_output << ("#{conj}" + ' ' + "#{item}")
        end
      end 
    end
    string_output
  else
  "Sorry, you need to provide an array as an argument."
  end
end

p joiner([1, 2])
p joiner([1])
p joiner([1, 2, 3])
p joiner([1, 2, 3], '; ')
p joiner([1, 2, 3], ', ', 'and')
p joiner('[1, 2, 3]', '-','else')
