arr[1][0][:three]

# Question 5
I struggled with this until I took a breath and looked at it from the
deconstruction aspect. Quieting my mind and staying aware.

# Question 6
# line 1: variable assignment to string
# line 2: variable assignment to array of strings with variable in index[1]
# line 4: variable assignment to hash
# lines 5-7 hash key, value pairs. Each key is a symbol, followed by value
# which is an array.
# line 5 creates a single key, value pair (symbol => value)
# line 6 assigns variable representing array (line 2) as value to key in hash
# line 7 creates a single key, value pair (symbol => value)
# line 10 re-assigns hash value that references the array (line 2) and has
# the side effect of re-assigning the array's value to the new value `'hey'`.
# lines 12-14 Outer block execution. Iterate through the hash using the each method (return value is
# the calling object, not the block's return value) with each key, value pair
# parameter as 'language' and 'greeting_list' respectively. Outer block
# return is ignored.
# line 13 greeting_list (value object) calls the each method to iterate
# through all values and destructively alter their strings permanently. This has the side
# effect of changing all the strings inside the array's that are referenced
# from the hash.

# line 16: # => `hi` 
# `puts a` returns the initial variable string: `hi` because we
# re-assigned the value of the item in the array through the hash on line 10.
# This means that array no longer has a variable that references the `a`
# variable and `a` did not get altered because it was re-assignment, not an
# update.
#
# line 17: # => `HEY` 
# `puts english_greetings[1]` this references what was originally
# the `a` variable which references 'hi', however due to the re-assignment in
# line 10, it now is simply `hey`, however it is `HEY` due to the destructive
# alteration (updates) to the strings on line 13.
#
# line 18: # => `HEY`
# Same return value as line 17 because the hash is referencing the array in
# the return value.

# Question 7
# line 1 nested array object calls map method to iterate over outer array
# accessing each inner array upon iteration, eventually returning a new array # => [['A', 'B'], ['C', 'D'], ['E', 'F']]
# lines 1-5 outer block execution returns an array from the transformed
# values from the inner block (lines 2-4) and this determines the return value of the
# upper level map method.
# line 2 upon each iteration from outer block, each inner array calls the map
# method providing access to each inner array index (letter).
# lines 2-4 inner block execution returns an array of transformed letters and
# passes the return value to the outer block.

# Questions 8-10 Your brief is to produce code that lets the Sales Department
# report on the value of orders per customer. Each order is represented by a
# hash within an array, but there may be more than one order per customer.
# The Sales Department wants to report two things:

# 1.  The total value of orders for each customer
# 2.  The total value of *fulfilled* orders for each customer

# restructured data comes from iterating through the order_data array of
# hashes and returning a new array with a single hash for each customer that
# includes:
# customer_orders = [
#   {
#     customer_id: integer, 
#     customer_name: 'string', 
#     orders:[
#       {order_fulfilled: boolean, order_value: float}
#     ]
#   }
# ]

# Original data structure:
# order_data = [
#   {customer_id: 12, customer_name: 'Emma Lopez', order_id: 351, order_date: '12/04/16', order_fulfilled: true, order_value: 135.99},
#   {customer_id: 12, customer_name: 'Emma Lopez', order_id: 383, order_date: '12/04/16', order_fulfilled: true, order_value: 289.49},
#   {customer_id: 12, customer_name: 'Emma Lopez', order_id: 392, order_date: '01/10/17', order_fulfilled: false, order_value: 58.00},
#   {customer_id: 32, customer_name: 'Michael Richards', order_id: 241, order_date: '11/10/16', order_fulfilled: true, order_value: 120.00},
#   {customer_id: 32, customer_name: 'Michael Richards', order_id: 395, order_date: '01/10/17', order_fulfilled: false, order_value: 85.65},
#   # rest of data...
# ]

# Question 9
# all_orders = [{customer info}, {customer info}]
# iterate through customer orders to access each inner hash and select
# certain key,value pairs while performing a full calculation for the same
# field order_value

