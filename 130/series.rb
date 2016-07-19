# Easy 1 > Series
class Series
  attr_reader :numbers
  attr_accessor :slice

  def initialize(str_of_numbers)
    @numbers = str_of_numbers.chars.map(&:to_i)
    @slice = []
  end

  def slices(slice_size)
    fail ArgumentError, 'Slice size too large' if slice_size > numbers.size
    base = 0
    increment = slice_size
    while last_sliced_element != numbers.last(increment)
      slice << numbers.slice(base, increment)
      base += 1
    end
    slice
  end

  private

  def last_sliced_element
    slice.last(1).flatten
  end
end
