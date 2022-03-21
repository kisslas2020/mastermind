require './player'
require './mastermind'

class Computer < Player

  attr_reader :code_set, :pattern, :last_guess, :peg_set, :possible_codes, :result_set, :previous_guesses, :possible_guesses

  include Mastermind

  def initialize(peg_set)
    super("Computer")
    @peg_set = peg_set
    @code_set = peg_set.repeated_permutation(4).to_a
    @possible_codes = code_set.dup
    @result_set = ["", "B", "W"].repeated_combination(4).to_a
    result_set.each { |rs| rs.delete("")}
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
    puts "Thinking... Please wait."
    
    @possible_codes = eliminate_possibilities(possible_codes, last_guess, result)
    
    min_eliminations = {}
    code_set.each do |code|
      next if previous_guesses.include?(code)
      min_eliminations[code] = calculate_max_remaining(code)
    end
    
    
    min_score = min_eliminations.min_by {|k, v| v}[1]
    @possible_guesses = min_eliminations.select { |k, v| v == min_score}.map { |k, v| k}.sort
    @last_guess = possible_guesses.select { |g| possible_codes.include?(g)}.first
    @last_guess = possible_guesses.first if last_guess == nil
    
    previous_guesses << last_guess
    last_guess
  end

  def calculate_max_remaining(code)

    result_set.reduce(0) do |max, res| 
      actual = count_remaining(code, res)
      max = actual > max ? actual : max
      max
    end

  end

  def eliminate_possibilities(possibilities, guess, result)
    possibilities.select { |po| evaluate_guess(guess, po, peg_set) == result}
  end

  def count_remaining(code, res)
    possible_codes.reduce(0)  do |count, pos|
      count += 1 if evaluate_guess(code, pos, peg_set) == res
      count
    end
  end

end
