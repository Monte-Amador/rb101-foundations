=begin
Question 10

Back in the stone age (before CSS) we used spaces to align things on the screen. If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?

title = "Flintstone Family Members"
=end

title = "Flintstone Family Members"
p title.center(40)

=begin
I went about it the long way by first getting the length of the string and subracting that from the specified space. I didn't realize that String#center would account for that already. Handy!
=end