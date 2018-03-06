module Hangman
  
  class Board
    
    attr_reader :spaces
    
    def initialize(chosen_word, word_length)
      @chances = 9
      @chosen_word = chosen_word
      @word_length = word_length
      @spaces
    end
    
    def get_cell(x)
      spaces[x]
    end
    
    def set_cell(x, value)
      get_cell(x).value = value
    end
    
    def formatted_spaces
      spaces.each do |space|
        puts space.map { |cell| cell.value.empty? ? '_' : cell.value }.join(' ')
      end
    end
    
    private
    
    def default_spaces
      Array.new(10) { Cell.new }
    end
    
    def initialize_blanks(chosen_word)
      word_length = chosen_word.length
      return Array.new(word_length, '_').join(' ')
    end
    
    def win?
      spaces.map { |space| space.value }.none_empty?
    end
    
  end
  
end