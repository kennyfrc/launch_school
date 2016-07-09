# 05/21/16 - Challenge: Word Count
class Phrase
  COMMA = /[,]/
  CRITERIA = %r{[!&@$:%.^\/]}

  attr_accessor :list_of_words

  def initialize(list_of_words)
    @list_of_words = list_of_words.gsub(COMMA, ' ')
  end

  def word_count
    counts = {}
    arr_of_words = list_of_words.split(' ')
    arr_of_words.each do |word|
      word = remove_uneeded_characters(word)
      counts.key?(word) ? counts[word] += 1 : counts[word] = 1
    end
    remove_quotes_from_keys(counts)
  end

  private

  def remove_uneeded_characters(str)
    str.downcase.gsub(CRITERIA, '').chomp("'").reverse.chomp("'").reverse
  end

  def remove_quotes_from_keys(hash)
    hash.delete('')
    hash
  end
end
