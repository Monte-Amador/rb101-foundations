# Practice Problem 16
# NOTES:
# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# create a string n characters long 5 times.
# create a counter to know which iteration we are on.
# counter should change on each iteration 8,4,4,4,12
# n == counter

# alphabet[rand.size]
# nums[num.size]
# hexset contains all alphabet and nums

def make_uuid()
  hex_set = %w(a b c d e f 1 2 3 4 5 6 7 8 9)
  uuid_string = ''
  counter = 1 
  5.times do
    case counter
    when 1
        hex = 8
      when (2..4)
        hex = 4
      when 5
        hex = 12
    end    
    hex.times { uuid_string << hex_set[rand(hex_set.size)] }  
    uuid_string << '-' unless counter == 5
    counter += 1
  end
  uuid_string
end
puts "\n"
puts "UUID: #{make_uuid}"
puts "\n"
