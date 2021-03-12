#[Launch School - an online school for Software Engineers](https://launchschool.com/lessons/85376b6d/assignments/fd13de08)

#### Practice Problem 9

# What is the return value of `map` in the following code? Why?
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end # => [nil, 'bear']
