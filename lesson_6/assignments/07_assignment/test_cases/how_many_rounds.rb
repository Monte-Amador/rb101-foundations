def display_error
  error = <<~MSG
  please check input type (string/integer) 
  and all valid input strings 
  (e.g. ['Yes y no n'])
  MSG
  prompt error
end

def validate_integer_input(int)
  return false if int.to_i.to_s != int
    int.to_i
end

def integer_in_range(str, range)
  return false if !validate_integer_input(str)
  int = str.to_i
  case range.size
  when 2
    return int if int.between?(range[0], range[1])
    return false
  when 1
    return int if range.join.to_i == int
    return false
  else
    display_error
    return nil
  end
end

def string_in_range(str, range)
  test_string = range.join(' ').split
  string = str.strip.downcase
  return string if test_string.include?(string)
  return false
end

def validate_user_input(str, data_arr, type)
  case type.downcase
  when 'integer'
    integer_in_range(str, data_arr)
  when 'string'
    string_in_range(str, data_arr)
  else
    display_error
  end 
end

def prompt(msg)
  puts "=> #{msg}"
end

def ask_how_many_rounds
  rounds = ''
  loop do
    message = <<~MSG
    How many rounds 
    do you want to play?
    (max rounds = 5)
    MSG
    prompt message
    answer = gets.chomp
    answer = '1' if answer == ''
    valid_inputs = [1,5]
    rounds = validate_user_input(answer, valid_inputs, 'integer')
    p rounds
    break if rounds != false
    prompt 'sorry, please input a valid number 1-5'
    end
    rounds
  end

ask_how_many_rounds
