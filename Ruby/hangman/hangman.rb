class Space
  attr_accessor :value
  def initialize(value = '_')
    @value = value
  end
end

class HangingMan
  attr_reader :chosen_word
  def initalize(chosen_word)
    @chances = 9
    @current_status = initialize_blanks()
  end
  
  def get_space(x)
    chosen_word[x]
  end
  
  def set_space(x, value)
    get_space.value = value
  end
  
  def get_remaining_chances
    
  end
  
  def initialize_blanks(chosen_word)
    word_length = chosen_word.length
    current_status = Array.new(word_length, '_')
    current_status.join(' ')
  end
  
end

class Game
  attr_accessor :chosen_word
  def initialize
    @chosen_word = pick_random_word
    @hangman = HangingMan.new(:chosen_word)
  end
  
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
  
  def load_game
    #load file
  end
  
  def new_game
    chosen_word = pick_random_word
    current_status = initialize_blanks(chosen_word)
  end
  
  def take_turn
    puts "Guess a letter, or type 'save' to save your progress"
    guess = gets.chomp.downcase!
    if guess == 'save'
      #save file
    elsif check_letter(guess)
      puts "Correct! Adding letter to answer"
    else
      puts "Incorrect!"
    end
  end
  
end

def display
  puts "Remaining chances: #{remaining_chances}"
  puts "Remaining letters: #{remaining_letters}"
  puts "Incorrect guesses: #{incorrect_letters}"
  puts "Current status: #{current_status}"
end



new_game
