VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') || 
      (player == 'paper' && computer == 'rock') ||
        (player == 'scissors' && computer == 'paper')
    prompt("You won!")
    sleep 1
  elsif (player == 'rock' && computer == 'paper') ||
          (player == 'paper' && computer == 'scissors') ||
            (player == 'scissors' && computer == 'rock')
    prompt("Computer won!")
    sleep 1
  else
    prompt("It's a tie!")
    sleep 1
  end

end

loop do
  choice = ''
  loop do 
    prompt("Choose one: #{VALID_CHOICES.join(", ")}")
    choice = Kernel.gets().chomp().downcase
    sleep 1

    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice.")
    sleep 1
  end

  computer_choice = VALID_CHOICES.sample()

  Kernel.puts("Your choice: #{choice}\nComputer Chose: #{computer_choice}")
  sleep 1


  display_results(choice, computer_choice)

  prompt("Do you want to play again? (Y for yes / N for no)")
  ans = gets.chomp.downcase
  break if ans == 'n'
  sleep 1
end