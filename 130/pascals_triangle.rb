# not done
class Triangle
  attr_accessor :size, :lines

  def initialize(size)
    @size = size
    @lines = []
  end

  def rows
    size.times do 
      self.lines << size
    end
    puts lines
  end

  # [[1], [1, 1], [1, 2, 1]] => output
  # when we pass an integer n into the Triangle class, it will create an array of n arrays
  # every array size gets bigger depending on its index (0 => 1, 1 => 2, ... n-1 => n)

end

triangle = Triangle.new(1)
triangle.rows