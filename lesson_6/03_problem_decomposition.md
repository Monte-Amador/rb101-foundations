# Problem decomposition

We want to build a single player Tic Tac Toe game where a user can play
against the computer.

We need to start by defining an approach to mentally map the solution. But
before we even think about a solution, we first need to understand the
problem better and decompose it more. So let's describe the problem and build
a high level flowchart.

## General Description
Tic Tac Toe is a 2 player game played on a 3X3 board. Each player takes a
turn and marks a square on the board. First player to reach 3 squares in a
row, including diagonals wins. If all 9 squares are marked and no player has
3 squares in a row, the the game is a tie.

## Sequence of Game Play Outline

1. Display the initial 3X3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

#### Flowchart

Take the sequence above, and let's try to draw a flowchart out of it.

![](file:///Users/monte/Projects/launch-school/rb101-programming-foundations/lesson_6/images/ttt_flowchart.png)

Notice there's a lot of rectangle boxes, which stands for some sort of processing. The general flow is here, but it's a much higher level flowchart than what we've been working with in the past. You can see that the sub\-processes will need to work with some sort of "board". Every sub\-process, from "Display board", to "User marks square", to "board full?", requires inspecting the board. In some cases, like when we need to mark a square, we'll even have to permanently modify the board state.

With this flow chart in hand, we're finally ready to take our first step in writing some code.
