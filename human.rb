require './player'
require './mastermind'

class Human < Player

  include Mastermind
  attr_accessor :pattern

  def initialize(name)
    super(name)
    @pattern = []
  end

  def make_pattern(peg_set, repeat)
    
    @pattern = make_a_code(peg_set, repeat, "pattern")
    "Done."
  end

  def evaluate(guess, peg_set)
    evaluate_guess(pattern, guess, peg_set)
  end

  def guess(peg_set, repeat, result)
    return make_a_code(peg_set, repeat, "guess")
  end

  def make_a_code(peg_set, repeat, str)
    loop do
      print "Make your #{str}! "
      code = gets.chomp.split("")
      unless code.length == 4
        puts "Your #{str}'s length is invalid"
        next
      end
      unless repeat
        if check_repetition(code)
          puts "Your #{str} includes repetition which is not allowed."
          next
        end
      end
      return code if (code - peg_set).size == 0
      puts "Your #{str} includes invalid character"
    end
  end

  def check_repetition(code)
    code.each do |c|
      count_c = code.tally[c]
      return true if count_c > 1
    end
    return false
  end

end
