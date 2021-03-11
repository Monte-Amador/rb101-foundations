# [Launch School - 7 Selection and Transformation](https://launchschool.com/lessons/85376b6d/assignments/ced192be)

## Selection and Transformation

"Selection" is picking certain elements out of the collection depending upon
certain criteria (e.g. pick all odd integers from an array)."Transformation"
on the other hand performs a manipulation on every element within that
array(e.g. add an 's' to every string within the array). If there are `n`
elements to an array, selection results in `n` or less elements while with
transformation `n` always equals the size of the array.

Both utilize the basics of looping: *a loop, a counter, a way to retrieve the
current value, and a way to exit the loop.*

They of course need some criteria to determine which elements are worked on
or in the case of transformation, how to perform the transformation. **When
performing transformation, it's always important to pay attention to whether
the original collection was mutated or if a new collection was returned.**

Note in the following use of `String#include?` that according to the
documentation `.include?` *gives* the `current_char` as the string to test on.

```
  if "aeiouAEIOU".include?(current_char)
    selected_chars << current_char
  end
```

*Interesting to note that the following code doesn't require a specific syntax
for the key (selected_fruits[current_key]) which I didn't expect. It seems to
grab the key no matter if it is a string or a symbol, so it might follow that
it does the same with an integer.*

```
    if current_value == 'Fruit'
      selected_fruits[current_key] = current_value
    end
```
#### My Summary
I really liked this chapter. It was thorough and although very approachable,
it showed me just how much lies below the surface. After this and the
following two chapters I decided to come back to this and refresh now that I
have a little more context. That was a very welcome challenge to be sure. 

Onwards.

#### LS - Summary

We often want to perform iteration, selection or transformation operations on
a collection. Using these 3 actions, we can manipulate a collection nearly
any way we need to.

Typically, these are generic actions that we can move into a method, so that
we can perform these generic operations repeatedly on different collections.

Pay attention to when the original collection is mutated vs when the method
returns a new collection. This might seem trivial right now, but it's a
source of a lot of misunderstanding. Make certain to study this.

Understand how these methods can be made more generic by allowing for
additional parameters to specify some _criteria_ for selection or
transformation.

Finally, it's common to chain actions on collections; but pay special mind to
the return value, especially if the return value is an empty collection or
`nil`. Trying to chain methods on empty collections or `nil` is dangerous and
results in a lot of broken programs.
