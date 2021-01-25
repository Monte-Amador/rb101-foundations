# 1. METHOD INITIALIZATIONS
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

def monthly_interest_rate(apr,time)
  apr / time
end

def monthly_payment(principle, monthly_interest_rate, time)
  principle * (monthly_interest_rate.round(4) / ( 1 - ( 1 + monthly_interest_rate.round(4) )**(-time)))
end

def total_interest_paid(monthly_payment, time, principle)
  (monthly_payment * time) - principle
end

# 2. USER INPUT AND VALIDATION
prompt("Welcome to the Monthly Loan Calculator! Please type in your name:")
name = gets().chomp()
prompt("Hello #{name}, Let's get started!")

loop do # main loop
  prompt("How much would you like a loan for?")
  loan_amount = gets().chomp().to_f() 
  
  prompt("Great, what is the Annual Percentage Rate (APR) of your loan?")
  apr = gets().chomp().to_f() / 100

  loan_duration_in_months = ''
  loop do
    prompt("Next, how many months will the loan be for?")
    loan_duration_in_months = gets().chomp()
    
    if number?(loan_duration_in_months)
      break
    else
      puts "Error, please try again."
    end
  end

  float_loan_duration_in_months = loan_duration_in_months.to_f()
  
  rate = monthly_interest_rate(apr, float_loan_duration_in_months)
  payment = monthly_payment(loan_amount, rate, float_loan_duration_in_months)
  total_interest = total_interest_paid(payment, float_loan_duration_in_months, loan_amount)
  total_including_interest = (total_interest + loan_amount)
    
  final_output_prompt = <<-MSG
  Thanks #{name}, based on your input here are your totals:
  Monthly Payments: $#{payment.round(2)}
  Loan Duration (months): #{loan_duration_in_months}
  Total Interest Accrued over #{loan_duration_in_months} months: $#{total_interest.round(2)}
  Total with interest paid: $#{total_including_interest.round(2)}
  MSG

  prompt(final_output_prompt)

  prompt("Would you like to make another inquiry? (Y to calculate again) ")
  answer = gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you #{name} for using the Mortgage/Auto Calculator, good bye!")