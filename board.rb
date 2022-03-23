class Board

  attr_accessor :pattern, :decoding_board, :feedback_board, :turns

  def initialize(turns)
    @decoding_board = Array.new
    @feedback_board = Array.new
    @pattern = %w(? ? ? ?)
    @turns = turns
  end

  def print_board
    
    turns.times do |i|
      print "\t"*4
      print " " if i < 9
      print "#{i + 1}\t"
      decoding_board[i].each { |n| print "#{n}\t"} if i < decoding_board.length
      print ".\t" * 4 unless i < feedback_board.length
      feedback_board[i].each { |n| print "#{n} "} if i < feedback_board.length
      puts
    end
    print "\t"*5
    pattern.each { |n| print "#{n}\t"}
    puts
  end

  private

  def self.clear
    print "\e[2J\e[f"
  end
end
