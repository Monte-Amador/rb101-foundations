=begin
#### Question 3

Replace the word "important" with "urgent" in this string:
  advice = "Few things in life are as important as house training your pet dinosaur."
=end

advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.gsub!('important', 'urgent')
