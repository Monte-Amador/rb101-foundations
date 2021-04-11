# Practice Problem 5
# Given this nested Hash:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Goal: figure out the total age of just the male members of the family.

# Select the hashes that have a gender of male and save to males_hash
# variable as nested hash
males_hash = munsters.select do |_, value|
  value['gender'] == 'male'
end
# => {
#  "Herman"=>{"age"=>32, "gender"=>"male"}, 
#  "Grandpa"=>{"age"=>402, "gender"=>"male"}, 
#  "Eddie"=>{"age"=>10, "gender"=>"male"}
# }

# create empty array to hold return values
ages_array = [] 

males_hash.map do |sub_arr|
  sub_arr[1].select do |k, v| 
    ages_array << v if v.to_s.to_i == v 
  end
end
# => [32, 402, 10]

# calling #map on a hash returns the hash as an array, the same thing as
# #to_a does but allows us to iterate over each inner array and target the
# index that holds the values (as hashes) we need. In this case index[1] from the
# sub_array will return each {"age"=>n, "gender"=>"male"}. So we run select
# over the index choosing to push only integers to the empty ages_array we
# declared earlier.

# call Array#sum from ages_array
p ages_array.sum
# => 444

