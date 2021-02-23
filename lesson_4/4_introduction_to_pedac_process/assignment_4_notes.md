# Introduction to PEDAC process

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/2c1146ee)

> P - [Understand the] **P**roblem
>
> E - **E**xamples / Test cases
>
> D - **D**ata Structure
>
> A - **A**lgorithm
>
> C - **C**ode

### P \- \[Understand the\] **P**roblem Deeply

Understanding the problem has three steps.

1.  Read the problem description.
2.  Check the test cases, if any.
3.  If any part of the problem is unclear, ask the interviewer or problem requester to clarify the matter.

Let's walk through this process for the problem given below:

> ```ruby
> # PROBLEM:
> 
> # Given a string, write a method change_me which returns the same
> # string but with all the words in it that are palindromes uppercased.
> 
> # change_me("We will meet at noon") == "We will meet at NOON"
> # change_me("No palindromes here") == "No palindromes here"
> # change_me("") == ""
> # change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"
> ```

After reading this problem, some items may need clarification:

1.  **What is a palindrome?** You might ask the interviewer to tell you what a palindrome is, and the interviewer would tell you that it is a word that reads the same forwards and backward.

2.  **Should the words in the string remain the same if they already use uppercase?** Here, you can check the test cases. In the fourth test case, the word `LOVE` already uses uppercase, and it remains uppercase in the solution.

3.  **How should I deal with empty strings provided as input?** The test cases frequently answer this question. In this case, test case number 3 provides the answer. This is an implicit requirement that we can infer from the test cases.

4.  **Can I assume that all inputs are strings?** Test cases don't show any non\-string inputs, so you should ask whether the inputs can contain non\-string values, and what you should do with them. In this problem, we won't worry about non\-string values.

5.  **Should I consider letter case when deciding whether a word is a palindrome?** Again, test cases don't show any appropriate examples. The interviewer might tell you that the palindrome words should be case sensitive: `'mom'` is a palindrome, `'Mom'` is not.

6.  > **Do I need to return the same string object or an entirely new string?** This question is one of the most important and most overlooked that you can ask. Typically, while solving problems, students make certain assumptions. One assumption might be that they need to return the same string object. Students often start solving the problem without checking whether the assumption is correct. For this reason, the student might end up losing 10\-15 minutes struggling with the wrong problem. In this problem, you should return an entirely new string.

7.  **Always verify your assumptions either by looking at the test cases or by asking the interviewer.** Some assumptions, like whether we should treat strings as case\-sensitive or not, can be verified either by looking at the problem description, if that is mentioned there, or by checking the test cases. If you can't determine the answer with the test cases or problem description, you should ask the interviewer to clarify this for you.

To conclude this part of the PEDAC process, you need to write down what the inputs and outputs for the problem are. You should also describe the rules that you must follow. The rules should encapsulate all the explicit and implicit requirements in the problem. So, you should identify what the explicit requirements are, write them down, and then repeat the process for the implicit requirements:

```ruby
# input: string
# output: string (not the same object)
# rules:
#      Explicit requirements:
#        - every palindrome in the string must be converted to
#          uppercase. (Reminder: a palindrome is a word that reads
#          the same forwards and backward).
#        - Palindromes are case sensitive ("Dad" is not a palindrome, but "dad" is.)

#      Implicit requirements:
#        - the returned string shouldn't be the same string object.
#        - if the string is an empty string, the result should be an empty
#          array
```

[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/2c1146ee)



## Data Structure / Algorithm

Data structures influence your algorithm, and for that reason, these two steps are often paired. Deciding what data structure to use is generally easy for students: use cases for arrays and objects, for instance, are generally easy to identify. However, designing the right algorithm is far more challenging. The biggest problem that students have when writing algorithms is providing sufficient detail.

Let's consider another problem. Try to work through the "understand the problem" part of this problem on your own, and write the input, output, and rules for it. We'll provide a solution below. Later, we'll tackle the data structure and algorithm.

```ruby
# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []
```

```ruby
# Some questions you might have?
# 1. What is a substring?
# 2. What is a palindrome?
# 3. Will inputs always be strings?
# 4. What does it mean to treat palindrome words case-sensitively?

# input: string
# output: an array of substrings
# rules:
#      Explicit requirements:
#        - return only substrings which are palindromes.
#        - palindrome words should be case sensitive, meaning "abBA"
#          is not a palindrome.
```

What data structure could we use to solve this problem? The obvious choice seems to be an array since that's the desired output.

Now, we come to the algorithm part. Look at the algorithm written below.

```ruby
# Algorithm:
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#  - if the word is a palindrome, append it to the result
#    array
#  - return the result array
```

> This algorithm is a "high\-level" algorithm and it resembles those that we often see students write during interviews. It looks complete, but let's think about it for a moment: what is the hardest part of this problem? Is it looping through an array and pushing substrings that are palindromes in the result array? Is it determining whether a substring is a palindrome? Is it something else entirely?

