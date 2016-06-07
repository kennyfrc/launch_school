class Move
  VALUES = ['rock', 'paper', 'scissors', 'scissors', 'spock'].freeze

  def initialize(value)
    @value = value
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def scissors?
    @value == "scissors"
  end

  def lizard?
    @value == "lizard"
  end

  def spock?
    @value == "spock"
  end

  def >(other_move)
    if rock?
      return true if other_move.scissors? || other_move.lizard?
      false
    elsif paper?
      return true if other_move.rock? || other_move.spock?
      false
    elsif scissors?
      return true if other_move.paper? || other_move.lizard?
      false
    elsif lizard?
      return true if other_move.spock? || other_move.paper?
      false
    elsif spock? 
      return true if other_move.rock? || other_move.scissors?
      false     
    end
  end

  def <(other_move)
    if rock?
      return true if other_move.paper? || other_move.spock?
      false
    elsif paper?
      return true if other_move.scissors? || other_move.lizard?
      false
    elsif scissors?
      return true if other_move.rock? || other_move.spock?
      false
    elsif lizard?
      return true if other_move.rock? || other_move.scissors?
      false
    elsif spock?
      return true if other_move.paper? || other_move.lizard?
      false
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    @score = 0
    @move_history = []
    set_name
  end
end

class Human < Player
  def set_name
    puts "What's your name?"
    name = ''
    loop do
      name = gets.chomp
      break unless name.empty?
      puts "Please enter a name."
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Choose a move: rock, paper, scissors, lizard, or spock?"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice. Try again."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'C3PO', 'Han Solo\'s Ghost', 'Kylo Ren'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, and Spock! It's a race to 10!"
  end

  def display_goodbye_message
    puts "Thanks #{human.name} for playing Rock, Paper, Scissors, Lizard, and Spock!"
  end

  def display_round_winner
    puts "#{human.name} chose #{human.move.to_s}"
    puts "#{computer.name} chose #{computer.move.to_s}"

    if human.move > computer.move
      puts "#{human.name} wins this round!"
    elsif human.move < computer.move
      puts "#{computer.name} wins this round!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    answer = nil
    loop do
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Please use either y or n. Try again."
    end

    return true if answer == 'y'
    false
  end

  def anyone_won_match?
    if human.score == 2
      puts "#{human.name} wins the match!"
      true
    elsif computer.score == 2
      puts "#{computer.name} wins the match! Better luck next time!"
      true
    end
  end

  def record_score
    if human.move > computer.move
      human.score = human.score + 1
    elsif human.move < computer.move
      computer.score = computer.score + 1
    end
  end

  def show_score
    puts "Human score is #{human.score} | Computer score is #{computer.score}"
  end

  def clear_scores
    human.score, computer.score = 0, 0
  end

  def record_moves!
    if human.move > computer.move
      human.move_history <<  {"win" => "#{human.move}"}
      computer.move_history <<  {"loss" => "#{computer.move}"}
    elsif human.move < computer.move
      human.move_history <<  {"loss" => "#{human.move}"}
      computer.move_history <<  {"win" => "#{computer.move}"}
    else
      human.move_history <<  {"tie" => "#{human.move}"}
      computer.move_history <<  {"tie" => "#{computer.move}"}
    end
  end

  def play
    display_welcome_message
    loop do
        clear_scores
      loop do
        human.choose
        computer.choose
        display_round_winner
        record_score
        show_score
        record_moves!
        break if anyone_won_match?
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
