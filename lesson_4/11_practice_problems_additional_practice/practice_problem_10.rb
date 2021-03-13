# [Practice Problem 10](https://launchschool.com/lessons/85376b6d/assignments/a76c28ac)
# Given the hash below:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an
# additional "age_group" key that has one of three values describing the age
# group the family member is in (kid, adult, or senior). Your solution should
# produce the hash below

# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
# "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
# "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
# "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
# "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" }
# }

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

# Iterate over the main hash
# Add a new key to the nested hash
# New Key has a name of "age_group"
# age_group value is "kid (age: 0 -17), adult (age: 18-64), or senior(age:
# 65+)"
# compare `age` key's value to age_group's range for value of new age_group
# key. 

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |member|
  member_age = munsters[member[0]]["age"]
  age_group_value = "adult" if (18..64).include?(member_age)
  age_group_value = "kid" if (0..17).include?(member_age)
  age_group_value = "senior" if member_age >= 65
  munsters[member[0]]["age_group"] = age_group_value
end
