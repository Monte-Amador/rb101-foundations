# Breaking down the problem - Debugging yourself

At first glance everything actually looked like it was working, the logic had been designed methodically, I hadn't even opened up a code editor. I just sat with the problem and outlined one particular way to get to the solution. Granted it wasn't time for refactoring, I was just testing the logic of the approach all the way through.

I built test cases in `irb` and in separate Ruby files to make sure I was returning the values that I was expecting. And it was. That's where the bug found its way into the logic, from my own blind spot. But I wouldn't know it was there until I accidentally stumbled across it.

> Emotionally, I stayed centered as it's my style to get quite excited about things, especially as I grow towards something that I had envisioned - not as the ultimate goal mind you - but as a waypoint on this incredible path and that feeling that comes as if you are actually seeing the growth going on from an outside perspective.

So there I was, enjoying the testing and everything was pointing to integrating the solution into the new problem and I was confident it would work but was ready for the edge case or the syntax error. This was where I now know I set myself up for an expectation that could, and would, lead to frustration.

I plugged in the new method and the game didn't skip a beat. No errors and better still, the method was performing exactly as I had hoped. Brilliant.

Well, or so I thought. It wasn't until I started refactoring the code and running more tests to confirm it was working correctly that I discovered an oddity. I was so happy about my own approach to the problem (I'm sure this happens to everyone when they are learning something deeply and they have those 'aha!' moments). That I never considered the blind spot I had overlooked.

This is the most important part of this solution to this particular problem outlined within the curriculum. Understanding your own blind spots and identifying them deeply so you are more equipped when moving forward is the way to growth in any field but mostly yourself. 

Unfortunately, I had to leave the place I was in for nearly a week so I couldn't spend any more time on the debugging. I inevitably pushed myself that evening far beyond my own capacity because I knew I wouldn't be able to give it the attention the next day and I really don't like things hanging over me unfinished. Of course, that too is something I had to go through again, and coming to terms with your own limits and knowing when to let something go. I realized this and decided to use the LS method of breaking down the problem as a way of journaling what the problem was. That took far too long because of the type of action that was happening with the new method returning random values is not a great thing to figure logic out with. I ended up leaving a pretty stream-of-conciousness waypoint for me to come back to, but that too was anything but elegant as I was so tired from trying to figure out exactly what the problem was. Desperately, I finished the document and saved it. Shut it down and would be gone for the bulk of the following week.

So over the course of the next couple days I let everything go and it was okay. I was confident in knowing I had left myself some sort of breadcrumb trail to get myself back to. But any time you are learning something deeply, you have to maintain that high level of concentration and a lot of that also comes in the way of your own routine(s) that you have developed. Having such a break from that makes it far more time consuming to get that rhythm back.

## Back in the Saddle
Now that I've returned back to this problem, I watched myself as I untangled not only the problem but also myself. This helped, a lot. I decided to break up the problem to it's most minimal parts of the logic and was happy to get that random value out of the way. I could better concentrate on these very elusive return values that seemed to be correct, yet were still erring out. 

When I identified the bug, I was shocked because I had expected something fairly straightforward as with my previous assignments, but this was humbling, the issue was in the initial approach to the problem, not the logic nor the code. I forgot one aspect of the logic that would run a single comparison to validate which return values to choose from. What I spent time sitting with and crafting wasn't the issue at all, after copious amounts of testing and debugging I was more confused that it was working correctly. The problem lied in wait the whole time simply because I had never considered it. This is the blind spot. This is the way we can grow. This is a far deeper 'aha!' moment, one that I couldn't even get excited about. I simply had to let it sit so that I could explore this further in this article.

Great, so keeping something like this as a reminder helps keep you centered and forgiving of yourself since trying to do this all on your own it's inevitable that these blind spots will show up. And with every one, sitting with it will teach you something you can apply to the next round.

## What happened

The method I created to identify threats of two player markers in a winning line did not take into account to compare the threat to the available squares to use. In other words, the threat was always identified by looking at the current marks from the player and evaluating those marks against the WINNING_LINES constant variable. This correctly identified the threat consistently, however it would allow the computer to think that was a threat every time and would therefore pick the same defensive move even if the square was already taken. 

The remedy at this point was simply to evaluate the threat against available squares and distil that array into something the computer could pick from. 

This does bring up the point that both the computer and player should not be able to choose a square if the square is not empty. This happens currently with the player move validation, however it should be applied to the computer choice as well.

Looking ahead at the refactoring, the detect threats method I wrote has quite a lot of logic that should be distilled into separate methods. 

Next up, test and integrate the fix.

## Wrapping Up
Yes, it has been a very introspective adventure to say the least. So after everything I wrote above, I encountered a system error where I think my `.viminfo` file got messed up last night and the solution that I found and implemented on the debugging document no longer worked. Thankfully, as I wrote this document in the morning I was able to rebuild the solution and even refactor a little. 

By the time I inserted the solution into the actual Tic Tac Toe game, it worked as expected. I didn't have to change a thing. That's the glory of sitting with something and understanding the depth of the situation you have in front of you,, in order to come up with the right solution. 

Moving on from here there are more things to practice with and I'm nearly at the end of Ruby 101. I'm liking the progress, the challenge and the feeling.
