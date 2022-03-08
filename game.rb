require './human'
require './computer'
require './board'

class Game

  attr_accessor :codebreaker,  :codemaker, :board, :turn, :turns

  def initialize(codebreaker, codemaker, board)
    @codebreaker = codebreaker
    @codemaker = codemaker
    @board = board
    @turns = 12
  end

  def play(peg_set)
    
    codemaker.make_pattern(peg_set)
    result = []

    turns.times do |i|
      @turn = i + 1
      #puts "inside times turn = #{turn}"
      print_game
      guess = codebreaker.guess(peg_set, result)
      board.decoding_board << guess
      result = codemaker.evaluate(guess, peg_set)
      board.feedback_board << result
      break if result == Array.new(4, "B")
    end
    
    board.pattern = codemaker.reveal_pattern
    print_game
    announcement
  end

  def print_game
    Game.clear
    puts "MASTERMIND"
    board.print_board
  end

  def announcement
    winner = turn < turns ? codebreaker : codemaker
    puts "The winner is #{winner.name} in #{turn} turns."
  end

  def self.clear
    print "\e[2J\e[f"
  end
end

peg_set = %w(1 2 3 4 5 6)
p1 = Human.new("Laci")
p2 = Computer.new(peg_set)
b = Board.new

game = Game.new(p1, p2, b)

game.play(peg_set)

