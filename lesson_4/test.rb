puts "=> select_letter method:"

# NOTES:

def select_letter(str,single_letter)
  letter_string = []
  counter = 0
  loop do
    break if counter == str.length
    letter_string << if str[counter] == single_letter
    counter += 1
  end
  letter_string.join
end

string = "Hello, my dog's name is Lulu. Also known as Lulucha."

p select_letter(string, 'o')
