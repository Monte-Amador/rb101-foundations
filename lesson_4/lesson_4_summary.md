# Summary

The assignments in this lesson have covered a number of concepts; from what
collections are on a conceptual level, to referencing and assigning elements,
through working with simple loops and finally to using iterative methods.

Having a clear understanding of collections on both a conceptual and
practical level is a fundamental piece of knowledge, both in Ruby and in
programming in general.

Some particularly important points to remember are:

- [x] Some of the most commonly used iterative methods are `each`, `select`,
  and `map`. It's important to understand the difference between these
methods.
*The main differences are based on their return values with each ignoring the
return block and instead returning the initial expression, select returning
the block, and map using the return value of the block to make a
transformation on the elements.*


- [ ] Methods called on Ruby collection objects are often used with a block;
  the return value of the block is passed back to the method on each
iteration. It is important to be aware of:
  
    - [ ] What the method does with the block's return value.
    - [ ] What the ultimate return value of the method is.
    - [ ] Any side-effects that the code in the block may have.
    
    
    
- [ ] Ruby provides a lot of other useful methods for working with
  collections. It's not necessary to memorize them all at this stage but you
should:

    - [ ] Be aware that they exist and know where to look for them.
    - [ ] Know how to read the documentation in order to understand the
      method's return value, how it uses the block's return value (if it
takes a block), and whether the method is destructive.

At this stage you should feel comfortable working with collections,
particularly using `each`, `select`, and `map`, and have a good understanding
of how those methods are called with a block.

Having a clear understanding of these concepts will be vital in the next
lesson, where you will be required to work with collections in a more
advanced and complex way. Let's test that understanding with a quiz on the
topics we've covered here.
