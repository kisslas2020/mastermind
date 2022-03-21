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
    print_game
    
    codemaker.make_pattern(peg_set)
    result = nil

    turns.times do |i|
      @turn = i + 1
      
      print_game
      puts "Press ENTER to continue"
      gets
      print_game
      guess = codebreaker.guess(result)
      
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
    puts "MASTERMIND
    is a game where you have to guess your opponent’s secret code
    within a certain number of turns.
    Each turn you get some feedback about how good your guess was
    whether it was exactly correct or just the correct color but in the wrong space.".lines.map { |line| line.strip.center(100) }.join("\n")
    puts
    board.print_board
    puts
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
p2 = Human.new("Laci")
p1 = Computer.new(peg_set)
b = Board.new

game = Game.new(p1, p2, b)

game.play(peg_set)


