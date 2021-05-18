def get_users_input(hsh)
  puts 'p, c, or r'
  hsh << gets.chomp
end

def reset_local_var(var_1, *vars)
  var_1.clear
  if vars
    vars.each { |item| item.clear }
  end
end


def set_users(hsh)
  if hsh[:user_1] && hsh[:user_2] != ''
    reset_local_var(hsh[:user_1], hsh[:user_2])
  end
  if hsh[:user_choice] == 'r'
    computer_chooses(hsh)
  else
    set_user_order(hsh, hsh[:user_choice].to_sym)
  end
end

def computer_chooses(hsh)
  if hsh[:computer_choice] == ''
    hsh[:computer_choice] << hsh[:r].sample
  end
  set_user_order(hsh, hsh[:computer_choice].to_sym)
end
   
def set_user_one(hsh, sym)
  hsh[:user_1] << hsh[sym]
end

def set_user_two(hsh)
  hsh[:user_2] << hsh[:p] if hsh[:user_1] == 'Computer'
  hsh[:user_2] << hsh[:c] if hsh[:user_1] == 'Player'
end

def set_user_order(hsh, sym)
  set_user_one(hsh, sym)
  set_user_two(hsh)
end

def initialize_users
  { p: 'Player',
    c: 'Computer',
    r: [ 'p', 'c' ],
    valid_user_inputs: [ 'p', 'c', 'r' ],
    user_choice: '',
    computer_choice: '',
    user_1: '',
    user_2: ''
  }
end

users = initialize_users
get_users_input(users[:user_choice])
set_users(users) 
p users
