# Overview for process

1. display the updated board and the available spaces (array).
  1. (loop 1):
  2. player chooses from available spaces (update available spaces from choice)
  3. test to see if player won or if board is full(no more available spaces afterwards).
  4. if player wins game over, or if board is full, game over => 
    4.1 otherwise computer makes choice from available spaces (update available spaces from choice)
  5. test to see if computer won or if board is full(no more available spaces afterwards).
  6. if computer wins game over, or if board is full, game over => 
    6.1 otherwise player makes choice from available spaces by returning to the top of loop 1
  7. end (loop 1)

- check what the available arrays are at each iteration?
- strip out all necessary lines

