# prints a banner with a message of your choosing
class Banner
  attr_reader :message

  CORNER = '+'.freeze
  HORIZONTAL_BORDER = '-'.freeze
  VERTICAL_BORDER = '|'.freeze
  SPACE = ' '.freeze

  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n") + "\n"
  end

  private

  def horizontal_rule
    CORNER + number_of_lines.to_s + CORNER
  end

  def empty_line
    VERTICAL_BORDER + SPACE + number_of_spaces.to_s + SPACE + VERTICAL_BORDER
  end

  def message_line
    VERTICAL_BORDER + SPACE + message.to_s + SPACE + VERTICAL_BORDER
  end

  def number_of_lines
    HORIZONTAL_BORDER * (message_line.length - 2)
  end

  def number_of_spaces
    SPACE * message.length
  end
end
