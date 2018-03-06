module Hangman
  
  class Game
    
    def initialize
      @chosen_word = pick_random_word
      @word_length = chosen_word.length
      @board = Board.new(word_length)
    end
    
    def solicit_turn
      "Enter one of the remaining letters: "
    end
    
    def play
      puts "Pick your first letter"
      while true
        board.formatted_spaces
        puts ''
        puts solicit_turn
        x = get_move
        board.check_cells(x)
        if board.game_over
          puts game_over_message
          board.formatted_spaces
          return
        end
      end
    end
  
    private
    
    def pick_random_word
      chosen_word = nil
      File.foreach("5desk.txt").each_with_index do |word, index|
        word.downcase!
        if word.length > 5 && word.length < 12
          chosen_word = word if rand < 1.0/(index + 1)
        end
      end
      chosen_word
    end
  
  end
  
end