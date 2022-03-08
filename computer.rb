require './player'
require './mastermind'

class Computer < Player

  attr_reader :code_set, :pattern
  attr_accessor :possible_codes

  include Mastermind

  def initialize(peg_set)
    super(Computer)
    @code_set = peg_set.repeated_permutation(4).to_a
    @possible_codes = code_set.dup
  end

  def make_pattern(peg_set)
    @pattern = peg_set.shuffle.take(4)
    "Done."
  end

  def evaluate(guess, peg_set)
    evaluate_guess(pattern, guess, peg_set)
  end

  def guess(peg_set, result)
    puts "Press ENTER to continue!"
    gets
    return %w(1 1 2 2) if result.length == 0
    



    ["3", "4", "5", "6"]
  end

end
