class Phrase
  attr_accessor :list_of_words

  def initialize(list_of_words)
    @list_of_words = list_of_words
  end

  def word_count
    counts = {}
    remove_comma
    arr_of_words = list_of_words.split(' ')
    arr_of_words.each do |word|
      word = remove_uneeded_characters(word)
      if counts.has_key? word
        counts[word] += 1
      else
        counts[word] = 1
      end
    end
    remove_quotes_from_keys(counts)
  end

  def remove_comma
    self.list_of_words = list_of_words.gsub(/[,]/, " ")
  end

  def remove_uneeded_characters(str)
    str.downcase.gsub(/[!&@$:%.^\/]/, "").chomp("'").reverse.chomp("'").reverse
  end

  def remove_quotes_from_keys(hash)
    hash.delete("")
    hash
  end
end

# def initialize(phrase)
#   @words = phrase.split(/[\s,]/)
#                  .select {|word| word.match(/[[[:alnum:]]]/)}
#                  .map {|word| transform_word(word)}
#   @words.scan(/w+'?\w+|\d+/)
# end

# def word_count
#   summary = Hash.new(0)
#   @words.each do |word|
#     summary[word] += 1
#   end
#   summary
# end

# def transform_word(word)
#   word.gsub(/[^[[:alnum:]]']|^'|'$/,'')
#       .downcase
# end