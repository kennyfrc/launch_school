# module Maintenance
#   def change_tires
#     "Changing #{wheels} tires."
#   end
# end

class Vehicle
  def start
    @wheels = 4
  end

  def initialize
    self.start
  end
end

test = Vehicle.new

p test.start

# class Car < Vehicle
#   include Maintenance
# end

# a_car = Car.new
# a_car.change_tires                          # => undefined local variable or method `wheels'

# SOME_STRING = "" 

# SOME_STRING = "New String" # Lookup ends here

# p SOME_STRING # Lookup starts here