SUITS = ['H', 'S', 'D', 'C'].freeze
VALUES = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
WIN_CONDITION = 21

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  values = cards.map { |pair| pair[1] }

  sum = 0

  values.each do |e|
    if e == "A"
      sum += 11
    elsif e.to_i == 0
      sum += 10
    else
      sum += e.to_i
    end
  end

  values.select { |e| e == 'A' }.count.times do
    sum -= 10 if sum > WIN_CONDITION
  end

  sum
end

def busted?(cards)
  total(cards) > WIN_CONDITION
end

def detect_result(dealer_cards, player_cards) # this basically returns symbols. intead of strings (which are mutable) or integers (which are also mutable and not readable), you use symbols which offer clarity and immutability
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > WIN_CONDITION
    :player_busted
  elsif dealer_total > WIN_CONDITION
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "You got busted! Dealer wins!"
    sleep 1
  when :dealer_busted
    prompt "Dealer got busted! You win!"
    sleep 1
  when :player
    prompt "You won this round!"
    sleep 1
  when :dealer
    prompt "Dealer won this round!!"
    sleep 1
  when :tie
    prompt "It's a Tie!"
    sleep 1
  end
end

def log_results!(dealer_cards, player_cards, dealer_score, player_score)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    dealer_score << 1
  when :dealer_busted
    player_score << 1
  when :player
    player_score << 1
  when :dealer
    dealer_score << 1
  end
end

def display_scores(dealer_score, player_score)
  puts "=========="
  puts "SCOREBOARD"
  puts "=========="
  prompt "Dealer's Score: #{dealer_score == [] ? "0" : dealer_score.reduce(:+)}"
  prompt "Player's Score: #{player_score == [] ? "0" : player_score.reduce(:+)}"
  puts "=========="
end


def play_again?
  puts "----------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y') # check if it's true or false
end

def double_check?
  puts "----------"
  prompt "Do you want to play a different X1 game? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y') # check if it's true or false
end

def display_scoreboard(dealer_cards, player_cards)
  puts "=============="
  puts "FINAL HANDS:"
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="
end

def display_player_score(player_cards)
  puts "=============="
  puts "PLAYER'S HAND:"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="
end

def display_dealer_score(dealer_cards)
  puts "=============="
  puts "DEALER'S HAND:"
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  puts "=============="
end

def log_round!(rounds)
  rounds << 1
end



player_score = []
dealer_score = []
rounds = [1]

prompt "Welcome to X1!"
prompt "To win vs dealer, you must win 5 games."
sleep 2

loop do
  loop do
      prompt "First, select a number that ends with 1 (e.g. 21, 31, 1221, etc.)"
      response = gets.chomp
      WIN_CONDITION = response.to_i
      break if response.to_s.chars.last == "1"
      prompt "Please choose a number that ends with 1. Try again."
  end
    loop do
    prompt "Now playing #{WIN_CONDITION}"

    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    prompt "Round #{rounds.reduce(:+)}"
    sleep 2

    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}."

    loop do
      player_turn = nil
      loop do
        prompt "Would you like to hit or stay? (h or s)"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        prompt "You chose to hit!"
        prompt "Your cards are now: #{player_cards}"
        prompt "Your total is now: #{total(player_cards)}"
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    if busted?(player_cards)
      display_scoreboard(dealer_cards, player_cards)
      sleep 1
      display_result(dealer_cards, player_cards)
      log_results!(dealer_cards, player_cards, dealer_score, player_score)
      display_scores(dealer_score, player_score)
      log_round!(rounds)
      if dealer_score.reduce(:+) == 5
        prompt "dealer has won the game!"
        play_again? ? next : break
      end
      next
    else
      prompt "You stayed at #{total(player_cards)}"
    end

    display_player_score(player_cards)
    sleep 2

    prompt "Dealer turn..."
    sleep 2

    loop do
      break if busted?(dealer_cards) || total(dealer_cards) >= (WIN_CONDITION - 4)

      prompt "Dealer hits!"
      sleep 1
      dealer_cards << deck.pop
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    dealer_total = total(dealer_cards)
    if busted?(dealer_cards)
      prompt "Dealer total is now: #{dealer_total}"
      display_scoreboard(dealer_cards, player_cards)
      sleep 1
      display_result(dealer_cards, player_cards)
      log_results!(dealer_cards, player_cards, dealer_score, player_score)
      display_scores(dealer_score, player_score)
      log_round!(rounds)
      if player_score.reduce(:+) == 5
        prompt "Player has won the game!"
        play_again? ? next : break
      end
      next
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    display_dealer_score(dealer_cards)
    sleep 2

    display_scoreboard(dealer_cards, player_cards)

    display_result(dealer_cards, player_cards)

    log_results!(dealer_cards, player_cards, dealer_score, player_score)

    display_scores(dealer_score, player_score)

    log_round!(rounds)

    if dealer_score.reduce(:+) == 5
      prompt "Dealer has won the game!" 
      play_again? ? next : break
    elsif player_score.reduce(:+) == 5
      prompt "Player has won the game!"
      play_again? ? next : break
    end

  end

  double_check? ? next : break

end

prompt "Thank you for playing X1! Good bye!"
