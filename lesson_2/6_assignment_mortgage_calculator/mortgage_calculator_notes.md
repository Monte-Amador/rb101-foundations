## Instructions
Given 3 pieces of information:
- Loan Amount = (1000)
- Annual Percentage Rate = (0.05)
- Loan Duration in months= (12)

Create Calculations
- Monthly Interest Rate (0.004166667) # (APR / 12)
- Loan Duration in Months (12)
- Monthly Payment Target ($85.61)

## LS Provided Formula
m = p * (j / (1 - (1 + j)**(-n)))

- m = monthly_payment 
- p = loan_amount
- j = monthly_interest_rate
- n = loan_duration_in_months

monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_in_months)))

m = 1000 * (0.004166667 / ( 1 - (1 + 0.004166667)**(-12))) # works correctly


### Further Investigation
I noted that there is a very specific formula to get a, what I believe, may be a more specific monthly interest rate using a compound annual interest rate. This is what the rate is based on in the solution that we can compare to.

[How to Calculate the Monthly Interest Rate](https://calculate.onl/convert-annual-interest-rates/)

Monthly Compound Interest Rate Formula
> i_monthly = (1 + i_annual) ^ (1/12) – 1

In Ruby syntax: monthly_interest_rate = ( 1 + 0.05 )**(0.083333333) - 1

m = 1000 * (0.0042 / ( 1 - (1 + 0.0042)**(-12))) # works correctly

i_monthly = (1 + 0.5)**(1/12)-1