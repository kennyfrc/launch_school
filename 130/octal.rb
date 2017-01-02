# About Octal (Base-8):
#
# Decimal is a base-10 system.
#
# A number 233 in base 10 notation can be understood as a linear combination of powers of 10:
#
#     The rightmost digit gets multiplied by 100 = 1
#     The next number gets multiplied by 101 = 10
#     ...
#     The n*th number gets multiplied by 10n-1*.
#     All these values are summed.

# input:
# - a number with n digits
#
# process:
# - split the number into multiple digits
# - iterate over the number starting from the end
# - do some calculation
# - reverse the digits
# - combine them
#
# output:
# - another number

class Octal
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def invalid_octal?
    split_and_reversed_num = num.to_s.chars.reverse
    split_and_reversed_num.first.to_i == 8 || split_and_reversed_num.first.to_i == 9
  end

  def to_decimal
    return 0 if invalid_octal?
    decimalized_set = []
    num.to_s.chars.reverse.each_with_index do |char, index|
      return 0 if ("a".."z").include?(char)
      decimalized_set << char.to_i * (8 ** index)
    end
    decimalized_set.sum
  end
end

octal = Octal.new(233)
puts octal.to_decimal
