# Review Notes: Lesson 4: Ruby Collections

In this lesson, we'll work with three of the most commonly used collection
types in Ruby: `String`, `Array`, and `Hash`. You have already encountered
these collection types in previous lessons and assignments; in this lesson we
will explore them in greater depth.

[Collections Basics ](https://launchschool.com/lessons/85376b6d/assignments/39c98ed0)

## [String#slice Reference](https://docs.ruby-lang.org/en/3.0.0/String.html#method-i-slice)
Working with the String#slice (alias for String#[]) and giving two number,
remember this: 

> "When the two Integer arguments `start` and `length` are given, returns the
> substring of the given `length` found in `self` at offset `start`:"

**Example:**
In the below example, 8 is the start (similar to an array index) and the 5 is
the length to return.

```ruby
string = "Lulu is lying on the mat"
string[8,5]
```

## [Array#slice Reference](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-slice)

Behaves *very* similarly as the String#slice method, however note below:

> Just as with `String`, `arr[2, 3]` is alternative syntax for the
> `Array#slice` method. It is important to be aware, however, that
> `Array#slice` and `String#slice` are **not** the same method, even though
> they have the same name. They do share a lot of the same functionality, but
> are separate implementations. **One key distinction is that `String#slice`
> returns a new string whereas `Array#slice` returns a new array.**

## [Hash Element Reference](https://docs.ruby-lang.org/en/3.0.0/Hash.html)

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot' }

hsh['fruit']    # => "apple"
hsh['fruit'][0] # => "a"
```

**It is important to note that the `[0]` part of `hsh['fruit'][0]` in the above example is string element reference. The string `'apple'` is returned by `hsh['fruit']` and `[0]` is called on that return value.**

When assigning key => value pairs, you cannot assign more than one key, otherwise it will be overwritten. You can however assign multiple duplicate values.

```ruby
# Overwriting Key Example
hash ={'fruit' => 'pear', 'vegetable' => 'peas', 'fruit' => 'apple'} # => {'fruit' => 'apple', 'vegetable' => 'peas'} 
```

```ruby
# Multiple Values Example
hash = {'apple' => 'fruit', 'broccoli' => 'vegetable', 'pear' => 'fruit'} # => {"apple"=>"fruit", "broccoli"=>"vegetable", "pear"=>"fruit"}
```

### Accessing Hash Keys or Values

Getting elements from a hash is straightforward by using the hash's key or value

```ruby
country_capitals = { uk: 'London', france: 'Paris', germany: 'Berlin' }
country_capitals.keys      # => [:uk, :france, :germany]
country_capitals.values    # => ["London", "Paris", "Berlin"]
country_capitals.values[0] # => "London"
```

In the final line of the example above, `[0]` is referencing the item at index `0` of the array `["London", "Paris", "Berlin"]` since this is the return value of `country_capitals.values`.



## Heads Up

**Out of Bounds Indices**

Be aware of trying to reference an index that is out-of-bounds from the given string/array. Note that if you try to reference an element out-of-bounds in a string it will return #nil but with an array you will get a `IndexError (index 12 outside of array bounds: -7...7)` for example. `Array#[]` is most common but `Array#fetch` is a safer way when you want to use your own code.

> `#fetch` throws an `IndexError` exception if the index is **out of bounds**. This is very helpful for catching indices that are out of bounds, but which method is better to use? `#[]` or `#fetch`? `#[]` occurs most often in Ruby code, but it's actually better to use `#fetch` since it enforces the array boundaries. The key point here is to be careful when `#[]` returns `nil`. Always try to think about whether `nil` is the real element in the array or if it's Ruby's way of telling us we've gone beyond the array boundary. If you really want to be safe, use `#fetch` in your own code. However, be aware that most existing Ruby code doesn't use `#fetch`, including much of the code you'll see here in Launch School.

**Negative Indices**

If you want to count backwards in an index you *can* use a negative index:

```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[-2] # => "d"
arr[-2] # => "d"
```

![string negative0index](/Users/monte/Projects/launch-school/rb101-programming-foundations/lesson_4/note-images/string-negative-index-diagram.png)

![array-negative-index-diagram](/Users/monte/Projects/launch-school/rb101-programming-foundations/lesson_4/note-images/array-negative-index-diagram.png)

#### Invalid Hash Keys

`Hash` also has a `#fetch` method which can be useful when trying to disambiguate valid hash keys with a `nil` value from invalid hash keys.

```ruby
hsh = { :a => 1, 'b' => 'two', :c => nil }

hsh['b']       # => "two"
hsh[:c]        # => nil
hsh['c']       # => nil
hsh[:d]        # => nil

hsh.fetch(:c)  # => nil
hsh.fetch('c') # => KeyError: key not found: "c"
               #        from (irb):2:in `fetch'
               #        from (irb):2
               #        from /usr/bin/irb:11:in `<main>'
hsh.fetch(:d)  # => KeyError: key not found: :d
               #        from (irb):3:in `fetch'
               #        from (irb):3
               #        from /usr/bin/irb:11:in `<main>'
```

> In the above example both the string `'c'` and the symbol `:d` are invalid keys; the string `'b'` and the symbol `:c` are valid keys. Remember that both keys and values can be of any object. When referencing an item by its key you must use the correct object type.

## Collection Conversion
Converting between strings and arrays is fairly straightforward as they are
both indexed objects. The simplest methods for such a process are the use of
`String#chars` and `Array#join`:

```ruby
str = 'Practice'

arr = str.chars # => ["P", "r", "a", "c", "t", "i", "c", "e"]
 ```
Using `String#chars` returns the string into individual array elements and to
*join* each of the elements together you use the `Array#join` method. The
below code block illustrates how both the `String#chars` and `Array#join`
operate. Pay special attention to how the returned output is concatenated.
Also note that in this example we are using the `String#split` method instead
of `String#chars` in order to preserve the full word instead of splitting
each character into their own index.

For more information on this refer to the [Ruby Doc:Array#join](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-join) and the [Ruby Dog:String#chars](https://docs.ruby-lang.org/en/3.0.0/String.html#method-i-chars)
methods. 

```ruby
str = 'How do you get to Carnegie Hall?'
arr = str.split # => ["How", "do", "you", "get", "to", "Carnegie", "Hall?"]
arr.join        # => "HowdoyougettoCarnegieHall?"
 ```
Accordingly, if you reference the [Ruby
Doc:Array#join](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-join)
you will see that `With string argument `separator`, joins using that
separator:` which means we can add our own field separator. In the above
example we can use `' '` to get the desired effect like so: 

```ruby
arr.join(' ') # => How do you get to Carnegie Hall?
```

## Conversion with hashes

**Hash to array**

`Hash#to_a`
[#to\_a](https://docs.ruby-lang.org/en/3.0.0/Hash.html#method-i-to_a) is a
method that will return an array from a hash. Note that it will return one
array that contains sub-arrays (nested) for every `key, value` pair.

```ruby
hsh = { sky: "blue", grass: "green" }
hsh.to_a # => [[:sky, "blue"], [:grass, "green"]]
 ```

**Array to Hash**

`Array#to_h` [#to\_h](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-to_h)
will return a hash from an array. Note as per the ruby doc link that `When no
block is given, `self` must be an Array of **2-element sub-arrays**, each sub-array is formed into a key-value pair in the new Hash:`

```ruby
a = [['foo', 'zero'], ['bar', 'one'], ['baz', 'two']]
a.to_h # => {'foo' => 'zero', 'bar' => 'one', 'baz' => 'two'}
 ```


## Selection and Transformation Through a Collection

"Selection": picking certain elements from a collection depending on criteria
"Transformation": manipulating every single element in the collection.

If there are `n` elements in a collection, then selection results in `n`
elements or less, while transformation will always result in exactly `n`
elements.

The biggest takeaway with how selection and transformation work is to pay
attention to the return values. You want to make sure that you're not
mutating the argument that is passed through when selecting or transforming
through iteration.


## `each` Method

- [`Array#each` Ruby Doc](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-each)
- [`Hash#each` Ruby Doc](https://docs.ruby-lang.org/en/3.0.0/Hash.html#method-i-each)

Ruby provides its own built-in method to iterate over an object that is
functionally equivalent to `loop`. The `.each` method takes a block and
executes the code in the block upon each iteration. *For each iteration,
`each`sends the value of the current element to the block in the form of an
argument that represents the value of the current element in the array.*

If, for example you are working with an array, `each` knows there's only one
element per iteration, so `each` sends the block only one argument. Hashes,
however need two arguments in order to represent both the key and value per
iteration. Calling `each` hash looks different than an array (considering the
use of the multiple arguments needed for the key, value pairs):

```ruby
hash = { a: 1, b: 2, c: 3 }

hash.each do |key, value|
  puts "The key is #{key} and the value is #{value}"
end
 ```

> "We can iterate over an array or hash in a manual way by using `loop`, or
> we can iterate more idiomatically using `each` \-\- they're equivalent, for
> the most part. One of the main differences between them, however, is the
> return value. **Once `each` is done iterating, it _returns the original
> collection_.** We can verify this by testing it in irb."

```ruby
[1, 2, 3].each do |num|
  puts num
end
0
1
2
=> [0, 2, 3]    
 ```
> "Note that `[0, 2, 3].each` is the last expression in the example above, despite there being some code in the block. Therefore, the return value of the entire expression is the return value of the `each` invocation, which is the original collection (`[1, 2, 3]`)."

## `select` Method
- [`Array#select` Ruby Doc](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-select)
- [`Hash#select` Ruby Doc](https://docs.ruby-lang.org/en/3.0.0/Hash.html#method-i-select)

To perform selection, `select` evaluates the **return value of the block**.
The block returns a value on each iteration, which then gets evaluated by
`select`. Similar to a real method, **the return value of the block is the
return value of the last expression within the block.**

When evaluating the block's *return value*, `select` only cares about its
*truthiness*. Everything in Ruby is considered "truthy" except for `nil` and
`false`. That's not exactly the same thing as saying everything except `nil`
and `false` has a value of `true` in Ruby, but only that it is "truthy". It's
a small, but important, distinction.

If the return value of the block is "truthy", then the element during that
iteration will be selected. If the return value of the block is "falsey" then
the element will not be selected.

When an element is selected, it's placed in a _new collection_. In the above
example, once `select` is done iterating, it _returns a new collection_
containing all of the selected elements, because the selection criteria --
the block's return value -- is truthy for every element in the array.

NOTE: at this point it feels a little wobbly to consider using the `#select`
method for selecting and modifying the selection considering the fact that
the return value seemingly continues to return only the truthy values as
opposed to any actions we perform on those values. In fact, I could get the
return value I was expecting by performing a `.select` on an array and then
`.map` that return value to get a new array with the values I was initially
trying to get. 

Although getting my head around `select` in a way that makes sense will take
a little more time and exploration, I think if you just use the `select`
method literally to make a selection and don't expect anything different for
the return value, then that's the way to lead forward. If you want to
transform the selection, you might be better served with something like
`#map`.

```ruby
def a_select_method 
 [1,2,3,4,5].select do |item|
   if item.odd?
     item * 5
   end
 end
end

a_select_.map{|x| x * 5} # => [5, 15, 25]
```

*UPDATE*: The following upon first glance seems to be the right choice
instead of me having to chain `map` and `select` since I'm trying to write to
a new array in that previous example. Here's that way of writing it but note
that the breakdown of this is best explained on the [LS
Website](https://launchschool.com/lessons/85376b6d/assignments/d86be6b5) and
of course the [Ruby Doc `Enumerator#each_with_object`](https://docs.ruby-lang.org/en/3.0.0/Enumerator.html#method-i-each_with_object) 

```ruby
mod_numbers_arr = numbers.each_with_object([]) do |num, arr|
  arr << num * 5 if num.odd?
end

mod_numbers_arr => [5, 15, 25]
 ```
Besides taking a block like the methods above, `each_with_object` takes a method argument. The method argument is a collection object that will be returned by the method. On top of that, the block takes 2 arguments of its own. The first block argument represents the current element and the second block argument represents the collection object that was passed in as an argument to the method. Once it's done iterating, the method returns the collection object that was passed in.

## `#map` Method

The main difference between these two methods is that `map` uses the return value of the block to perform transformation instead of selection.

The key to remember here is that _`map` always performs transformation based on the return value of the block_. In this case, the return value of the block will be a boolean. This means that the collection returned by `map` will be an array of booleans.

```ruby
[1, 2, 3].map do |num|
  num.odd?
end
=> [true, false, true]
 ```

To further clarify your understanding of these methods and how they work, use the following table as a reference:

| Method | Action | Considers the return value of the block? | Returns a new collection from the method? | Length of the returned collection |
| --- | --- | --- | --- | --- |
| `each` | Iteration | No | No, it returns the original | Length of original |
| `select` | Selection | Yes, its truthiness | Yes | Length of original or less |
| `map` | Transformation | Yes | Yes | Length of original |
| `loop` | Iteration | Yes | No | Conditional statement needed to end return
values |

These methods each utilize the block's return value in their own way. In the
case of `each`, the return value of the block is simply ignored. Before
moving forward, it is crucial to understand how exactly these methods use the
block's return value to perform their intended task. 
