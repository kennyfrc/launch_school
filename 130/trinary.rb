# # "102012"
#     1       0       2       0       1       2    # the number
# 1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0    # the value
#   243 +     0 +    54 +     0 +     3 +     2 =  302

class Trinary
  INVALID_CHARS = ("a".."z").to_a + (3..9).to_a
  BASE = 3

  attr_reader :arr_of_nums

  def initialize(str)
    @arr_of_nums = str.chars
  end

  def to_decimal
    return 0 if INVALID_CHARS.any? {|char| arr_of_nums.include?(char)}
    arr_of_nums.reverse.map.with_index do |char, index|
      char.to_i * (BASE ** index)
    end.sum
  end
end

trinary = Trinary.new("102012")
puts trinary

 # test case 1: any number
 # test case 2: check if it's a wrod
