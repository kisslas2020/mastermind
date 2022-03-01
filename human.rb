require './player'

class Human < Player

  def initialize(name)
    super(name)
  end

  def guess(peg_set)
    loop do
      print "Make a guess! "
      my_guess = gets.chomp.split("")
      if my_guess.length != 4
        puts "Your guess's length is invalid"
      elsif (my_guess - peg_set).size == 0
        return my_guess
      else
        puts "Your guess includes invalid character"
      end
    end
  end

end
