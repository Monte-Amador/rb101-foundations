def select_letter(question, letter)
  selected_letter = ''
  counter = 0
  loop do
    break if counter == question.size
    current_letter = question[counter]
    if current_letter == letter
      selected_letter << current_letter
    end
    counter += 1
  end
  selected_letter
end

question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a') # => "aaaaaaaa"
# p select_letter(question, 't') # => "ttttt"
p select_letter(question, 'z') # => ""
