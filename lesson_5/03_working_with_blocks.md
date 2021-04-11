# [Working with Blocks](https://launchschool.com/lessons/c53f2250/assignments/c633cf37)

The goal is to have a deep understanding of how each detail works, not to
complete this assignment as fast as possible.

It can be very helpful to map things out visually in order to keep track of
what is going on.

What specific pieces of information are we interested in keeping track of?
When evaluating code, ask the following questions:

1. What is the type of **action** being performed (method call, block,
conditional, etc..)?
2. What is the **object** that action is being performed on?
3. What is the **side-effect** of that action (e.g. output or destructive
action)?
4. What is the **return value of that action**?
5. Is the **return value used** by whatever instigated the action?

We can take these pieces of information and set them out in a tabular format:

## Example 1

```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]		
```



| Line | Action | Object | Side Effect | Return Value | Is Return Value Used? |
| --- | --- | --- | --- | --- | --- |
| 1 | method call (`each`) | The outer array | None | The calling object | No, but shown on line 6 |
| 1\-3 | block execution | Each sub\-array | None | `nil` | No |
| 2 | method call (`first`) | Each sub\-array | None | Element at index 0 of sub\-array | Yes, used by `puts` |
| 2 | method call (`puts`) | Element at index 0 of sub\-array | Outputs string representation of an Integer | `nil` | Yes, used to determine return value of block |



## Example 2

```ruby 
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
end
# 1
# 3
# => [nil, nil]
```



