=begin
Question 2

Starting with this string:

  munsters_description = "The Munsters are creepy in a good way."

Convert the string in the following ways (code will be executed on original munsters_description above):

  "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
  "The munsters are creepy in a good way."
  "the munsters are creepy in a good way."
  "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
=end

munsters_description = "The Munsters are creepy in a good way."

p "SWAP CASE:" + munsters_description.swapcase
p "CAPITALIZE:" + munsters_description.capitalize
p "DOWNCASE:" + munsters_description.downcase
p "UPCASE:" + munsters_description.upcase

=begin
Interesting: One thing I found was that I had to concatenate the output
due to the fact that if I wrote the output as I did originally:
# p "capitalize: #{munsters_description}".capitalize
it actually capitalized the beginning of the string instead of the
variable like I had envisioned.
=end
