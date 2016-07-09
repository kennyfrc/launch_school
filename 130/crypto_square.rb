# 05/07/16 - Challenge: Crypto Square
class Crypto
  attr_reader :sentence
  attr_accessor :segments

  def initialize(sentence)
    @normalized_sentence = sentence.gsub(/[\s#$%^&!,.]/, '').downcase
    @cipher = ''
  end

  def normalize_plaintext
    @normalized_sentence
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
    ciphertext = ''
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
    other_cipher_arr.join(' ')
  end
end
