class Array
  def all_empty?
    self.all? { |element| element.to_s.empty? }
  end
  
  def all_same?
    self.all? { |element| element == self[0] }
  end
  
  def any_empty?
    self.any? { |element| element.to_s.empty? }
  end
  
  def none_empty?
    !any_empty?
  end
end

class Cell
  attr_accessor :value
  def initialize(value = '')
    @value = value
  end
end

class Board
  attr_reader :grid
  def initialize(grid = default_grid)
    @grid = grid
  end
  
  def get_cell(x, y)
    grid[y][x]
  end
  
  def set_cell(x, y, value)
    get_cell(x,y).value = value
  end
  
  def game_status
    return :winner if winner?
    return :draw if draw?
    false
  end
  
  def draw?
    grid.flatten.map { |cell| cell.value }.none_empty?
  end
  
  def winner?
    winning_positions.each do |winning_position|
      next if winning_position_values(winning_position).any_empty?
      return true if winning_position_values(winning_position).all_same?
    end
    false
  end
  
  def winning_positions
    grid + grid.transpose + diagonals
  end
  
  def diagonals
    [
      [get_cell(0,0), get_cell(1,1), get_cell(2,2)],
      [get_cell(0,2), get_cell(1,1), get_cell(2,0)]
    ]
  end
  
  def winning_position_values(winning_position)
    winning_position.map { |cell| cell.value }
  end
  
  def formatted
    puts "#{grid[0][0].value} | #{grid[0][1].value} | #{grid[0][2].value}"
    puts "----------"
    puts "#{grid[1][0].value} | #{grid[1][1].value} | #{grid[1][2].value}"
    puts "----------"
    puts "#{grid[2][0].value} | #{grid[2][1].value} | #{grid[2][2].value}"
  end
  
  private
  
  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end
end

class Player
  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  attr_accessor :players, :board, :current_player, :next_player
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @next_player = players.shuffle
  end
  
  def solicit_turn
    puts "#{current_player.name}, enter a space for your next move (1-9)"
  end
  
  def get_move(move = gets.chomp)
    move_to_coordinate(move)
  end
  
  def move_to_coordinate(move)
    mapping = {
      "1" => [0, 0],
      "2" => [1, 0],
      "3" => [2, 0],
      "4" => [0, 1],
      "5" => [1, 1],
      "6" => [2, 1],
      "7" => [0, 2],
      "8" => [1, 2],
      "9" => [2, 2]
    }
    mapping[move]
  end
  
  def switch_player
    @current_player, @next_player = @next_player, @current_player
  end
  
  def game_over_message
    return "#{current_player.name} has won!" if board.game_status == :winner
    return "The game ended in a tie!" if board.game_status == :draw
  end
  
  def play
    puts "#{current_player.name} has been randomly selected as the first player"
    while true
      board.formatted
      puts ""
      puts solicit_turn
      x, y = get_move
      if board.get_cell(x, y) != ''
        board.set_cell(x, y, current_player.symbol)
      else
        puts "Invalid move"
        puts solicit_turn
      if board.game_status
        puts game_over_message
        board.formatted
        return
      else
        switch_player
      end
    end
  end
end


bannon = Player.new("Bannon", "X")
nicolette = Player.new("Nicolette", "O")
players = [bannon, nicolette]

game = Game.new(players)
game.play


