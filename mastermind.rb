module Mastermind
  
  def evaluate_guess(pattern, guess, peg_set)
    hits = 0
    peg_set.each { |peg| hits += [pattern.count(peg), guess.count(peg)].min }
    correct_positions = 0
    pattern.each_with_index { |p, i| correct_positions += 1 if p == guess[i]}
    result = ("B" * correct_positions + "W" * (hits - correct_positions)).split("")
    result
  end

end
