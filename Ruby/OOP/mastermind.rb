class Cell
  attr_reader :color
  def initialize(color)
    @color = color
  end
end

class Board
  attr_reader :positions
  attr_accessor :guesses
  def initialize(positions = default_positions)
    @positions = positions
    @guesses = {}
  end
  
  def possible_colors
    %w(green blue red yellow white black)
  end
  
  def check_sequence?(guess)
    positions == guess
  end
  
  def display_board
    positions.each { |position| puts position }
  end
  
  private
  
  def default_positions
    Array.new(4) { possible_colors.sample }
  end
end

class Game
  attr_accessor :board, :remaining_turns
  def initialize
    @board = Board.new
    @remaining_turns = 12
  end
  
  def solicit_move
    puts "Type 4 colors from #{board.possible_colors}, separated by commas"
  end
  
  def get_guess(guess = gets.chomp)
    guess.split(',')
  end
  
  def play
    board.display_board
    solicit_move
    guess = get_guess
    until board.check_sequence?(guess)
      "#{board.get_previous_moves} : #{board.get_previous_results}"
      
      solicit_move
    end
  end
end

class Array
  def same_color?
    
  end
  
  def color_exists?
    
  end
end

game = Game.new
game.play