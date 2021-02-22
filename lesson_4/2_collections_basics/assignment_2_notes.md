

# 2. Collection Basics

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/39c98ed0)

> Collections are made up of individual elements. In order to work with collections we need to understand how they are structured and how to reference and assign the individual elements within them.

### String Element Reference

You can also reference multiple characters within a string by using an index starting point and the number of characters to return.

    str[2, 3] # => "cde"

Something to be aware of in the above example is that `str[2, 3]` is actually a call to the `#slice` method of `String` and is alternative syntax for `str.slice(2, 3)`. The fact that we can use this alternative form of `#slice` is part of Ruby's *syntactical sugar*.

You can check the [String documentation](https://ruby-doc.org/core/String.html) for more information on `String#slice` and other methods.

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/39c98ed0)

### Array Element Reference
One situation where `Array#slice` does not return a new array is if we pass the method only an index, rather than a start and length or a range; in this case the element at that index is returned rather than a new array.

    arr = [1, 'two', :three, '4'] 
    arr.slice(3, 1) # => ["4"] 
    arr.slice(3..3) # => ["4"] 
    arr.slice(3) # => "4"`

On lines 2, 3, and 4 in the code above, we are using the element reference syntax of the `Array#slice` method. Although these three method calls all target the same element of `arr` (the string `'4'` at index 3), the first two method calls return that element inside a new array, whereas the third one simply returns the element itself.

When calling methods such as this on a collection object like an array it is important to be aware of exactly what is returned, as this will affect how you can subsequently interact with that return value.