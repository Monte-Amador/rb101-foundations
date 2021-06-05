# INTENTION OF TEST FILE: I want to see if it's possible for an outer_method to
# declare and pass a cached object to an inner_method.  the inner method will
# mutate the cached object the goal of the test is to provide a way to see how
# the object gets passed along in the outer_method after it has been mutated by
# the inner_method.  for this example, the outer_method has an inner loop that
# declares the cached object at the beginning of the loop.  after passing the
# cached object through to the inner_method it should be able to change and
# have the new value carry forth during the rest of the loop in the
# outer_method

# RESULTS OF TEST FILE: success in permanently altering the outer hash => array
# from a method that invokes an inner loop and creates a cached object at the
# beginning of the loop. Although it would be better handled across a program
# to create this cached object and pass it through as a parameter, now that we
# know it's possible to update the cached object without having to continuously
# use a method that recalculates the total (if that's possible since every use
# case will be different). 
###########################################
# initial setup
###########################################
def clear_screen
  system('clear') || system('cls')
end

a_hash = { grand_total: [1] }

def outer_method(hsh)
  loop do
    total_cached = hsh[:grand_total] # => array value
    p "cached object at beginning of loop:"
    p total_cached
    p "inner_method call return value:"
    p inner_method(total_cached)
    p "return value of outer_method:"
    p total_cached
    break if total_cached.sum == 3 
  end
end

def inner_method(cached_object)
  if cached_object.sum < 10
    cached_object[0] += 1 # this returns an integer
  end
end

clear_screen
p "original hash: #{a_hash}"
outer_method(a_hash)
p "original hash after outer_method method: #{a_hash}"
