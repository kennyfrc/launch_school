VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

WIN_RULES = { 'lizard' => { win_conditions: %w(paper rock)},
              'rock' => { win_conditions: %w(lizard scissors)},
              'paper' => { win_conditions: %w(rock spock)},
              'scissors' => { win_conditions: %w(paper lizard)},
              'spock' => { win_conditions: %w(rock scissors)}
            }

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

# win conditions for the game logic

def win_round?(player_choice, computer_choice)
  WIN_RULES.any? do |choice, player_wins_if|
    choice == player_choice && player_wins_if[:win_conditions].include?(computer_choice)
  end
end

# win / loss logger

def log_results!(player, computer, player_log, computer_log)
  if win_round?(player, computer)
    player_log << 1
    computer_log << 0
    return player_log, computer_log
  elsif player == computer
    player_log << 0
    computer_log << 0
    return player_log, computer_log
  else
    player_log << 0
    computer_log << 1
    return player_log, computer_log
  end
end

# actual game logic

def display_results(player, computer)
  if win_round?(player, computer)
    prompt("1 Point for Player!")
  elsif player == computer
    prompt("It's a tie!")
  else
    prompt("1 Point for Computer!")
  end
end
sleep 1

# round counter

def count_this_round!(round)
  round << 1
end

# user-facing code is below this line

prompt("Welcome to the RPSSL Tournament! Whoever gets 5 points first wins! Good Luck!")
sleep 1

player_log = []
computer_log = []
rounds = [1]

loop do
  choice = ''

  loop do
    prompt("ROUND #{rounds.reduce(:+)}")
    sleep 1
    prompt("Choose one: #{VALID_CHOICES.join(', ')}\nShorthand characters (r, p, sc, l, sp) are also fine.") 
    choice = Kernel.gets().chomp().downcase
    sleep 1

    choice =
      case choice
      when 'r' then 'rock'
      when 'p' then 'paper'
      when 'sc' then 'scissors'
      when 'l' then 'lizard'
      when 'sp' then 'spock'
      else
        choice
    end

    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice.")
    sleep 1
  end

  computer_choice = VALID_CHOICES.sample()

  Kernel.puts("Your choice: #{choice}\nComputer Chose: #{computer_choice}")
  sleep 1

  display_results(choice, computer_choice)
  log_results!(choice, computer_choice, player_log, computer_log)
  count_this_round!(rounds)
  
  sleep 1

  puts "-------------"
  puts "/SCOREBOARD/\nPLAYER: #{player_log.count(1)}\nCOMPUTER: #{computer_log.count(1)}"
  puts "-------------"
  sleep 1

  if [computer_log.reduce(:+), player_log.reduce(:+)].include?(5)
    if computer_log.reduce(:+) == 5
      prompt("The Computer has won the game! Better luck next time")
      sleep 1

      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      player_log = []
      computer_log = []
      rounds = [1]
    else
      prompt("You have won! Woohoo!")
      sleep 1
      
      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      player_log = []
      computer_log = []
      rounds = [1]
    end
  end
end