| Line | Action                 | Object                          | Side Effect                              | Return Value                            | Is Return Value Used?                  |
| ---- | ---------------------- | ------------------------------- | ---------------------------------------- | --------------------------------------- | -------------------------------------- |
| 1    | method call (map)      | The outer array                 | none                                     | new array [nil, nil]                    | No, but shown                          |
| 1-3  | block execution        | each sub-array                  | none                                     | nil                                     | yes, used for transformation by `map`  |
| 2    | method call (``first`) | each sub-array                  | none                                     | returns element at index 0 of sub-array | yes, used by `puts`                    |
| 2    | method call (`puts`)   | element at index 0 of sub-array | outputs string representation of integer | nil                                     | yes, used to determine value of block. |



## Example 3

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
# => 1
# => 3
# => [1, 3]
```





| Line | Action                | Object                          | Side Effect                                 | Return Value                    | Is Return Value Used?                                        |
| ---- | --------------------- | ------------------------------- | ------------------------------------------- | ------------------------------- | ------------------------------------------------------------ |
| 1    | Method Call ( `map` ) | The Outer Array                 | none                                        | New array: `[1, 3]`             | No                                                |
| 1-4  | Block Execution       | Each Sub-Array                 | none                                        | Integer at index 0 of sub-array | yes, `map` will use this for transformation                  |
| 2    | Method Call(`first`) | Each sub-array                 | none                                        | element at index 0 of sub-array | yes, in `puts` output                                        |
| 2    | Method call(`puts`) | Integer at index 0 of sub-array | outputs string representation of an integer | nil                             | no                                                           |
| 3    | method call (`first`) | each sub-array                  | none                                        | element at index 0 of sub-array | yes, added to final array from `map` \| Yes, used to determine return value from block |



## Example 4

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
# => 18
# => 7
# => 12
# => my_arr == [[18, 7], [3, 12]]
```



1: assign `my_arr` variable to the return value from the nested array calling the `Array#each` method on the outer method to iterate on the sub-array

1-7: block execution sub-array calls `Array#each` to iterate through the sub-array's individual indices (`num`) performing a comparison of each value against `5`. If the `num` is greater than 5 then output the string representation of the integer.

2-6: sub-array (`arr`) calls `Array#each` method to iterate over each index (`num`)

3-5: if the `num` is greater than 5 then perform line 4

4: output the `num` with `puts` 

The return value from `puts` is `nil` so the inner block returns `nil` however the `Array#each` method returns the calling object, in the case of the inner block that would be last iteration: `[3, 12]`. In the case of the outer block, that will return the original caller of `[[18, 7], [3, 12]]` so `my_arr` == `[[18, 7], [3,12]]`



| Line | Action                     | Object                                                       | Side Effect                                   | Return Value                                                 | Is Return Value Used?                                        |
| ---- | -------------------------- | ------------------------------------------------------------ | --------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | method call (`Array#each`) | the outer array (nested)                                     | none                                          | the original calling object                                  | Yes, it is assigned to the variable `my_arr`                 |
| 1-7  | outer block execution      | each sub-array                                               | none                                          | original calling object (each sub-array)                     | no                                                           |
| 2    | method call (`Array#each`) | each sub-array                                               | none                                          | original calling object (each sub array in current iteration) | yes, used to determine return value of outer block (*note my initial answer was no but this seems to be acknowledging that I am missing some sort of return value upon each iteration and what happens with that return value*) |
| 2-6  | inner block execution      | element of the sub-array in that iteration                   | none                                          | nil                                                          | no                                                           |
| 3    | comparison (`>`)           | element of the sub-array in that iteration                   | none                                          | boolean                                                      | yes, output to `puts` if `num > 5`                           |
| 3-5  | conditional (`if`)         | element of the sub-array in that iteration (note that the lesson's answer was very different than mine: *The result of the expression `num > 5`*) | none                                          | nil                                                          | yes, used to determine return value of the inner block.      |
| 4    | method call `puts`         | element of the sub-array in that iteration                   | outputs a string representation of an integer | nil                                                          | No (again, the lesson's answer was very different: *Yes, used to determine return value of the conditional statement if the condition is met*) |



## Example 5

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
# => [[2, 4], [6, 8]]
```



1: outer nested array calls `Array#map` to create a new array with transformation made on each element (0, 1 respectively) in the outer array.

1-6: outer block execution returns array of elements that are truthy values from inner block's return values.

2: sub-array calls `Array#map` to transform each element within the sub-array in that iteration

2-4: inner block execution returns an array that contains the transformed values from each sub-array iteration if truthy, nil if not.

3: returns the result of `num * 2` for each element in the sub-array for that iteration



| Line | Action                | Object                                       | Side Effect | Return Value                                                 | Is Return Value Used?                                        |
| ---- | --------------------- | -------------------------------------------- | ----------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | method call (`map`)   | array `[[1,2], [3,4]]`                       | none        | new array `[[2, 4], [6, 8]]`                                 | no                                                           |
| 1-5  | outer block execution | each sub-array                               | none        | new array built from each sub-array iteration                | yes, to determine the return value of the top level `map` method |
| 2    | method call (map)     | each sub-array                               | none        | new array for each iteration e.g. `[2, 4]` & `[6, 8]` respectively | yes, to determine the return value to the outer block        |
| 2-4  | inner block execution | each element of sub-array                    | none        | new array with all return values from each iteration `[2, 4], [6, 8]` (NOTE: lesson's answer is integer) | yes, used by inner `map` for transformation                  |
| 3    | operation (`*`)       | each element of sub-array for that iteration | none        | integer: the result from `num * 2`                           | yes, to determine the return value of inner block.           |



## Example 6

Let's mix it up now with some variation. In the below example, we have an array of hashes, and we want to select all elements where every key matches the first letter of the value. Note that the keys are symbols here, so we'll have to do some conversion before comparison.

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]
```



1. Line 1 contains an outer array made up of two hashes. The outer array calls the `Array#select` method for each sub-hash.
   Lines 1-5: outer block execution returns the array of selected results from curent sub-hash point of iteration  based on the inner block's return values == true.
2. Line 2 sub-hash calls the `Array#all?` for each key, value pair
   Lines 2-4: inner block execution and returns boolean for all items in the sub-array matching criteria in line 3, passing that return to the outer block i.e. `Array#select` method block
3. Line 3 provides a conditional to test if the first letter in the `value` string equates to the string representation of the `key` returning boolean.



| Line | Action                       | Object                           | Side Effect | Return Value                                      | Is Return Value Used?                                        |
| ---- | ---------------------------- | -------------------------------- | ----------- | ------------------------------------------------- | ------------------------------------------------------------ |
| 1    | method call (`Array#select`) | outer array                      | none        | new array `[{ :c => "cat" }]`                     | no                                                           |
| 1-5  | outer block execution        | sub-hash                         | none        | results from inner block's return value `== true` | yes, to determine the return value of the `Array#select` top level method |
| 2    | method call (`Array#all?`)   | sub-hash                         | none        | boolean                                           | yes, to determine outer block return value                   |
| 2-4  | inner block execution        | each key, value pair of sub-hash | none        | boolean                                           | yes, to determine the return value of `Array#all?` method    |
| 3    | conditional (`==`)           | each key, value pair of sub-hash | none        | boolean                                           | yes, to determine return value of inner block                |



> #### Solution: 
>
> The first thing to notice here is the use of the `all?` method within the `select` block. Since `#select` specifically cares about the *truthiness* of the block's return value, using a method that returns a boolean works well. `all?` will return `true` if the block passed to it never returns a value of `false` or `nil` for every key/value pair in the hash. We're using `value[0] == key.to_s` to test whether all keys match the first letter of all their associated values. Note that the only hash that meets this criteria is `{:c => 'cat'}`, and the return value is an array.
>
> What would happen if, instead of using `all?`, we used `any?`. Why would this affect the return value of `select`?



Regarding the question in the solution, if we use the `any?` method, we get  `# => [{:a=>"ant", :b=>"elephant"}, {:c=>"cat"}]` due to the fact that even through the key,value pair `:b => 'elephant'` does not meet the criteria, the other key,value pair `:a => 'ant'` does and so returns the whole array due to the way we are testing the sub-hash as opposed to each key, value pair individually.



------

Note that the following examples `7, 8` are not intended to break down code as much as providing examples of certain nested data structures that we just went over, albeit breaking down the code line by line is great to keep going with. Once we get back to Example 9 we go back to the original idea of breaking apart a given solution, `7, 8` are just for deeper reference and examples.

## Example 7

This is a handy example that goes deeper into the `sort` and `sort_by` method with the `Array#<=>` 

>  Say for example we have an array of nested arrays which contain numeric strings, and we want to sort the outer array so that the inner arrays are ordered according to the *numeric* value of the strings they contain. Take, for example, the following 4\-element array of arrays.

```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
```

We know we can't just call the `Array#sort` method on the array because it's an array of strings, not integers. We know that the [`String#<=>` method](https://docs.ruby-lang.org/en/3.0.0/String.html#method-i-3C-3D-3E) compares character by character not by length. So if we run the `arr.sort` it would give us `# => [["1", "8", "11"], ["1", "8", "9"], ["2", "12", "15"], ["2", "6", "13"]]` for the return value and that is not what we're aiming for. 

The `Enumerable#sort_by` method: "Sorts *enum* using a set of keys generated by mapping the values in *enum* through the given block." I had to work with this a few times to understand that it uses the block not as a return value for output but as an array by which to order the original `enum` by. 

Knowing this, we can call the `Enumberable#sort_by` method on the `arr` object and iterate over each sub-array. We can then include an inner block to transform the items of each sub-array into an array of integers using the `Array#map` method. This will return an array to give us the keys to sort the array numerically even though the return value of the `sort_by` method will be an array of strings like the original `arr` just ordered numerically as it were:

```ruby
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
# => [["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]
```



> #### Ruby Doc:
>
> The current implementation of [`sort_by`](https://docs.ruby-lang.org/en/3.0.0/Enumerable.html#method-i-sort_by) generates an array of tuples containing the original collection element and the mapped value.

> #### Launch School
>
> The key here is understanding that when we carry out transformation within a `sort_by` block, the transformed elements are what are then used to perform the comparison. As long as what is returned by the block is comparable, we can perform whatever transformation we need to within the block \- including nesting other method calls within it.



## Example 8

NOTE: the `select` method doesn't work on this problem because the `select` method only considers the truthy return value of the block. This is where the inherit issues came into play and why we use `select` in the inner block but we use `map` on the outer block.



## Example 9

This example contains a triple\-level nested array. Take your time and try to break down each component. Hint: the top\-level array is a 2\-element array.



```ruby
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]
```



- Line 1: 2-element array object calls `map` to iterate over each sub-array
- Lines 1-7: outer block (level 1) execution returns new array from inner block(s) return values
- Line 2: each sub-array iteration calls the `each` method to perform another block on each sub-array.
- Lines 2-6: inner block (level 2) execution iterates through and creates returns a partition of elements that match the conditional, however that return value is ignored due to `each` ignores the return value and returns the calling object instead.
- Line 3: each sub-array element calls the `partition` method to return two separate arrays
- Lines 3-5: inner block (level 3) returns every element that matches the conditional of having a size > `0` in one array and all those that do not equate to true in the other. 
- Line 4: conditional testing the element's size of each element is greater than `0`



## Example 10

- Line 1: Calling Object => nested array made up of two sub-arrays which hold other (non-nested) arrays calls `Array#map` method to return a new array with transformed (incremented) elements.
- Lines 1-11: outer block (level 1) execution returns array of transformed elements and passes it up to the top level `map` method as its return value
- Line 2: calls `map` method on each sub-array_1 iteration
- Lines 2-10: inner block (level 2) tests if sub-array_1 element in this iteration is an integer or another array, if it is an integer, increase integer by 1, if it is another array, call `map` on sub-array_1 to increase each element of sub_array_2 by 1 (assumes it is an integer). returns incremented integers in new array to line 2.
- Line 3: conditional returns boolean `true` element is an integer
- Lines 3-9: inner block (level 3) increases each integer element by 1 and returns their values to sub_array_1 inner block (level 2).

| Line | Action                                       | Object      | Side Effect | Return Value                   | Is Return Value Used?                                  |
| ---- | -------------------------------------------- | ----------- | ----------- | ------------------------------ | ------------------------------------------------------ |
| 1    | method call (map)                            | outer array | none        | new array: transformed  values | no                                                     |
| 1-11 | outer block (level 1) execution              | sub_array_1 | none        | new array                      | yes, determine return value for top level `map` method |
| 2    | method call (map)                            | sub_array_1 | none        | new array: transformed values  | no                                                     |
| 2-10 | inner block (level 2)                        | el          | none        | new array                      | yes, determines return value of outer block (level 1)  |
| 3    | conditional `if integer`                     | el          | none        | boolean                        | no                                                     |
| 3-9  | conditional (level 3) `if integer`or `array` | el          | none        | integer + 1                    | yes, determines return value of inner block (level 2)  |
| 4    | method call (addition)                       | el          | none        | integer + 1                    | yes, determines return value of inner block (level 2)  |