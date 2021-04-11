outer_array = [[[1, 2], [3, 4]], [[5, 6], [2]]]

def increment(arr)
  arr.map do |sub_arr_1|
    sub_arr_1.map do |item|
      if item.to_s.size == 1 # item is an integer
        item + 1
      else # item is an array
        item.map do |element|
          element + 1
        end
      end
    end
  end
end
p increment(outer_array)      
p outer_array
