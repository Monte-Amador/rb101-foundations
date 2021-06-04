This finally is setting in now. This revisit helped me untangle the threads from my mind, I basically rubber ducked this and now have Opus to hear me out when I'm in the kitchen. In the end, it's all about getting out of the various depths in your brain and get deep into the mind of what it is you are doing.

## Selection

The selection method works by providing criteria that it considers truthy and will return that item. The problme that has been vexing me was when I used it for digging into a nested array. Any time from here on out that I get confused I will simply bring it back to a standard collection type and go from there.
For instance, in a nested array the select method will return every single array that has a truthy condition. So using this as an example:

```ruby
hand = [["3", "H", 3], ["4", "C", 4], ["A", "H", 11], ["A", "C", 1], ["K", "S", 10]]
```
If we want to return a new array of just the integers in each nested array, we are aiming for an index of 2. So explicitly we are calling `hand[0][2] => 3` for example. At first light, I thought since I was running a selection from the collection, the Array#select method would work out just fine. But once it returned every nested array in its entirety, I got puzzled. Of course, it was operating exactly as it was supposed to. I, however, would seem that I wasn't.

```ruby
hand.select { |sub_array| sub_array[2] }
=> [["3", "H", 3], ["4", "C", 4], ["A", "H", 11], ["A", "C", 1], ["K", "S", 10]]
```
I knew `sub_array[2]` would be truthy and return just what I needed since I had already tested this in a very simple irb arena with a standard array like so:

```ruby
arr = ['3', 'H', 3]
arr.select { |item| item == 3 }
=> [3]
```
Et voila! But no... I didn't realize the nested array would be throwing me off the way it was. I even went so far as to get at the nested array by running another Array#select method in succesion: (beware, it's only getting uglier here during my experiment and I do, truly, apologize but this is my rubber duck of course).

```ruby
hand.select do |sub_array|
  sub_array.select { |item| item[2] }
end
=> [["3", "H", 3], ["4", "C", 4], ["A", "H", 11], ["A", "C", 1], ["K", "S", 10]]
# here I clearly didn't understand to the teeth how the return method would work as it would return another round of exact same values.
```
I needed a way to get out of having the Array#select method returning the whole nested array instead of just the value. 


## Array#map to the rescue, sort of but worse.
I then decided to try the Array#map just for a hack-n-slash mind tickle for quick verification that what I was mapping out in my own brain was the truth. 

Here's where it all got very interesting. Because of the way I was going about the solution to my specific problem, I actually got it to work the way I had hoped on my first try. But again, humility in understanding that I just _don't_ get it all the way. 

I simply created an empty array and using the Array#map method, ran this in irb with my very basic example.

```ruby
total = []
arr = ['3', 'H', 3]
arr.map { |item| total << item if item == 3 }
total => [3]
```
As always, this seemed to be exactly what I was looking for, but by now I had learned my lesson and decided to test this out further by giving the block a boolean expression so I could see exactly what the block was actually returning. 

```ruby
arr.map { |item| item == 3 }
=> [false, false, true]
```
Right... now that I see it I get it. This means what what actually happening behind the scenes did give me my desired total that I was appending it to, but when I instead decided to write more clear code, I thought that assigning a variable to hold the return value would be better and that's when I realized what was going on:

```ruby
my_total = arr.map { |item| item if item == 3 }
=> [nil, nil, 3]
```
Now, yes, there are workarounds to get exactly what I was wanting within both the Array#select and Array#map methods, but this is where I stumbled when it came to a nested collection. I had a hard enough time understanding the way each of these would return their values on a simple array. And yes, although I did manage to find ways to work it out between these methods I just wanted something that was much more what you see is what you get kind of approach.

## Enumerable#each_with_object 
- [module Enumerable - Documentation for Ruby 3.0.0](https://docs.ruby-lang.org/en/3.0.0/Enumerable.html#method-i-each_with_object)
> Iterates the given block for each element with an arbitrary object given, and returns the initially given object.

That sounds like what I was after. Have the straight ahead approach of using a standard each method to iterate but return an object of my own choosing. For a simple array like my earlier examples it's overkill for my needs, however for a nested collection like an array or hash, this is pure silk for me. 

I know you can assign a variable to an empty array and append to it accordingly, but doing that made me reach for the Array#each method and I wanted a way to better handle return values to specify exactly what I was affter in this situation.

Here we go...

### Recap Code

```ruby
hand = [["3", "H", 3], ["4", "C", 4], ["A", "H", 11], ["A", "C", 1], ["K", "S", 10]]
# target we are shooting for
# we want an array that is made up of all the selected integers in the hand array.
# the new array should be all integers so that we can further apply methods to it.
# nested_array => select specific indices that are integers => return as new array
```

```ruby
total = hand.each_with_object([]) do |sub_arr, arr|
  arr << sub_arr.select { |item| item[2] }
end
=> [[3], [4], [11], [1], [10]]
```
Now that was what I was hoping for. I can now flatten the array provide other useful methods to that return value. I did this mostly to show how it can work with the Array#select method but a far simpler solution in this case was just as simple as:

```ruby
silky_array = hand.each_with_object([]) do |sub_arr, arr|
  arr << sub_arr[2]
end
=> [3, 4, 11, 1, 10]
```
