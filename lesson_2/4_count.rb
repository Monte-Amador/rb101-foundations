require "pry" # add this to use pry
counter = 0

loop do
  counter += 1
  binding.pry # execution will stop here
  break if counter == 5
end