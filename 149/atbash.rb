# Learn more about the Atbash cipher here: https://en.wikipedia.org/wiki/Atbash
class Atbash
  ALPHABET = ('a'..'z').to_a
  DIGITS = ('0'..'9').to_a
  LEXICON = Hash[ALPHABET.zip(ALPHABET.reverse) + DIGITS.zip(DIGITS)]
  NO_SPACE = ''.freeze
  SPACE = ' '.freeze
  PARSING_CRITERIA = /[\s,.]/

  def self.encode(str)
    parsed_str = str.downcase.gsub(PARSING_CRITERIA, NO_SPACE)
    encoded_string = NO_SPACE
    parsed_str.chars.each_with_index do |char, index|
      if multiple_of_five?(index)
        encoded_string += SPACE + LEXICON[char]
      else
        encoded_string += LEXICON[char]
      end
    end
    encoded_string
  end

  def self.multiple_of_five?(index)
    return false if index == 0
    index % 5 == 0
  end
end
