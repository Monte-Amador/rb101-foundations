def prompt (message)
  puts ">> #{message}"
end
def integer?(input)
  input.to_i().to_s() == input
end

def float?(input)
  input.to_f().to_s() == input
end

def number?(input)
  integer?(input) || float?(input)
end

prompt("Welcome to the Monthly Loan Calculator! Please type in your name:")
name = gets().chomp()

prompt("Hello #{name}, Let's get started!")

loop do
  prompt("How much would you like a loan for?")
  loan_amount = gets().chomp().to_f() 

  prompt("Great, what is the Annual Percentage Rate (APR) of your loan?")
  apr = gets().chomp().to_f() / 100

  prompt("Next, how many months will the loan be for?")
  loan_duration_in_months = gets().chomp().to_i

  monthly_interest_rate = apr / loan_duration_in_months

  monthly_payment = loan_amount * ( monthly_interest_rate.round(4) / ( 1 - ( 1 + monthly_interest_rate.round(4) )**(-loan_duration_in_months)))

  total_interest_paid = (monthly_payment * loan_duration_in_months) - loan_amount

  total_including_interest = (total_interest_paid + loan_amount)

  final_output_prompt = <<-MSG
  Thanks! Based on your input here are your totals:
  Monthly Payments: $#{monthly_payment.round(2)}
  Loan Duration (months): #{loan_duration_in_months}
  Total Interest Accrued over #{loan_duration_in_months} months: $#{total_interest_paid.round(2)}
  Total with interest paid: $#{total_including_interest.round(2)}
  MSG

  prompt(final_output_prompt)

  prompt("Would you like to make another inquiry? (Y to calculate again) ")
  answer = gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you #{name} for using the Mortgage/Auto Calculator, good bye!")