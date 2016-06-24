require 'pry'

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def two_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end

  def nearly_filled?
    !!remaining_square
  end

  def mid_available?
    @squares[5].marker == Square::INITIAL_MARKER
  end

  def remaining_square
    WINNING_LINES.shuffle.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares)
        return @squares.select {|location, square| line.include?(location) && square.marker == Square::INITIAL_MARKER}
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score
  attr_reader :ai

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_maker = FIRST_TO_MOVE
  end

  def log_score
    case board.winning_marker
    when HUMAN_MARKER
      human.score += 1
    when COMPUTER_MARKER
      computer.score += 1
    end
  end

  def display_score
    puts ""
    puts "SCOREBOARD:"
    puts "Human: #{human.score} | Computer: #{computer.score}"
  end

  def play
    display_welcome_message
    clear_board
    loop do
      clear_screen_and_display_board
      loop do
        human_moves
        break if board.full? || board.someone_won?
        computer_moves
        break if board.full? || board.someone_won?
        clear_screen_and_display_board
      end
      display_result
      log_score
      display_score
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Bye!"
    puts ""
  end

  def clear_board
    system 'clear'
  end

  def display_board
    puts "You're \'#{human.marker}\'. Computer is \'#{computer.marker}\'"
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear_board
    display_board
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def joinor(arr)
    last_number = arr.pop
    initial_numbers = []
    arr.each do |num|
      initial_numbers << num.to_s
    end
    stringified_list = initial_numbers.join(', ') + " or #{last_number}"
  end

  def human_moves
    puts "Choose a square between #{joinor(board.unmarked_keys)}."
    num = nil
    loop do
      num = gets.chomp.to_i
      break if board.unmarked_keys.include?(num)
      puts "Sorry, that's not a valid choice. Try again."
    end
    board[num] = human.marker
  end

  def ai_target
    board.remaining_square.keys.first
  end

  def computer_moves
    if board.nearly_filled?
      board[ai_target] = computer.marker 
    elsif board.mid_available?
      board[5] = computer.marker
    else
      num = board.unmarked_keys.sample
      board[num] = computer.marker   
    end
  end

  def play_again?
    puts "Do you want to play again? (y/n)"
    choice = ''
    loop do
      choice = gets.chomp.downcase
      break if ['y', 'n'].include? choice
      puts "Please enter a valid answer (y/n). Try again."
    end

    return true if choice == 'y'
    false
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear_board
  end

  def display_play_again_message
    puts "Let\'s play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end
end

game = TTTGame.new
game.play
