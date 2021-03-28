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

