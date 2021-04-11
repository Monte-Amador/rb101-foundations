# Practice Problem 11
multiples_of_3 = arr.map do |sub_arr|
  sub_arr.select do |i|
    i % 3 == 0
  end
end
# => [[], [3], [9], [15]]
