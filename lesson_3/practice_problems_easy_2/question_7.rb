=begin
Question 7

In the previous practice problem we added Dino to our array like this:

  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones << "Dino"

We could have used either Array#concat or Array#push to add Dino to the family.

How can we add multiple items to our array? (Dino and Hoppy)
=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.push('Dino', 'Hoppy')
# p flintstones.concat(%w(Dino Hoppy))

=begin
Watch out: I expected the Array#concat to work but forgot that in this context it needed to be an array I was concatenating
=end
