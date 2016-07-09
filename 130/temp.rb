#2 Try rewriting this whole answer as currently its incorrect. (-6)

#3 "By allowing a class to sub-class from only one super-class; but" that is not a way to handle multiple inheritence. That is the cause of the 'issue'.

The terminology (at method lookup chain) is slightly incorrect - You name the object's class as "calling object". By object in Ruby, we define the instance of a class, then "it first seeks the method within the calling object" is wrong as the object itself does not have that method definition. (-2.5)

irb(main):001:0> class Attempt
irb(main):002:1>   def test
irb(main):003:2>   end
irb(main):004:1> end
=> :test
irb(main):005:0> a = Attempt.new
=> #<Attempt:0x007fa504199de8>
irb(main):006:0> a.test
=> nil
irb(main):007:0> class Attempt
irb(main):008:1>   undef_method(:test)
irb(main):009:1> end
=> Attempt
irb(main):010:0> a.test
NoMethodError: undefined method `test' ...
#4 The most important difference is that module can not instantiate its own objects, while class can. (-2.5)

#8 - The implementation of total_people method is wrong as you can do this:

Person.total_people #=> 1
Person.total_people #=> 2
Person.total_people #=> 3
The total_people method does not return total number of people. It increments the class variable and returns it. (-6)

#12 - can_delegate? methods could be in a module that would be included in Executive & Manager classes. (-1)


Hi All,

As requested, Im rewriting the answers again.

## 2. Explain what class inheritance is. Use code to illustrate your explanation.

Class inheritance occurs when a class inherits behaviors from another class, which is called the superclass. The act of inheriting is called sub-classing. The benefit of inheritance is that it allows us to define classes that enable us to re-use code or avoid duplication. That said, class inheritance is at the heart of the DRY principle.

# say we're creating a basketball simulation game. as part of that game, we have a "create player" feature. to simplify the life of the user, we would want to auto-generate skill levels based on the position of the player. here, we use the example of a player whose position is a "Center"

class Player
  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
  end

  def info
    puts "This is #{name}'s stats:"
    puts "Inside Scoring: #{inside_scoring}"
    puts "Inside Defense: #{inside_defense}"
    puts "Rebounding: #{rebounding}"
    puts "Outside Scoring: #{outside_scoring}"
    puts "Outside Defense: #{outside_defense}"
    puts "Playmaking: #{playmaking}"
    puts "Free Throws: #{free_throws}"
    puts "Strength: #{strength}"
    puts "Stamina: #{stamina}"
  end

  def generate_inside_scoring(position)
    case position
    when :center
      on_the_high_side
    when :forward
      in_the_middle
    when :guard
      on_the_low_side
    end
  end

  def generate_inside_defense(position)
    case position
    when :center
      on_the_high_side
    when :forward
      in_the_middle
    when :guard
      on_the_low_side
    end
  end

  def generate_outside_scoring(position)
    case position
    when :center
      on_the_low_side
    when :forward
      in_the_middle
    when :guard
      on_the_high_side
    end
  end

  def generate_outside_defense(position)
    case position
    when :center
      on_the_low_side
    when :forward
      in_the_middle
    when :guard
      on_the_high_side
    end
  end

  def generate_rebounding(position)
    case position
    when :center
      on_the_high_side
    when :forward
      in_the_middle
    when :guard
      on_the_low_side
    end
  end

  def generate_playmaking(position)
    case position
    when :center
      on_the_low_side
    when :forward
      in_the_middle
    when :guard
      on_the_high_side
    end
  end

  def generate_free_throws(position)
    could_be_anything
  end

  def generate_strength(position)
    could_be_anything
  end

  def generate_stamina(position)
    could_be_anything
  end

  private

  def on_the_high_side
    (70...100).to_a.sample
  end

  def in_the_middle
    (50...80).to_a.sample
  end

  def on_the_low_side
    (30...60).to_a.sample
  end

  def could_be_anything
    (30...100).to_a.sample
  end
end

# center inherits from Player. given this inheritance, we can retrieve behaviors from Player.
class Center < Player
  attr_accessor :inside_scoring, :inside_defense, :rebounding, 
                :outside_scoring, :outside_defense, :playmaking,
                :free_throws, :strength, :stamina
  attr_reader :name, :height, :weight

  POSITION = :center

  def initialize(name, height, weight)
    super
    @inside_scoring, @inside_defense, @rebounding = generate_inside_scoring(POSITION), generate_inside_defense(POSITION), generate_rebounding(POSITION)
    @outside_scoring, @outside_defense, @playmaking = generate_outside_scoring(POSITION), generate_outside_defense(POSITION), generate_playmaking(POSITION)
    @free_throws, @strength, @stamina = generate_free_throws(POSITION), generate_strength(POSITION), generate_stamina(POSITION)
  end
end

kenn = Center.new("Kenn Costales", 220, 235)
puts kenn.info
```

 
# 3 How does Ruby handle the problem of multiple inheritance? Explain how this modifies the method lookup chain. Use code to illustrate your explanation.

It tackles the multiple inheritance problem in that it allows a class to mix in from as many modules as it wants to.

It modifies the method lookup chain as follows: 1) it first seeks the method within the class, 2) then it traverses through the modules in reverse order, 3) then it looks up to its super-class, and 4) it does the sequence of Class-Modules-SuperClass again until it reaches BasicObject.

Using our basketball example, we can add a module that can modify behaviors based on the potential of the player. This enables us to create a new MVPCenter class which inherits from both the Center class and the MVPable module, without causing any conflicts.

```
module MVPable
  def on_the_high_side
    base = (70...100).to_a.sample
    base += 10 if base < 91
    base
  end

  def in_the_middle
    base = (50...80).to_a.sample
    base += 15
    base
  end

  def on_the_low_side
    base = (30...60).to_a.sample
    base += 20
    base
  end

  def could_be_anything
    base = (30...100).to_a.sample
    base += 10 if base < 91
    base
  end
end

# same code as above

class MVPCenter < Center
  include MVPable

  attr_accessor :inside_scoring, :inside_defense, :rebounding, 
                :outside_scoring, :outside_defense, :playmaking,
                :free_throws, :strength, :stamina
  attr_reader :name, :height, :weight

  def initialize(name, height, weight)
    super
  end
end

kenn = MVPCenter.new("Kenn Costales", 220, 235)
puts kenn.info
```

## 4 What's the difference between a class and a module?

Unlike classes, you can't instantiate modules and you can't read nor write instance methods.

## 8 Use the Person class below, and create a class method called total_people, and have it return the total number of Person objects created.

Whenever you instantiate an object, you should increment it by 1 and set the sum to @@total_people. You can do this within the constructor.

```
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

```


