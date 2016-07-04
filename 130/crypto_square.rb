require 'pry'

class Crypto

  attr_reader :sentence
  attr_accessor :segments

  def initialize(sentence)
    @sentence = sentence
    @cipher = ""
  end

  def normalize_plaintext
    sentence.gsub(/[\s#$%^&!,.]/, "").downcase
  end

  def perfect_square?
    Math.sqrt(length) % 1 == 0
  end

  def sqrt_of_sentence
    Math.sqrt(length).ceil
  end

  def size
    sqrt_of_sentence
  end

  def length
    normalize_plaintext.length
  end

  def plaintext_segments
    counter = 0
    segments = []
    while counter < length
      segments << normalize_plaintext.slice(counter, sqrt_of_sentence)
      counter += sqrt_of_sentence
    end
    segments
  end

  def cipher_arr
    cipher_arr = []
    plaintext_segments.each_index do |index|
      if index == 0
        (0...plaintext_segments[index].size).each do |int|
          cipher_arr << [plaintext_segments[index].chars[int]]
        end
      else
        (0...plaintext_segments[index].size).each do |int|
          cipher_arr[int] << plaintext_segments[index].chars[int]
        end
      end
    end
    cipher_arr
  end

  def ciphertext
    ciphertext = ""
    cipher_arr.each do |arr|
      ciphertext += arr.join
    end
    ciphertext
  end

  def normalize_ciphertext
    other_cipher_arr = []
    cipher_arr.each do |arr|
      other_cipher_arr << arr.join
    end
    other_cipher_arr.join(" ")
  end
end

# Implement the classic method for composing secret messages called a square code.

# The input is first normalized: The spaces and punctuation are removed from the English text and the message is down-cased.

# Then, the normalized characters are broken into rows. These rows can be regarded as forming a rectangle when printed with intervening newlines.

# For example, the sentence

# If man was meant to stay on the ground god would have given us roots

# is 54 characters long.

# Broken into 8-character columns, it yields 7 rows.

# Those 7 rows produce this rectangle when printed one per line:

# [x] remove spaces and punctuation [\s,.:;] 
# [x] downcased
# break the string into rows using the return value of sqrt(String.length).is_a?(Integer) unless not a perfect square
# split it using (0 ... diff), (diff + 1 ... diff + 1 + n) => should shoot an array of arrays
# then iterate again then zip it

# normalize_plaintext()
# 
# break_down_sentence Math.sqrt(50) % 1 == 0