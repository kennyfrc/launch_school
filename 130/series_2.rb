# Write a program that will take a string of digits and give you all the possible consecutive number series of length n in that string.
#
# For example, the string "01234" has the following 3-digit series:
#
# - 012
# - 123
# - 234
#
# And the following 4-digit series:
#
# - 0123
# - 1234
#
# And if you ask for a 6-digit series from a 5-digit string, you deserve whatever you get.

# input:
# some string -> "012345"
# some length -> n

# requirements: slices method

# take the first N digits

class Series
  attr_reader :arr

  def initialize(str)
    @arr = str.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError, "Invalid Argument Size" if n > arr.size
    arr.each_cons(n).to_a
  end
end
