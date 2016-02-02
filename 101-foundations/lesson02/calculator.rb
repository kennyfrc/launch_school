require 'yaml'
# pass the loaded yml file to a MESSAGES contant
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num # it will return false if it's 00 || there's also regex, but it fails it you pass floats
end

def operation_to_message(op)
  word =  case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end
  word # this will help us add some more code into this method.
end

prompt(messages('welcome', LANGUAGE))

name = Kernel.gets().chomp()
puts "Hello, #{name}!"

loop do # main loop
  number1 = ''
  loop do
    prompt("What is the first number?")
    number1 = Kernel.gets().chomp()

    break if valid_number?(number1)
    prompt("That doesn't look like a valid number. Try again")
    sleep 1
  end

  number2 = ''
  loop do
    prompt("What is the second number?")
    number2 = Kernel.gets().chomp()

    break if valid_number?(number2)
    prompt("That doesn't look like a valid number. Try again")
    sleep 1
  end

  operator_prompt = <<-MSG
    What operator do you want to use?
    1) Addition
    2) Subtraction
    3) Multiplication
    4) Division
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)
    prompt("Please use a valid option")
  end

  prompt("#{operation_to_message(operator)} the two numbers...")
  sleep 1

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end

  prompt("The Result is #{result}")
  sleep 1

  prompt("Do you want to perform another calculation? (Y to continue / N to close the program)")
  answer = Kernel.gets().chomp()

  break if answer == "N" || answer == "n"
  prompt("Resetting...")
  sleep 2
end
