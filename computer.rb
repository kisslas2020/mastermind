require './player'
require './mastermind'

class Computer < Player

  attr_reader :code_set, :pattern, :last_guess, :peg_set, :possible_codes, :result_set, :previous_guesses, :possible_guesses

  include Mastermind

  def initialize(peg_set)
    super(Computer)
    @peg_set = peg_set
    @code_set = peg_set.repeated_permutation(4).to_a
    @possible_codes = code_set.dup
    @result_set = ["", "B", "W"].repeated_combination(4).to_a
    @last_guess = %w(1 1 2 2)
    @previous_guesses = [@last_guess]
  end

  def make_pattern
    @pattern = peg_set.shuffle.take(4)
    "Done."
  end

  def evaluate(guess)
    evaluate_guess(pattern, guess, peg_set)
  end

  def guess(result)
    return last_guess if result == nil
    
    @possible_codes = eliminate_possibilities(possible_codes, last_guess, result)
    min_eliminations = {}
    
    code_set.each do |code|
      next if previous_guesses.include?(code)
      min_eliminations[code] = calculate_min_eliminated(possible_codes, code, possible_codes.length)
    end
    
    max_score = min_eliminations.max_by {|k, v| v}[1]
    @possible_guesses = min_eliminations.select { |k, v| v == max_score}.map { |k, v| k}.sort
    @last_guess = possible_guesses.select { |g| possible_codes.include?(g)}.first
    @last_guess = possible_guesses.first if last_guess == nil
    previous_guesses << last_guess
    last_guess
  end

  def calculate_min_eliminated(possibilities, code, pl)
    min = pl
    result_set.each do |res| 
      possible_eliminated = pl - eliminate_possibilities(possibilities, code, res).length
      min = possible_eliminated if possible_eliminated < min
    end
  end

  def eliminate_possibilities(possibilities, guess, result)
    possibilities.select { |po| evaluate_guess(guess, po, peg_set) == result}
  end

end
