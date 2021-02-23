# input: string
# output: array of substrings
# rules:
#      Explicit requirements:
#        - return palindromes from the input string to an array as a substring.
#        - Palindromes are case sensitive ("Dad" is not a palindrome, but "dad" is.)
#        
#      Implicit requirements:
#        - The returned array should be a new object.
#        - If the string is an empty string, the result should be an empty array
#       

# Algorithm:
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#  - if the word is a palindrome, append it to the result
#    array
#  - return the result array