module Mastermind
  
  def evaluate_guess(pattern, guess, peg_set)

    hits = 0

    peg_set.each do |peg|
      hits += [pattern.select { |p| peg == p }.count, guess.select { |p| peg == p }.count].min
    end
    
    correct_positions = 0

    4.times do |i|
      correct_positions += 1 if pattern[i] == guess[i]
    end

    result = Array.new(correct_positions, "B") + Array.new(hits - correct_positions, "W")

  end

end
