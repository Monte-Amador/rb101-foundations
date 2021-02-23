# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# TEST CASES:
# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []


# QUESTIONS:
# 1. What is a substring?
#    - A substring is a range of characters within an existing string.
# 2. Will inputs always be strings?
# 3. Will the string have any spaces?
# 4. If strings have spaces, how would we envision them being handled?
#   - i.e. simply strip them out in order to have one long string or do each word separately?

# ASSUMPTIONS:
# 1. We return an Array that contains the substring
# 2. Inputs will always be strings.
# 3. In case of white space, I should strip it out and make one long string since it returns the same as if you did each individual work (I think)
#
# 
# input: string
# output: an array of substrings
# 
# rules:
#     Explicit Requirements:
#       - every substring that is a palindrome needs to be returned to an array.
#       - Palindromes are case sensitive
# 
#     Implicit Requirements:
#       - if the string is an empty string, return an empty array
#       - if the substring does not contain any palindromes, return an empty array
# 
# 
# DATA STRUCTURE = ARRAY
# 
# ALGORITHM:
# Example String: str = "lulucha" (dogs name)
# Create empty array (result) 
# Create array from string (substring_array)

# IF substring_array.size > 2 then LOOP through each combination of letters in substring_array (lu, lul, lulu, luluc, luluch, lulucha, ul, ulu, uluc, uluch, ulucha, lu, luc... etc)
# 
#   - LOOP SCRATCH PAD:
#   - at first glance, the standard Array#each method seems to be the most plausible
#   - the WHILE loop may be a better fit for this.
#   - e.g. substring_array[0] == "l" so a range [0..1] should work
#   - set = substring_array[0..1].join 
#   - result.push(set) if set == set.reverse

# Return result array

def substrings(string)
  string.chars
end

def is_palindrome?(string)
  string == string.reverse
end

def print_palindromes(string, min)
  result = []
  substring_array = substrings(string)

  if substring_array.size > min
    starting_index = 0
    counter = starting_index + 1
    while starting_index < (substring_array.size - 1) do
      set = substring_array[starting_index..counter].join
      result << ("#{set}") if is_palindrome?("#{set}")
      counter += 1  
      if counter == substring_array.size
        starting_index +=1
        counter = starting_index + 1
      end
    end
  end
  result
end

str = "lulucha"
min_limit = 2
p print_palindromes(str, min_limit)