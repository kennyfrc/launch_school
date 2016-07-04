# ## Explain the relationship between classes and objects. Use code to illustrate your explanation.

# This is best explained through analogy: a class is like a mold, and an object is like a product of that mold. In other words, there are fixed properties that exist in a class that applies across all its object instances. For example, if we have initialized instance variables and if we have defined methods within a class, all of these properties also exist in all of its object instances. # talk about exceptions?

# Example:
class Fruit
  attr_accessor :condition

  def initialize(type, condition = "unripe")
    @type = type
    @condition = condition
  end

  def ripen
   if condition == "unripe"
     self.condition = "ripe"
   else 
     "it’s already ripe"
   end
  end
end

banana = Fruit.new("banana")

module Blendable
  def turn_into_shake
    "Here's your #{self.condition} #{self.type} shake!"
  end
end

class Fruit
  include Blendable
  attr_accessor :condition, :type

  def initialize(type, condition = "unripe")
    @type = type
    @condition = condition
  end

  def ripen
   if condition == "unripe"
     self.condition = "ripe"
   else 
     "it’s already ripe"
   end
  end
end


  class Person
    @@total_people = 0
    attr_accessor :name, :weight, :height

    def initialize(name, weight, height)
      @name = name
      @weight = weight
      @height = height
      @@total_people += 1
    end

    def change_info(name, weight, height)
      self.name = name
      self.weight = weight
      self.height = height
    end

    def self.total_people
      @@total_people
    end
  end

#   bob = Person.new('bob', 185, 70)
#   bob.change_info("lebron", "245", "80")
#   bob.name # => "lebron"
#   bob.weight #=> "245"
#   bob.height #=> "80"
#   Person.total_people       # this should return 1


#   An employee management application has information about the employees in the company. All employees have a name, a serial number, and are either full-time or part-time.

# All executives and managers are full-time employees. Full-time employees that are neither an executive nor a manager are designated as regular employees.

# Executives receive 20 days of vacation, while managers receive 14 days. Regular employees receive 10 days of vacation. Part-time employees do not receive vacations.

# Executives work at a desk in a corner office. Managers work at a desk in a regular private office. Regular employees are assigned to desks in the cubicle farm. Part-time employees work in an open workspace with no reserved desk.

# When displaying or printing an employee's name, we need to prefix the name with "Mgr" if the employee is a manager, or "Exe" if the employee is an executive. Other employees do not require a prefix.

# Managers and executives can delegate work, while other employees can not.


# Employee

# designation
# name
# serial number
# full time or part time (depending on level)
# vacations

# Executives
# - name custom
# - delegate
# - corner

# Managers
# - name custom
# - delegate
# - private

# Regular
# - cubicle

# Part-time
# - open seating

class Employee
  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end  
end

class Executive < Employee
  attr_reader :name, :serial_number, :vacations, :desk_type

  def initialize(name, serial_number)
    super
    @vacations = 20
    @desk_type = "corner office"
  end

  def name
    "Exe " + @name
  end

  def can_delegate?
    true
  end
end

class Manager < Employee
  attr_reader :name, :serial_number, :vacations, :desk_type

  def initialize(name, serial_number)
    super
    @vacations = 14
    @desk_type = "private room"
  end

  def name
    "Mgr " + @name
  end

  def can_delegate?
    true
  end
end

class Regular < Employee
  attr_reader :name, :serial_number, :vacations, :desk_type

  def initialize(name, serial_number)
    super
    @vacations = 10
    @desk_type = "cubicle"
  end
end

class PartTime < Employee
  attr_reader :name, :serial_number, :vacations, :desk_type

  def initialize(name, serial_number)
    super
    @vacations = 0
    @desk_type = "hotdesk"
  end
end

# Manager.new
# PartTime.new
# REgular.new

def time_it_takes
  time_before = Time.now
  yield
  time_after = Time.now

  puts "It takes #{time_after - time_before} seconds"
end

