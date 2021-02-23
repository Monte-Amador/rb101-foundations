str = "luckylul"
limit = 2
result = []
substring = str.chars

if substring.size > limit
  base_index = 0
  counter = base_index + 1
  iteration = substring.size - 1
  while base_index < (substring.size - 1) do
    set = substring[base_index..counter].join
    result << ("#{set}") if "#{set}" == "#{set}".reverse
    counter += 1  
    if counter == substring.size
      base_index +=1
      counter = base_index + 1
    end
  end
end
p result


