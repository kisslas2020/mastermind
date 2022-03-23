require './human'
require './computer'
require './board'

class Game

  attr_accessor :codebreaker,  :codemaker, :board, :turns, :peg_set, :repeat, :empty

  def initialize
    
  end

  def play
    setup_game
    codemaker.make_pattern(peg_set, repeat)
    result = nil
    last_turn = play_turns(result)
    board.pattern = codemaker.reveal_pattern
    print_game
    announcement(last_turn)
  end

  def setup_game
    @codemaker = add_player("codemaker")
    @codebreaker = add_player("codebreaker")
    @peg_set = create_pegset
    @turns = specify_number_of_turns
    @board = Board.new(turns)
    @repeat = specify_repetition
    @empty = specify_blanks
    peg_set << "0" if empty
  end

  def print_game
    Game.clear
    puts "MASTERMIND
    is a game where you have to guess your opponent’s secret code
    within a certain number of turns.
    Each turn you get some feedback about how good your guess was
    whether it was exactly correct (B) or just the correct color but in the wrong space (W).".lines.map { |line| line.strip.center(100) }.join("\n")
    puts
    board.print_board if board
    puts
  end

  def add_player(role)
    question = "The #{role} is Human (else Computer)?"
    answer = get_decision_from_user(question)
    name = ask_name(role)
    return Human.new(name) if answer == 'y'
    return Computer.new(name)
  end

  def ask_name(role)
    print "Enter the #{role}'s name (press ENTER for default) >> "
    name = gets.chomp
    name = role if name == ""
    name
  end

  def create_pegset
    num = get_number_from_user("How many colors do you want to play with?", 4, 6)
    ("1"..num).to_a
  end

  def specify_number_of_turns
    num = get_number_from_user("How many turns do you want to provide for the codebreaker to succed?", 8, 12)
    num.to_i
  end

  def specify_repetition
    question = "Can one color be used more that once?"
    answer = get_decision_from_user(question)
    return answer == 'y' ? true : false
  end

  def specify_blanks
    question = "Do you want to allow using blanks?"
    answer = get_decision_from_user(question)
    return answer == 'y' ? true : false
  end

  def get_number_from_user(question, from, to)
    print_game
    print "#{question} Enter a number between #{from} and #{to} >> "
    begin
      num = Kernel.gets.match(/\d+/)[0]
    rescue NoMethodError=>e
      print "Your input contains non-digit character. Try again >> "
      retry
    else
      return num if num.to_i.between?(from, to)
      print "The number must be between #{from} and #{to} inclusive! Try again."
      sleep 5
      get_number_from_user(question, from, to)
    end 
  end

  def get_decision_from_user(question)
    print_game
    print "#{question} Enter Y or N >> "
    answer = gets.chomp
    answer.downcase!
    return answer if ["y", "n"].include?(answer)
    print "Your answer can only be one of the letters 'Y' and 'N'. Try again."
    sleep 3
    get_decision_from_user(question)
  end

  def play_turns(result)
    
    turns.times do |i|
      
      print_game
      puts "Press ENTER to continue"
      gets
      print_game
      guess = codebreaker.guess(peg_set, repeat, result)
      board.decoding_board << guess
      result = codemaker.evaluate(guess, peg_set)
      board.feedback_board << result
      
      return i + 1 if result == Array.new(4, "B")

    end

  end

  def announcement(last_turn)
    winner = last_turn < turns ? codebreaker : codemaker
    puts "The winner is #{winner.name} in #{last_turn} turns."
  end

  def self.clear
    print "\e[2J\e[f"
  end
end

game = Game.new
game.play


