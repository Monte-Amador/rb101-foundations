# ALGORITHM:
# Example String: str = "my mom likes my dog"
# 
#   - initialize a result variable to an empty array 
# e.g result = []
# 
#   - split input string and save to strings_array
# e.g strings_array = str.split(' ')
# 
#   - loop_outer:
# e.g strings_array.size.times { for each strings_array's index create substring_array }
# 
#     - loop_inner:  
# e.g. substring_array.size.times { for each character set test if palindome } if substring_array > 2        
# 
#       - loop_inner:
# e.g. start with substring_array[0..1] end with substring_array[0..substring_array.length-2]
# e.g substring_array[0..1]