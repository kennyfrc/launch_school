class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end


class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bark = GoodDog.new("color")

print bark