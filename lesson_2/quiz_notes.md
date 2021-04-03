[Lesson 2 Quiz](https://launchschool.com/quizzes/6d446599)

Same as previous lesson quiz, this is all pretty straightforward with the same sort of details being overlooked when making a mistake on my part.

- #10. There is an error in the code below; identify what it is. *This was mostly the fact that I forgot how variable scope works when inside of the block, in this case the block from the loop do .. end initializes a variable that is not accessible outside of the block*.

- #12. **Variable Scope**: This one is good practice to get under my belt. I keep getting stuck on thinking that a block is what resides inside the curly braces e.g. `{}` or `do..end` and I would be right but it is not always the case. 


> "Blocks are delimited by either curly braces `{}` or `do/end`; however, code
> enclosed in this way **does not always** constitute a block. It is
> considered a block (and thereby creates a new scope for variables) if the
> `{}` or `do/end` immediately follows a method invocation. For example,
> following the `while` keyword with `do/end` does not constitute a block:"
```ruby
while true do
  a = 5
  break
end

> a # => 5
```

> \* Note: the key distinguishing factor for deciding whether code delimited by `{}` or `do/end` is considered a block (and thereby creates a new scope for variables), is seeing if the `{}` or `do/end` immediately follows a method invocation. For example:

```ruby
arr = [1, 2, 3]

for i in arr do
  a = 5      # a is initialized here
end

puts a       # is it accessible here?
```

> The answer is yes. The reason is because the `for...do/end` code did **not** create a new inner scope, since `for` is part of Ruby language and not a method invocation. When we use `each`, `times`and other method invocations, followed by `{}` or `do/end`, that's when a new block is created.

- #13 On Variable Scope and Shadowing. This was good to go and get reacquianted with variable shadowing. What I've learned is that apparently "Variable shadowing in Ruby relates specifically to when a block parameter of the same name is used." Although I mistakenly (seemingly) confused variable shadowing as related to this question because the method is passing a parameter with the same name as the outer scoped variable, so that isn't technically variable shadowing by way of the below definition where specifically when a block parameter of the same name is used (see below). View links in order of clarity:
- [Variable Scope Refresher](https://launchschool.com/books/ruby/read/variables#variablescope)
- [Lesson 2: Small Problems > 19 Variable Scope](https://launchschool.com/lessons/a0f3cd44/assignments/fff0b9db) note that this has brought me to creating my own rb file to explore this in more depth located here: [shadow_test.rb](file:///Users/monte/Projects/launch-school/rb101-programming-foundations/lesson_4/shadow_test.rb) and this goes through the outer and inner scope to show how objects get re-assigned and how that affects their object_ids.
  - Some takeaways from the 19_variable_scope article:
  - Ruby blocks create a new variable scope for local variables. "You can think of the scope created by a block following a method invocation as an *inner scope*. Nested blocks will create nested scopes. A variable's scope is determined by where it is initialized."
  - **Variables initialized in an outer scope can be accessed in an inner scope, but not vice versa.**
- [Medium 2 Question 1 Problem ](https://launchschool.com/lessons/263069da/assignments/643eae16) and  [Medium 2 Question 1: Discussion Question](https://launchschool.com/posts/7626a14d), which has a good explanation on what is considered variable shadowing in Ruby:

> ...the code in used in this question isn't actually an example of variable shadowing. **Variable shadowing in Ruby relates specifically to when a block parameter of the same name is used**. So, the example you provided above is an example of this:

```ruby
n = 10

1.times do |n|
  n = 11
end

puts n          # => 10
```
> "Here the block parameter `n` on line 3 essentially initializes a *new*
> variable of the same name in a different scope. The existence of this
> variable effectively prevents access to the `n` initialized on line 1 in the
> outer scope."

- #14: This seems completley understandable now after looking at it and the deep dive of scoping I've now gone through.

#### Extra Consideration

Very important to understand that when working with [Mutating and non-mutating methods](https://launchschool.com/blog/mutating-and-non-mutating-methods) mutating methods do not change the memory address because they modify the object "in place" rather than *creating a new object in memory*.

> Also, assignments do not change an object's location in memory. They make variables point to a different location in memory (meaning, they point to a different object). It is incorrect to say that the object's location in memory changed. The new object was created, and this object occupies a different location in memory. [link to discussion](https://launchschool.com/posts/b6706de7)

