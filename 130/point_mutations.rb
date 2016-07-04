require 'pry'

class DNA
  attr_accessor :strand_as_array

  def initialize(strand)
    @strand_as_array = strand.split("")
  end

  def hamming_distance(other_strand)
    zipped_strands = zip_strands_to_arr(other_strand)
    hamming_distance = 0
    zipped_strands.each do |arr|
      hamming_distance += 1 unless arr[0] == arr[1]
    end
    hamming_distance
  end

  def zip_strands_to_arr(other_strand)
    other_strand_as_array = other_strand.split("")
    zipped_strands = strand_as_array.zip(other_strand_as_array)
    zipped_strands_wo_danglers = zipped_strands.select { |arr| !arr.include?(nil) }
  end
end
