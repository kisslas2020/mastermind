class Computer < Player

  def initialize(name)
    super(name)
  end

  def random_pattern(peg_set)
    pattern = peg_set.shuffle.take(4)
  end

end
