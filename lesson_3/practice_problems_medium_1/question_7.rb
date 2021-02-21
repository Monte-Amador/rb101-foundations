=begin
Question 7

One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:
    mess_with_demographics(munsters)

Did the family's data get ransacked? Why or why not?
=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# def mess_with_demographics(demo_hash)
#   demo_hash.values.each do |family_member|
#     family_member["age"] += 42
#     family_member["gender"] = "other"
#   end
# end
# mess_with_demographics(munsters)

def mess_with_demographics2(demo_hash)
  joke = demo_hash.merge
  joke.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
  joke
end


puts munsters
puts mess_with_demographics2(munsters)

=begin
This took me some time to work out. Althoguh I definitely undertand how the method is mutating the demo_hash, there wasn't a solution provided except creating a different object with a different object_id. This was a little confusing to work out but then I got there with my solution. I'm sure there are better ways to come to this solution but this works for my basic skillset now.
=end