# Practice Problem 10

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |sub_hash|
  sub_hash.map do |k, v|
    v + 1
  end
end
# => [[2], [3, 4], [5, 6, 7]]
