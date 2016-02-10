require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
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
  brd.keys.select {|num| brd[num] == INITIAL_MARKER}
end


def player_places_piece!(brd) # as a best practice, add an exclamation point to indicate that this method will mutate the arguments passed to it
  square = ''
  loop do
    prompt "Choose a square within these numbers: #{empty_squares(brd).join(", ")}:"
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

board = initialize_board
display_board(board)

# now given that ruby can pass by reference or pass by value, 
# what we want to do is that we want to mutate the board (ie. pass by reference)

loop do
  player_places_piece!(board)
  computer_places_piece!(board)
  display_board(board)

  break if someone_won?(board) || board_full?(board) # we want to send the someone_won message and teh board_full message. now, in order for us to determine that, we need the board argument / data strcutre along side it
end