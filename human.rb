require './player'
require './mastermind'

class Human < Player

  include Mastermind
  attr_accessor :pattern

  def initialize(name)
    super(name)
    @pattern = []
  end

  def make_pattern(peg_set)
    
    @pattern = make_a_code(peg_set, "pattern")
    "Done."
  end

  def evaluate(guess, peg_set)
    evaluate_guess(pattern, guess, peg_set)
  end

  def guess(peg_set, result)
    return make_a_code(peg_set, "guess")
  end

  def make_a_code(peg_set, str)
    loop do
      print "Make your #{str}! "
      code = gets.chomp.split("")
      puts "Your #{str}'s length is invalid" if code.length != 4
      return code if (code - peg_set).size == 0
      puts "Your #{str} includes invalid character"
    end
  end

end
