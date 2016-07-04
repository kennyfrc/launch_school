class House
  def self.recite
    paragraph = ""
    (1..self.pieces.size).each do |num|
      paragraph += self.combine_pieces(self.pieces.last(num))
    end
    paragraph
  end

  def self.combine_pieces(pieces)
    line = "This is "
    pieces.each do |piece|
      line += self.pieces.last == piece ? "#{piece[0]}." + "" : "#{piece[0]}" + "\n"
      line += "#{piece[1]}" + " "
    end
    line
  end

  def self.pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end

puts House.recite