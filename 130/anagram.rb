# some documentation?
class Anagram
  attr_reader :detector

  def initialize(detector)
    @detector = detector
  end

  def match(array_of_words)
    filtered_words = array_of_words.map(&:downcase).select do |word|
      word.chars.all? do |chars|
        detector_letters.include?(chars)
      end && pass_anagram_checker?(word)
    end
    return filtered_words.map(&:capitalize) if capitalized?(detector)
    filtered_words
  end

  private

  def pass_anagram_checker?(arr)
    same_size_as_detector?(arr) && same_chars_as_detector?(arr) && not_self?(arr)
  end

  def capitalized?(detector)
    capitalized_detector = detector.downcase.capitalize
    capitalized_detector == detector
  end

  def size(arr)
    arr.chars.size
  end

  def detector_letters
    detector.downcase.chars
  end

  def chars_of(str)
    hash_of_letters = Hash.new(0)
    str.chars.each do |letter|
      hash_of_letters[letter] += 1
    end
    hash_of_letters
  end

  def same_chars_as_detector?(arr)
    chars_of(arr) == chars_of(detector.downcase)
  end

  def same_size_as_detector?(arr)
    size(arr) == detector.size
  end

  def not_self?(arr)
    arr != detector.downcase
  end
end
