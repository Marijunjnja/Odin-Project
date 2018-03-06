class Node
  attr_accessor :position_x, :position_y, :neighbors
  
  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
    @neighbors = []
  end
end

class Board
  attr_accessor :positions
  
  def initialize
    @positions = build_board
    set_positions
  end
  
  def build_board
    Array.new(8) { Array.new(8) { Node.new(0, 0) } }
  end
  
  def set_positions
    positions.each_with_index do |row, index|
      row.each_with_index do |cell, windex|
        puts "#{index}, #{windex}"
        cell.position_x = index
        cell.position_y = windex
      end
    end
  end
  
  def display_board
    positions.each do |row|
      row.each do |cell|
        "(#{cell.position_x}, #{cell.position_y})"
      end
    end
  end
end

board = Board.new
puts board.display_board