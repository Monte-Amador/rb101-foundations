=begin
Question 5

Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.

Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

  limit = 15

  def fib(first_num, second_num)
    while first_num + second_num < limit
      sum = first_num + second_num
      first_num = second_num
      second_num = sum
    end
    sum
  end

  result = fib(0, 1)
  puts "result is #{result}"

How would you fix this so that it works?
=end

limit = 15

  def fib(first_num, second_num, lim)
    while first_num + second_num < lim
      sum = first_num + second_num
      first_num = second_num
      second_num = sum
    end
    sum
  end

  result = fib(0, 1, limit)
  puts "result is #{result}"

=begin
the error "undefined local variable or method `limit' for main:Object" is thrown because of the fact that limit is defined outside of the method and is therefore inaccesible to the method. If we have to keep the variable defined outside of the method, then we should pass limit as an arguement to the fib method. This way we can create a new parameter with the fib method.
=end