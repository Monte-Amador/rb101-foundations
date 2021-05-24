# starting the deal method

.keys.sample will return a random key value from the given hash however it looks like using the hsh.delete(key) will better server what it is I'm looking for doing. I want to return a value and append that value to the users_hand, however I also want to remove it from the deck of cards so that it won't get re-iterated later.

the current testing implementation worked with the following:

1. create hsh
2. test = hsh[:diamonds] # => {:ace=>[1, 11], :jack=>10, :queen=>10, :king=>10, :numerical=>[2, 3, 4, 5, 6, 7, 8, 9, 10]}
3. item = test.keys.sample # => :queen
4. test[item] # => 10 (value of :queen)
5. test.delete[item] # => 10 but also removes the :queen key and value from hsh permanently
