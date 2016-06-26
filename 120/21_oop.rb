require 'pry'

class Player
  attr_accessor :hand, :role

  def initialize(role = "Human")
    @role = role
    @hand = Hand.new
  end

  def busted?
    hand.value > Game::WIN_CONDITION
  end

  def show_hand
    self.role = "Your" if role == "Human"
    self.role = "Dealer's" if role == "Dealer"
    puts "#{role} hand:\n#{hand.show}"
  end
end

class Hand
  attr_accessor :dealt_cards

  def initialize
    @dealt_cards = []
  end

  def value # need to update value of A if value > win_condition
    value_of_cards = 0
    dealt_cards.each do |card|
      if face_card?(card.last)
        value_of_cards += parse_face_card(card.last)
      else
        value_of_cards += card.last
      end
    end
    ace_corrector(value_of_cards)
  end

  def face_card?(card)
    card.is_a?(String)
  end

  def parse_face_card(card)
    case card
    when 'A'
      11
    else
      10
    end
  end

  def ace_corrector(current_value)
    if dealt_cards.flatten.include?('A') && current_value >= Game::WIN_CONDITION
      current_value -= 10
    else
      current_value
    end
  end

  def show
    card_names
  end

  def card_names
    card_names = ""
    dealt_cards.each do |card|
      card_names += parse_value(card)
      card_names += parse_suit(card)
    end
    card_names
  end

  def parse_suit(card)
    case card.first
    when 'H'
      "of Hearts\n"
    when 'C'
      "of Clubs\n"
    when 'D'
      "of Diamonds\n"
    when 'S'
      "of Spades\n"
    end
  end

  def parse_value(card)
    case card.last
    when 'A'
      "Ace "
    when 'K'
      "King "
    when 'Q'
      "Queen "
    when 'J'
      "Jack "
    else
      "#{card.last} "
    end
  end
end

class Deck
  SUITS = ['C', 'D', 'H', 'S'].freeze
  VALUES = ((2..10).to_a + ['J', 'Q', 'K', 'A']).freeze

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.product(VALUES).each { |card| @cards << card }
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def deal_to!(human, dealer)
    2.times do
      human.hand.dealt_cards << cards.pop
      dealer.hand.dealt_cards << cards.pop
    end
  end

  def draw_card!(hand)
    hand << cards.pop
  end
end

class Game
  WIN_CONDITION = 21

  attr_accessor :dealer, :human, :deck

  def initialize
    @dealer = Player.new("Dealer")
    @human = Player.new
    @deck = Deck.new
  end

  def start
    display_welcome_message
    loop do
      reset
      deal_cards
      player_turn
      if human.busted?
        display_human_busted_message
      else
        display_human_stay_message
        dealer_turn
        show_result
      end
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    system 'clear'
    puts "Welcome to 21!"
    sleep 1
  end

  def display_goodbye_message
    system 'clear'
    puts "Thanks for playing 21!"
    sleep 1
  end

  def show_result
    system 'clear'
    if human.hand.value > dealer.hand.value
      puts "You win!"
    elsif dealer.busted?
      puts "You win! Dealer busted!"
    elsif dealer.hand.value > human.hand.value
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
    sleep 1
    puts "SCORE: #{human.hand.value} vs #{dealer.hand.value}"
  end

  def reset
    self.deck = Deck.new
    human.hand.dealt_cards = []
    dealer.hand.dealt_cards = []
  end

  def deal_cards
    deck.shuffle
    deck.deal_to!(human, dealer)
    display_deal_message
  end

  def display_deal_message
    system 'clear'
    puts "DEAL!"
    sleep 1
  end

  def display_human_turn_message
    puts "Your Turn!"
    sleep 1
  end

  def display_dealer_turn_message
    system 'clear'
    puts "Dealer's Turn!"
    sleep 1
  end

  def display_human_busted_message
    system 'clear'
    human.show_hand
    puts ""
    sleep 1
    puts "...For a hand value of #{human.hand.value}."
    sleep 1
    puts ""
    puts "You busted :("
  end

  def display_dealer_busted_message
    system 'clear'
    puts "You win!"
  end

  def display_human_stay_message
    system 'clear'
    puts "You stayed with a hand value of #{human.hand.value}!"
    sleep 1
  end

  def play_again?
    puts "Do you want to play again? (y/n)"
    choice = ''
    loop do
      choice = gets.chomp.downcase
      break if ['y', 'n'].include? choice
      puts "Please enter a valid answer (y/n). Try again."
    end
    choice == 'y'
  end

  def dealer_turn
    display_dealer_turn_message
    loop do
      puts ""
      dealer.show_hand
      puts ""
      puts "Dealer's hand value is #{dealer.hand.value}."
      if dealer.hand.value < 17
        sleep 1
        puts "Dealer hits!"
        deck.draw_card!(dealer.hand.dealt_cards)
        sleep 1
      elsif dealer.busted?
        sleep 1
        puts ""
        puts "Dealer busted!"
        sleep 1
        break
      else
        sleep 1
        puts ""
        puts "Dealer stays!"
        sleep 1
        break
      end
    end
  end

  def player_turn
    display_human_turn_message
    loop do
      system 'clear'
      human.show_hand
      puts ""
      dealer.show_hand
      puts ""
      puts "Your hand value is #{human.hand.value}."
      puts "Dealer hand value is #{dealer.hand.value}."
      puts ""
      puts "Do you want to hit or stay? (h/s)"
      choice = ''
      loop do
        choice = gets.chomp
        break if ['h', 's'].include?(choice)
        puts "Invalid choice. Choose between h or s."
      end
      case choice
      when 'h'
        system 'clear'
        deck.draw_card!(human.hand.dealt_cards)
        break if human.busted?
      when 's'
        system 'clear'
        display_human_stay_message
        break
      end
    end
  end
end

Game.new.start
