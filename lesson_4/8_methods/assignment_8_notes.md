# Ruby Built-in Methods

Specifically diving deeper into `each`, `select`, and `map`.

## The `each` Method

```
[1,2,3].each do |num|
  puts num
end
```

- takes a block (in this example: `do..end`)
- in each iteration of the object(`[1,2,3]`), each sends the value of the current
  element (from the block) in the form of an argument(`num`) that the user creates.

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/3034b4e0)

Since we're working with an array here, `each` knows that there's only one
element per iteration, so `each` sends the block only one argument, `num`.
Hashes, however, need two arguments in order to represent both the key and
the value per iteration. Calling `each` on a hash looks a little different,
since the block has two arguments:

```
hash = { a: 1, b: 2, c: 3 } 
hash.each do |key, value| 
puts "The key is #{key} and the value is #{value}" end`
```


## Tricksy Stuff at First Glance

So `loop` and `each` seem to look equivalent, but there's a catch: `each`
returns *the original collection*. We can see this plainly if we look at
using `each` in a method:
```
def a_method()
  [1, 2, 3].each do |num|
  puts num * 2
  end
end 

a_method # => [1, 2, 3]
```
So it's imperative to understand that the `each` method returns the last
expression (in this example: `[1,2,3]` from `[1,2,3].each`.

## The `select` Method

At its most basic: To perform selection, `select` evaluates **the return
value of the block**. The block returns a value on each iteration, which then
gets evaluated by select. Similar to a real method, the return value of the
block is the return value of the last expression within the block.  The
take-away with `select` is that you **always** want to pay attention to the
return value from the block in the `select` method.


```
[1, 2, 3].select do |num|
  num.odd?
end

```

> When working with select, it's important to always be aware of the return
> value of the block. For example, if we place the statement puts num on the
> last line within the block, how will that affect the return value of select?

## The `map` Method
The `map` method also uses the return value from the block similar to `select`. The main
difference between these two methods is that map uses the return value of the
block to perform transformation instead of selection. 

Because `map` transforms the return value of the block, it's important to
understand how that works. If, for example the last expression of a block is
something that will not be an instruction for transformation, it will still
return something, even `nil`. This is important and can be seen in the
folloiwng example:

```
[1,2,3].map do |num|
  num.odd?
end
```
Understanding that the previous code block will *always performs
transformation based on the return value of the block* is critical to
understanding just how `map` actually works. In the previous code block,
`map` will iterate over the array and `num.odd?` will equate to a boolean
value, which is returned to the new array that `map` will make. So in this
example, `map` returns: #=> [true,false,true].

Looking at a related example should bring this one home. What will be the
return value of the following:

```
[1, 2, 3].map do |num|
  num * 2
  puts num
end
```
This example can really hit it home to understand the delicate nature of the
`map`. In this example, map will indeed use `puts` to output the value of num
like so:
1
2
3
however the *return value* will be `[nil, nil, nil]` because the last
expression evaluated will be a `puts` expression and `puts` always returns
nil. To show the differenece using the same example, change the `puts`
expression to a `p` expression which will return the value of `num` and you
will get `[1, 2, 3]` 

To further clarify your understanding of these methods and how they work, use
the following table as a reference:

| Method   |      Action      |  Considers the return value of the block? | Returns a new collection from the method? | Length of the returned collection |
|--------------|--------------|--------------|--------------|--------------|
| `each` |  Iteration | No | No, it returns the original | Length of original |
| `select` |    Selection   | Yes, its truthiness | Yes | Length of original or less |
| `map` | Transformation | Yes | Yes | Length of original |

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/3034b4e0)

### Enumerable

At the start of this assignment it was stated that Ruby _provides_ methods
like `each`, `select` and `map`. While this is true in a general sense it is
important to be aware that the picture is a little more complex in that not
all methods are available to all different types of objects.

`Array` and `Hash` both have an `each` method which is specific to them and
defines how the items in those collections are iterated over.

The `select` and `map` (and other) methods are actually defined in a module
called **Enumerable** and are made available to the `Array` and `Hash`
classes.

Don't worry at this stage if some or all of this seems confusing; these
Object Oriented Programming concepts will be covered in much more depth in
later courses. The important thing to understand at this stage is that
**certain collection types have access to specific methods for a reason**.

For example `String` doesn't use the `Enumerable` module and so you cannot
call `select` or `map` on a string (as we have already seen however we can
easily convert a string to an array by calling `String#split` if we want
access to the Enumerable methods of `Array`).

