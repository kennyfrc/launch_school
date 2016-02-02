def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num_in_cents = (num.to_f * 100).round.to_i
  num_in_cents != 0
end

def valid_number_of_months?(num)
  num.to_i.to_s == num
end

prompt("Welcome to the Mortgage / Car Loan Calculator! Please enter your name: ")

name = gets.chomp

prompt("Hello, #{name}! Nice to meet you.")

loop do
  welcome_message = <<-MSG
  \nTo calculate the monthly payment & loan balance,
  we will need the following information from you:
    1) Loan Amount Desired
    2) Quoted Annual Percentage Rate
    3) Loan Duration
  MSG

  prompt(welcome_message)

  loan_amount = ''
  apr = ''
  loan_duration = ''

  loop do
    prompt("Input 1 of 3: What is your desired loan amount? (In USD)")

    loan_amount = gets.chomp

    break if valid_number?(loan_amount)
    prompt("Please use valid numbers only. '0' is also not allowed.")
    sleep 1
  end

  loop do
    loop do
      prompt("Input 2 of 3: What is the quoted annual percentage rate?")

      apr = gets.chomp

      break if valid_number?(apr)
      prompt("Please use valid numbers only. '0' is also not allowed.")
      sleep 1
    end

    if apr.to_f < 1
      loop do
        prompt("Did you mean:\nOption 1: #{apr.to_f * 100}% ?\n- or - \nOption 2: #{apr.to_f}% ?\nEnter '1' or '2' to select.")
        apr_answer = gets.chomp

        case apr_answer
        when '1'
          prompt("OK. Using #{apr.to_f * 100}%...") if apr_answer == '1'
          apr = (apr.to_f * 100).to_s
          break
        when '2'
          prompt("OK. Using #{apr.to_f}%...") if apr_answer == '2'
          break
        else
          prompt("Please use valid numbers only.")
          sleep 1
          prompt("Resetting...")
          sleep 1
        end
      end
    end

    break
  end

  loop do
    prompt("Input 3 of 3: What is the loan duration in months?")

    loan_duration = gets.chomp

    break if valid_number_of_months?(loan_duration)
    prompt("Please use valid numbers only. '0' is also not allowed.")
    sleep 1
  end

  loan_amount = loan_amount.to_f
  apr_in_months = apr.to_f / 12 / 100
  loan_duration = loan_duration.to_i

  prompt("Crunching some numbers...")
  sleep 1

  fixed_monthly_payment = loan_amount * (apr_in_months * (1 + apr_in_months)**loan_duration) / (((1 + apr_in_months)**loan_duration) - 1)
  loan_balance = loan_amount * ((((1 + apr_in_months)**loan_duration) - ((1 + apr_in_months)**loan_duration))) / (((1 + apr_in_months)**loan_duration) - 1)

  prompt("Your fixed monthly payment is #{fixed_monthly_payment.round(2)} USD.")
  sleep 1
  prompt("Your loan balance is #{loan_balance.round(2)}.")
  sleep 1

  prompt("Would you like to make another calculation? (Y to continue / N to exit)")

  ans = gets.chomp

  case ans.downcase
  when 'n'
    prompt("Bye!")
    break
  when 'y'
    prompt("OK.. Resetting...")
    sleep 1
  end
end
