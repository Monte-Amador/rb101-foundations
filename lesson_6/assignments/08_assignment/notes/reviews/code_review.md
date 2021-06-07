I would like to ask for a code review on my RPS bonus feature assignment. Any feedback is very welcome, thank you!

There are two parts that are disabled from rubocop because I was confused by the offenses, although I think they were in line with the questions I had for those specific parts. I would like to know of a better way to handle the `deal` and `user_turn` methods.

The `deal` method has a lot of variables assigned througout the method in order to make it more readable while I was assembling the string. Although it works as is, I would like to know of any better suggestions that would make this more simple to read and follow.

The `user_turn` method has a very intricate rubocop offense that I spent a lot of time working out. In the end I believe it is due to the multiple break and conditional statements, but still could not get it to function properly. 
I am hoping to learn a little more about how to handle this particular offense and just better method hygiene when working with so many conditionals.
