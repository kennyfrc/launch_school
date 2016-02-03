VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

# win conditions for the game logic

def rock_win_conditions(player, computer)
  (player == 'rock' && computer == 'scissors') ||
  (player == 'rock' && computer == 'lizard')
end

def paper_win_conditions(player, computer)
  (player == 'paper' && computer == 'spock') ||
  (player == 'paper' && computer == 'rock')
end

def scissors_win_conditions(player, computer)
  (player == 'scissors' && computer == 'lizard') ||
  (player == 'scissors' && computer == 'paper')
end

def lizard_win_conditions(player, computer)
  (player == 'lizard' && computer == 'paper') || 
  (player == 'lizard' && computer == 'spock')
end

def spock_win_conditions(player, computer)
  (player == 'spock' && computer == 'scissors') ||
  (player == 'spock' && computer == 'rock')
end

# loss conditions for the game logic

def rock_loss_conditions(player, computer)
  (player == 'rock' && computer == 'paper') ||
  (player == 'rock' && computer == 'spock')
end

def paper_loss_conditions(player, computer)
  (player == 'paper' && computer == 'lizard') ||
  (player == 'paper' && computer == 'scissors')
end

def scissors_loss_conditions(player, computer)
  (player == 'scissors' && computer == 'spock') ||
  (player == 'scissors' && computer == 'rock')
end

def lizard_loss_conditions(player, computer)
  (player == 'lizard' && computer == 'rock') || 
  (player == 'lizard' && computer == 'scissors')
end

def spock_loss_conditions(player, computer)
  (player == 'spock' && computer == 'paper') ||
  (player == 'spock' && computer == 'lizard')
end

# actual game logic

def display_results(player, computer)
  if  rock_win_conditions(player, computer) ||
      paper_win_conditions(player, computer) ||
      scissors_win_conditions(player, computer) ||
      lizard_win_conditions(player, computer) ||
      spock_win_conditions(player, computer)
    prompt("You won!")
  elsif rock_loss_conditions(player, computer) ||
        paper_loss_conditions(player, computer) ||
        scissors_loss_conditions(player, computer) ||
        lizard_loss_conditions(player, computer) ||
        spock_loss_conditions(player, computer)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end
sleep 1

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}\nShorthand characters (r, p, sc, l, sp) are also fine.") 
    choice = Kernel.gets().chomp().downcase
    sleep 1

    case choice
    when 'r'
      choice = 'rock'
    when 'p'
      choice = 'paper'
    when 'sc'
      choice = 'scissors'
    when 'l'
      choice = 'lizard'
    when 'sp'
      choice = 'spock'
    end

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
