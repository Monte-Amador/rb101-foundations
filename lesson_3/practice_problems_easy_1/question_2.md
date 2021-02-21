=begin
#### Question 2

Describe the difference between `!` and `?` in Ruby. And explain what would happen in the following scenarios:

1.  what is `!=` and where should you use it?
2.  put `!` before something, like `!user_name`
3.  put `!` after something, like `words.uniq!`
4.  put `?` before something
5.  put `?` after something
6.  put `!!` before something, like `!!user_name`
=end

I personally think the "solution" to this question doesn't match the question
itself. But if I were to explore the differences between `!` and `?` I would
say that `!` "Called Logical NOT Operator. Use to reverses the logical state
of its operand. If a condition is true, then Logical NOT operator will make
false." while `?:` is a ternary operator "Conditional Expression".

1. The `!=` is used when returning a boolean for whether or not something is
not equal to something else. A conditional expression.

2. Putting `!` before something negates the object it is in front of. Or
better to say it returns the opposite of the object's current boolean value.

3. Putting `!` after a word usually connotates a method that *may* mutate the
caller but you can't count on that.

4. I have no idea what that would do... I think nothing except erroring out.

5. Putting the `?` after something usually connotates the use of a method to
return true or false, but again you can't count on that. Best to look up the
documentation.

6. Putting `!!` before something will reverse the reversal of the boolean
value. Therefore if something was true then this would negate the negation
and return true for the object.
