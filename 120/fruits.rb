class Market
  FRUITS = ['banana', 'apple']
  bleh = "bleh"
end

class OtherMarket < Market
  FRUITS = ['not a banana']
  def what_are_the_fruits
    puts "fruits include #{FRUITS}"
  end
end

class Market
  def what_are_the_fruits
    puts "fruits include #{FRUITS}"
  end
end

OtherMarket.new.what_are_the_fruits # => no error
Market.new.what_are_the_fruits # => throws warning
