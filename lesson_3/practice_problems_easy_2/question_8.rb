=begin
#### Question 8

Shorten this sentence:
  advice = "Few things in life are as important as house training your pet dinosaur."

..remove everything starting from "house".

Review the [String#slice!](http://ruby-doc.org/core/String.html#method-i-slice-21) documentation, and use that method to make the return value `"Few things in life are as important as "`. But leave the `advice` variable as `"house training your pet dinosaur."`.

As a bonus, what happens if you use the [String#slice](http://ruby-doc.org/core/String.html#method-i-slice) method instead?
=end

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(0, advice.index("house"))

=begin
It appears that the String#slice method is very flexible. Similar in first impressions for me, I want to get better acquainted with this one as well.
=end