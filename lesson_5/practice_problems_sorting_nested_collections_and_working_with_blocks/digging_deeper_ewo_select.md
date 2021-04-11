# Digging Deeper: Iteration Methods

1. [Enumerable#each_wit_object(obj)](https://docs.ruby-lang.org/en/3.0.0/Enumerable.html#method-i-each_with_object)
2. [Array#map](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-map)
3. [Array#select](https://docs.ruby-lang.org/en/3.0.0/Array.html#method-i-select)

The Digging Deeper series comes from a need to process material from my Launch School lessons, especially during the embarking phase. The intention was simply a way for me to refine my understanding of things that I encounter and that speak to me on a level of necessity to further understand beyond the examples that have been given. This is primarily realized when I am taking the quizzes at the end of the lesson and come to realize that what I thought I understood was not complete.

The goal is to be explorative and go through different scenarios that I can test to make sure I understand the core structure of collections, blocks and to be clear on each method's and block's implementation and return value and any side effects.






#### Example 8: EWO and select

>  It can be tricky to work with different objects in a nested array if you want to only select nested elements based on certain criteria. For example, take the 2\-element array below, where we only want to select integers greater than 13 but strings less than 6 characters. The trick here is that the elements are in a two layer nested array data structure.

```ruby
# Launch School Solution
[[8, 13, 27], ['apple', 'banana', 'cantaloupe']].map do |arr|
  arr.select do |item|
    if item.to_s.to_i == item    # if it's an integer
      item > 13
    else
      item.size < 6
    end
  end
end
# => [[27], ["apple"]]
```
>  At first you might think to reach for the `select` method to perform selection, but since we're working with a nested array, that won't work. We first need to access the nested arrays before we can select the value we want. In order to select the specified values in the requirement, we need to first determine if an element is an integer; there are lots of ways to do this, we just went with the imperfect `item.to_s.to_i == item` test.

> One of the main reasons `map` is used in this example is not only to iterate over the array and access the nested arrays, but to return a new array containing the selected values. If we used `each` instead we wouldn't have the desired return value, and would need an extra variable to collect the desired results.



Most of the time I tend to get tripped up a bit with the select method in how it returns a value from a nested array. I understand better now that select simply won't work on a nested array the way I would imagine. In their example, they say to use the #map method but that is because they will have values between the two conditional statements. I wanted a simpler way to keep these methods together in the proverbial tool chest. 

1. **Use #select to select items and return them as an array if it is a non-nested array.**

2. **Use #map to transform the whole array.** 

3. **Use #each_with_object when you need to return an object from a nested array as you can specify what kind of object it is you would like to return.**

```ruby
# My solution
array = [[8, 13, 27], ['apple', 'banana', 'cantaloupe']]
array.each_with_object([]) do |sub_arr, array|
 sub_arr.select do |item|
   if item.is_a?(Integer)
     array << item if item > 13
   elsif
     item.is_a?(String)
     array << item if item.size < 6
   end
 end
end
# => [[27], ["apple"]]
```

#### `Array#map`

So, using map on a nested array we automatically access and can iterate through the nested array. It will return an array with the value returned from the block's whether truthy or nil. Meaning if a condition is applied to retrieve an object, it will collect it but others 

```ruby
# Using Array#map and Array#select
array = [[1, 2, 3, 4], ["a", "b", "c"]]
array.map do |sub_arr|
  sub_arr.select do |item|
    item if item.is_a?(Integer)
  end
end
# => [[1, 2, 3, 4], []] this is an empty array or often nil
# This really only works with collections you will return the collection with transformed in some way even though you can theoretically return a subset

```

Let's looks at Enumerable#each_with_object

```ruby
# Using Enumerable#each_with_object and Array#select
array = [[1, 2, 3, 4], ["a", "b", "c"]]
array.each_with_object([]) do |sub_arr, target|
	sub_arr.select do |item|
		target << item if item.to_s.to_i == item
	end
end
# => [1, 2, 3, 4] Much cleaner and no mucking around with another method that can work with a lot of tinkering.
```

So knowing all that jazz and the idea that this is a walk through of the things that have been haggling my comprehension during this lesson 5... let's see it in action where I give a nested hash of dogs and their details. Then I want to retrieve the details in a transformed way as well as only make a selection based on certain criteria. If the dog's size is small, return the dog's name and its color - capitalized. If the dog's size is large return large, return the dog's name and weight but change the weight abbreviation to uppercase. If the dog's size is medium, return nothing.

```ruby
dogs = {
  'Lulu' => {weight: '49.8 lbs', colors: ['black', 'white'], age: 9, size:
'considered large, but mostly small'},
  'Kona' => {weight: '80 lbs', colors: ['dark grey', 'light grey', 'black'],
age: 5, size: 'large'},
  'Einstein' => {weight: '80 lbs', colors: ['dark grey', 'light grey', 'black'],
age: 15, size: 'large'},
  'Blue' => {weight: '75 lbs', colors: ['light grey', 'white'],
age: 12, size: 'large'},
  'Kusi' => {weight: '5 lbs', colors: ['grey', 'brown'],
age: 12, size: 'medium'}
}


dogs.each_with_object([]) do |(key, value), array|
  if value[:size].include?('small')    
    export = value[:colors].map do |color|
      color.capitalize
    end
    export.prepend("#{key}: ")
  elsif
    value[:size] == 'large'
    export = "#{key}: " + "#{value[:weight]}".upcase
  else
    next
  end
  array << export
end

```


