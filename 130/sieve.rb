# Sieve of Erasthothenes
class Sieve
  attr_reader :number_space

  def initialize(limit)
    @number_space = (2..limit).to_a
  end

  def primes
    number_space.each do |number|
      number_space.delete_if {|base| base % number == 0 && base != number}
    end
  end
end
