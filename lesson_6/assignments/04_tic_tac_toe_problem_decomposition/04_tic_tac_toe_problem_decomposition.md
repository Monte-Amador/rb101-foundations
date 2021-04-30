# Launch School - An Online School For Software Engineers

> You've probably played Tic Tac Toe before. If you haven't, you can read more about it on its Wikipedia page (note: just get a general idea; you don't have to read the whole thing).

You've probably played Tic Tac Toe before. If you haven't, you can read more about it on [its Wikipedia page](https://en.wikipedia.org/wiki/Tic-tac-toe) (note: just get a general idea; you don't have to read the whole thing).

We want to build a single player Tic Tac Toe game where a user can play against the computer.

#### Decomposing the problem

Before we can start coding, we need to come up with an approach to mentally map the solution. But before even starting to think about a solution, we have to first understand the problem better and decompose it more. For complex problems, a good starting point is describing the problem, and building a high level flowchart.

Let's try to write out a description of the game.

    Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
    marks a square on the board. First player to reach 3 squares in a row, including diagonals,
    wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.
    

That's a generic description, but in order to build a flow chart, we need to outline the sequence of the gameplay a little more.

    1. Display the initial empty 3x3 board.
    2. Ask the user to mark a square.
    3. Computer marks a square.
    4. Display the updated board state.
    5. If winner, display winner.
    6. If board is full, display tie.
    7. If neither winner nor board is full, go to #2
    8. Play again?
    9. If yes, go to #1
    10. Good bye!
    

You can see from the above sequence that there are two main loops -- one at step #7, after either the winner is found or the board is full, and another at step #9, after we ask if the user wants to play again. You can also notice that we are using higher level pseudo-code, and it's not formal pseudo-code. The reason is because we are staying at a zoomed out higher level for now, and all the imperative code -- the step by step directions -- is encapsulated into sub-processes. For example, the "display the board" doesn't go into exactly _how_ we should display the board. We'll just trust that a sub-process, or function, can take care of it. In other words, we trust we can figure that part out, but we need to focus on higher level thinking right now.

#### Flowchart

Take the sequence above, and let's try to draw a flowchart out of it.

![](moz-extension://d1b1wr57ag5rdp.cloudfront.net/images/ttt_flowchart.png)

Notice there's a lot of rectangle boxes, which stands for some sort of processing. The general flow is here, but it's a much higher level flowchart than what we've been working with in the past. You can see that the sub-processes will need to work with some sort of "board". Every sub-process, from "Display board", to "User marks square", to "board full?", requires inspecting the board. In some cases, like when we need to mark a square, we'll even have to permanently modify the board state.

With this flow chart in hand, we're finally ready to take our first step in writing some code.

Note: yes, you could spend more time here by writing out formal pseudo-code for each sub-process. That would be a far more detailed approach, and would be a great technique for a program that's more complicated. If you're still having a hard time deconstructing the logic of this program, go ahead and take that step. Zoom-in to each sub-process and try to outline exactly how to approach that problem.


[Source](https://launchschool.com/lessons/de05b300/assignments/0af5606d)

### Sub-Process Display Board
There needs to be a display of a 3X3 grid of some sort to display the board
from the start of the game. With every iteration between computer and player
there also need to be a way to updat the board with the computer/user's
input. One way to think about this would be to use the [Turn Rows Into
Columns With The Ruby Transpose
Method](https://www.rubyguides.com/2017/10/ruby-transpose-method/). 

1. Display an intial state of the board by storing the values in an 3 level
nested array.
with numeric values.

2. When user makes a choice,the numeric value would update an number by
specific values depending on their selection.  
  
  2.1 Let's say we have a grid with the first row being 1. The array to hold
the grid might be grid = [] Then each square would be [1.1], [1.2], [1.3]
respectively. Now suppose each array value for the square contains another
array that holds a string to represent the 'state' for that square, either
'X' or 'O'. This way of a user makes a selection for the upper right hand
corner of the board, that would equate to 1.3. If the user is playing 'X'
then and wants the upper right region of the board, the array would update to
[1.3]['X']] so the grid array would effectively look like this:
```ruby
grid = [ [1.1,[nil]], [1.2, [nil]], [1.3,['X']] ]
```
This way, a user or the computer could only select a section that has a
current value of nil within the array.
  
  2.2 Refinining it a little bit, we could bypass the need for the float number
and instead represent each row with its own array: [1, [1[nil]], [2,[nil]],
[3,['X']] for example.

3. re-calculate the board on the new values in the array displaying each
value if any.

4. needs to be a way to check strings and calculate (sub-process) 
