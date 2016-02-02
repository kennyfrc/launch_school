VALID_CHOICES = %w(rock paper scissors).freeze

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

def display_results(player, computer)
  if  (player == 'rock' && computer == 'scissors') ||
      (player == 'paper' && computer == 'rock') ||
      (player == 'scissors' && computer == 'paper')
    prompt("You won!")
  elsif   (player == 'rock' && computer == 'paper') ||
          (player == 'paper' && computer == 'scissors') ||
          (player == 'scissors' && computer == 'rock')
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end
sleep 1

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
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
