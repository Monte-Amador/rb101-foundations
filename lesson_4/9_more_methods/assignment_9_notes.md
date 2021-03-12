# More Methods: Assignment 9 Notes

Looking at the `Enumerable#all?` and `Enumerable#any?` methods. You want to
make sure you understand how each of those methods return values are
considered. In the case of `any?` it takes a block and iterates over each
element given, then if any element returns truthy from within the block the
method will return true. `all?` is similar but every iteration needs to
return truthy otherwise the method will return false.

`Enumerable#each_with_index`

`each_with_index` is nearly identical to `each` as they both take blocks and
execute the code within the block as well as ignoring the block's return
value. `each_with_index` however takes a second argument representing the
index of each element.

```
[1, 2, 3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}"
end
```
Note that when calling the `each_with_index` on a hash, the first argument
now represents an array containing both the key and the value pair.

```
{a: 'ant', b: 'bear', c: 'cat' }.each_with_index do |pair index|
  puts "The index of #{pair} is #{index}"
end
```

Just remember that ultimately both `each` and `each_with_index` always return
their original calling collection.

`Enumerable#each_with_object`
Although `each_with_object` takes a block like the others, it also takes a
method argument. That method argument is a *collection object* that will be
returned by the method. On top of that, the block takes 2 arguments of its
own. The first block argument represents the current element, and the second
block argument represents the *collection object* that was passed in as an
argument to the method. Once done iterating, the method returns the
*collection object* that was passed in. That's a lot to swallow on the first
go around so an example should help illustrate:

```
[1, 2, 3].each_with_object([]) do |num, array|
  array << num if num.odd?
end
```
[Launch School - an online school for Software
Engineers](https://launchschool.com/lessons/85376b6d/assignments/d86be6b5)

In the above example, `array` is initialized to an empty array, `[]`. Inside
the block, we can now manipulate `array`. In this case, we're just appending
the current `num` into it if it's odd.

When working with a hash, the `each_with_object` is similar to
`each_with_index` as the first block argument turns into an array.

```
{ a: "ant", b: "bear", c: "cat" }.each_with_object([]) do |pair, array|
  array << pair.last
end
# => ["ant", "bear", "cat"]
```
And there is an additional quirk in how `each_with_object` can use
parentheses to capture the key,value pair in the first argument:

```
{ a: "ant", b: "bear", c: "cat" }.each_with_object({}) do |(key, value), hash|
  hash[value] = key
end
# => { "ant" => :a, "bear" => :b, "cat" => :c }
```


`Enumerable#first`

So know that `first` doesn't take a block. It can however take an optional
argument that represents the number of elements to return. If no argument is
given, it will only return the first element in the collection:

```
[1, 2, 3].first
# => 1
```
Something to notice, is that without an argument on the above array, the
return value is a single integer. If, however an argument is supplied then it
will return the value(s) in an array.  
```
[1, 2, 3].first(2)
# => [1, 2]
```

When running `first` with a hash, things get a little interesting in that it:
1. returns a nested array if there is an argument supplied (e.g. `first(n)`)
2. the return is a nested array not a hash, which is unexpected.

In practice, `first` isn't usually called on a hash as it's something that
defies a certain kind of logic since hashes are typically thought of as
unordered with keys and values. `first` makes more sense with an array.

`Enumerable#include?`

`include?` doesn't take a block, however it *requires* an argument, which is
an object.
[Module: Enumerable (Ruby 3.0.0)](https://ruby-doc.org/core-3.0.0/Enumerable.html#method-i-any-3F)

> include?(obj) → true or false
> Returns `true` if any member of _enum_ equals _obj_. Equality is tested using `==`.

`include?` returns true if the argument exists in the given collection. Of
importance to note, `include?` **only** checks the keys of a hash, not the
values. Apparently, `Hash.include?` is an alias for `Hash.key?` or
`Hash.has_key?` so it's better and more explicit to use those when working
with hashes.

If you are wanting to get to the values in a given hash to see if the
value exists, it's better to use `Hash.value?` or `Hash.has_value?` methods.
this is cleaner and easier than chaining methods to turn hash keys into an
array and using the `include?` on that.

`Enumerable#partition`
`partition` takes a block and is interesting as it divides up elements in a given collection
into two collections depending upon the block's return value. This is easier
to see than to write:

```
[1, 2, 3].partition do |num|
  num.odd?
end
# => [[1, 3], [2]]
```
So now that we understand that, it's more idiomatic to parallel assign
variables to capture the divided inner array:

```
odd, even = [1, 2, 3].partition do |num|
  num.odd?
end

odd  # => [1, 3]
even # => [2]
```
When using `partition` on a hash, the return value will always be an array:

```
long, short = { a: "ant", b: "bear", c: "cat" }.partition do |key, value|
  value.size > 3
end
# => [[[:b, "bear"]], [[:a, "ant"], [:c, "cat"]]]
```
In the case of the latter example, the first variable `long` == [[:b "bear"]]
but can be easily changed back to a hash using the `Array#to_h` method, and
of course it's the same for the `short` variable.

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/d86be6b5)

#### Summary

Over the past two assignments you have seen an overview of a number of
different methods that can be used for working with collections. While you
may not be able to remember all of these right away it is important to know
that methods like these exist and that you can use the Ruby documentation in
order to find them and understand how they work. You can think of certain
sections of the documentation as a sort of manual or guide for how to use
certain methods.

Method documentation will normally include:

- One or more method signatures (which will indicate whether the method takes
  arguments and/ or a block and what it returns)
- A brief description of how the method is used, often covering different use
  cases
- Some code examples, again usually covering various use cases

By taking the time to read a method's documentation, we can gain a more
thorough understanding of how that method works. We're then able to move
forward knowing things like:

- Whether the method takes a block
- How it handles the block's return value
- What the method itself returns
