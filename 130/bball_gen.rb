# for assessment
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