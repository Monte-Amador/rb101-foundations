=begin
Question 1

In this hash of people and their age,

  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

see if "Spot" is present.

Bonus: What are two other hash methods that would work just as well for this solution?
=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages = %w{Herman => 32 Lily => 30}

p ages.include?('Spot')
p ages.has_key?('Spot')
p ages.key?('Spot')


=begin
### Test if hash contains a value
```
Hash#key?
Hash#include? 
Hash#member?
```
IMPORTANT: Must study more on the differences between each of the methods.

=end