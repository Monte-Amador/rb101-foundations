[LS Lesson 5.2 sort and sort_by](https://launchschool.com/lessons/c53f2250/assignments/2831d0e1)

Woof, that was an initial headache but that was because the way String#<=>
goes character by charcter made sense, however with the Enumerable#sort_by
you can specify the character as expected however, it will not evaluate the
remaining characters if the intial charcters match. It instead seems to
default to the lenght of the item.

`String#<=>`
p ['this', 'one', 'thing'].sort # => ["one", "thing", "this"]
Sorts based on character by character, if both characters are the same then the next characters in the string are compared. Note how this threw me off at first since 'thing' is clearly longer than 'this' but the 'n' comes before 's'.

p ['arc', 'bat', 'cape', 'ants', 'cap'].sort # => ['ants', 'arc', 'bat', 'cap', 'cape']

> In the case of `'cap'` and `'cape'`, the comparable characters are all equal, but `'cape'` is longer and so is considered *greater* by `String#<=>`.

`Array#<=>` 
p [['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort

# => [['a', 'car', 'd'], ['a', 'car', 'd', 3], ['a', 'cat', b, 'c'], ['b', 2]] 

According to the [`Array#<=>`](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-3C-3D-3E) documentation, each elemental item of the array is evaluated against the others. 

tmp = ['cot', 'bed', 'mat'].sort_by do |word|
 word[1] # => evaluates the character at index 1
end

p tmp

Using the `#sort_by` method allows us to see how it handles different
arguments. It looks like `#sort_by` when sorting with an index number is
*only* concerned with that number/string. After that it seems to go with
length as a default fallback, as is the case in the below test code with
`word[1]`.

output = ['this', 'one', 'thing'].sort_by do |word|
  # word # => [ 'one', 'thing', 'this' ] based on character by character like #sort
  word[0] # => [ 'one', 'this', 'thing' ] 'o', 't', 't'
  # word[1] # => [ 'this', 'thing', 'one' ] 'h', 'h', 'n'
  # word[2] # => [ 'one', 'this', 'thing' ] 'i', 'i', 'e'
  # word[3] # => ArgumentError 'comparison of String with nil failed' 's', 'n', 'nil'
end

p output

people = { Kate: 27, john: 25, Mike:  18 }
people_sorted = people.sort_by do |name, _|
  name
end

p people_sorted
TAKEAWAYS:
I'm very happy I could work more with the
sort_by method while learning how to work with a hash more. There wasn't
really enough examples on this for me to lock it into place better. Also,
it looks like you can define multiple parameters to sort_by when working
with a hash which is very valuable. 

## For example: 
```ruby

# note that the below array has some purposeful points to work with, namely
# the last line's title in not capitalized and the publish date is an actual
# integer. This is for testing various blocks below.

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'},
  {title: 'ulysses', author: 'Lulucha Lulu', published: 2021}
]

# sort books by publishing date (defaults to ascending)
sorted_books = books.sort_by do |book|
  book[:published].to_i
end

# => sorted_books = [
  {:title=>"War and Peace", :author=>"Leo Tolstoy", :published=>"1869"}
  {:title=>"Ulysses", :author=>"James Joyce", :published=>"1922"}
  {:title=>"The Great Gatsby", :author=>"F. Scott Fitzgerald", :published=>"1925"}
  {:title=>"One Hundred Years of Solitude", :author=>"Gabriel Garcia Marquez", :published=>"1967"}
  {:title=>"ulysses", :author=>"Lulucha Lulu", :published=>2021}
]

# sort books by title
sorted_books = books.sort_by do |book|
  book[:title].capitalize # takes care of the odd non-capital title
end

# => sorted_books = [
  {:title=>"One Hundred Years of Solitude", :author=>"Gabriel Garcia Marquez", :published=>"1967"}
  {:title=>"The Great Gatsby", :author=>"F. Scott Fitzgerald", :published=>"1925"}
  {:title=>"Ulysses", :author=>"James Joyce", :published=>"1922"}
  {:title=>"ulysses", :author=>"Lulucha Lulu", :published=>2021}
  {:title=>"War and Peace", :author=>"Leo Tolstoy", :published=>"1869"}
]

# sort books by publish date first and then title

sorted_books = books.sort_by do |book|
  [book[:published].to_i, book[:title].capitalize]
end

# => sorted_books = [
  {:title=>"War and Peace", :author=>"Leo Tolstoy", :published=>"1869"}
  {:title=>"Ulysses", :author=>"James Joyce", :published=>"1922"}
  {:title=>"The Great Gatsby", :author=>"F. Scott Fitzgerald", :published=>"1925"}
  {:title=>"One Hundred Years of Solitude", :author=>"Gabriel Garcia Marquez", :published=>"1967"}
  {:title=>"ulysses", :author=>"I Lulucha", :published=>2021}
]

# sort books by title and then publish date
sorted_books = books.sort_by do |book|
  [ book[:title].capitalize, book[:published].to_i ]
end

# => sorted_books = [
  {:title=>"One Hundred Years of Solitude", :author=>"Gabriel Garcia Marquez", :published=>"1967"}
  {:title=>"The Great Gatsby", :author=>"F. Scott Fitzgerald", :published=>"1925"}
  {:title=>"Ulysses", :author=>"James Joyce", :published=>"1922"}
  {:title=>"ulysses", :author=>"I Lulucha", :published=>2021}
  {:title=>"War and Peace", :author=>"Leo Tolstoy", :published=>"1869"}
]

# sort books by title and publish date(in descending order)

sorted_books = books.sort_by do |book|
  [ book[:title].capitalize, -book[:published].to_i ]
end

```

[sub_hash[:published].to_i, sub_hash[:title].capitalize]

