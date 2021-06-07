Code Review Request: 21 w/Bonus Features

I would like to ask for a code review on my [21 bonus features](https://github.com/Monte-Amador/rb101-foundations/blob/main/lesson_6/assignments/08_assignment/twentyone_bonus.rb) assignment. Any feedback is very welcome, thank you!

**Github Link**: https://github.com/Monte-Amador/rb101-foundations/blob/main/lesson_6/assignments/08_assignment/twentyone_bonus.rb

I am using rubocop `0.86`
The `deal` method has a lot of variables assigned throughout the method in order to make it more readable while I was assembling the string. Although it works as is, I would like to know of any better practices/suggestions that would make this more succint.

The `user_turn` method had a very intricate rubocop offense that I spent a lot of time working out. In the end, I got it reduced considerably and rubocop 0.86 seems to be happy with it. Still though, any suggestions specifically on how to better handle this kind of situation where I am trying to combine two very similar methods into one would be very welcome.

One last question, I have a break condition for the end of the main loop, however the game seems to exit the main loop without calling the last method for whether to continue or not. 

Thank you all for your great and invaluable work and support!
