require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd, player_score, computer_score, rounds)
  system 'clear'
  puts "SCOREBOARD => Player: #{player_score.count(1)} | Computer: #{computer_score.count(1)}"
  puts "ROUND #{rounds.reduce(:+)}"
  puts "LEGEND => Player: #{PLAYER_MARKER}; Computer: #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

# when you call the display_board method, it's best to specify an array of values, like an array
# what we're doing here is that we are coming up a data structure that best represents thte board state
# and we've decided on is an hash. (other options: hash? nested array?) => this will have ramifications throughout our program in terms of how we extract data from this program and how we manipulate data within this data structure
# but there aren't too many bad choices here
# we decided on a hash, which will look like this: {1 => 'X', 2 => 'O', 3 => 'X'} // keys respresent the position and the values represent the values that we will display
# this data structure will represent the board sastate at any point in our application

def initialize_board
  new_board = {}
  (1..9).each do |num|
    new_board[num] = INITIAL_MARKER
  end
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, sep=', ')
  user_options = ''
  arr.each do |element|
    if element != arr.last
      user_options << "#{element}#{sep}"
    else
      user_options << "or #{element}"
    end
  end
  user_options
end

def player_places_piece!(brd) # as a best practice, add an exclamation point to indicate that this method will mutate the arguments passed to it
  square = ''
  loop do
    prompt "Choose a square within these numbers: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, #{square} is not a valid choice"
    sleep 1
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd) == []
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[3, 5, 7], [1, 5, 9]] # diagonals

  winning_lines.each do |line|
    if brd[line[0]] == PLAYER_MARKER && brd[line[1]] == PLAYER_MARKER && brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMPUTER_MARKER && brd[line[1]] == COMPUTER_MARKER && brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

def display_winner(board)
  if someone_won?(board)
    prompt "#{detect_winner(board)} won this round!"
    sleep 1
  else
    prompt "It's a tie!"
    sleep 1
  end
end

def record_winner_of_this_round(brd, player_score, computer_score)
  if detect_winner(brd) == 'Player'
    player_score << 1
    computer_score << 0
  elsif detect_winner(brd) == 'Computer'
    player_score << 0
    computer_score << 1
  end
end

def count_this_round!(round)
  round << 1
end

system 'clear'
prompt("Welcome to the TTT Tournament! Whoever gets 5 points first wins! Good Luck!")
sleep 2

player_score = []
computer_score = []
rounds = [1]

loop do
  board = initialize_board
  # now given that ruby can pass by reference or pass by value,
  # what we want to do is that we want to mutate the board (ie. pass by reference)

  loop do
    display_board(board, player_score, computer_score, rounds)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board) # we want to send the someone_won message and teh board_full message. now, in order for us to determine that, we need the board argument / data strcutre along side it
  end

  display_board(board, player_score, computer_score, rounds)
  display_winner(board)
  record_winner_of_this_round(board, player_score, computer_score)
  count_this_round!(rounds)

  if [computer_score.reduce(:+), player_score.reduce(:+)].include?(5)
    if computer_score.reduce(:+) == 5
      system 'clear'
      prompt("The Computer has won the game! Better luck next time")
      sleep 1

      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      player_score = []
      computer_score = []
      rounds = [1]
    else
      system 'clear'
      prompt("You have won! Woohoo!")
      sleep 1
      
      prompt("Do you want to play more? (Y for yes / N for no)")
      ans = gets.chomp.downcase
      break if ans == 'n'

      player_score = []
      computer_score = []
      rounds = [1]
    end
  end

  system 'clear'
  puts "Loading Round #{rounds.reduce(:+)}"
  sleep 2
end

prompt "Thanks for playing Tic Tac Toe! Bye!"
