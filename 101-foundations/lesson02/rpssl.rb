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

# win / loss logger

def log_win
  $wl_log_player << 1
  $wl_log_computer << 0
end

def log_loss
  $wl_log_player << 0
  $wl_log_computer << 1
end

# actual game logic

def display_results(player, computer)
  if  rock_win_conditions(player, computer) ||
      paper_win_conditions(player, computer) ||
      scissors_win_conditions(player, computer) ||
      lizard_win_conditions(player, computer) ||
      spock_win_conditions(player, computer)
    prompt("1 Point for Player!")
    log_win
  elsif rock_loss_conditions(player, computer) ||
        paper_loss_conditions(player, computer) ||
        scissors_loss_conditions(player, computer) ||
        lizard_loss_conditions(player, computer) ||
        spock_loss_conditions(player, computer)
    prompt("1 Point for Computer!")
    log_loss
  else
    prompt("It's a tie!")
  end
end
sleep 1

# user-facing code is below this line

prompt("Welcome to the RPSSL Tournament! Whoever gets 5 points first wins! Good Luck!")
sleep 1

$wl_log_player = []
$wl_log_computer = []
rounds = [1]

loop do
  choice = ''
  loop do
    prompt("ROUND #{rounds.reduce(:+)}")
    sleep 1
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
  rounds << 1
  sleep 1

  puts "-------------"
  puts "/SCOREBOARD/\nPLAYER: #{$wl_log_player.count(1)}\nCOMPUTER: #{$wl_log_computer.count(1)}"
  puts "-------------"
  sleep 1

  if [$wl_log_computer.reduce(:+), $wl_log_player.reduce(:+)].include?(5)
    if $wl_log_computer.reduce(:+) == 5
      prompt("The Computer has won the game! Better luck next time")
      sleep 2

      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      $wl_log_player = []
      $wl_log_computer = []
      rounds = [1]
    else
      prompt("You have won! Woohoo!")
      sleep 2
      
      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      $wl_log_player = []
      $wl_log_computer = []
      rounds = [1]
    end
  end
end
