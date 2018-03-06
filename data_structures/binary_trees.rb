class Node
  include Enumerable
  
  attr_accessor :value, :left, :right
  def initialize(value = nil)
    @value = value
    @left = EmptyNode.new
    @right = EmptyNode.new
  end
  
  def insert(input)
    return if self.include? input
    case value <=> input
      when 1 then insert_left(input)
      when -1 then insert_right(input)
      when 0 then false
    end
  end
  
  def inspect
    "{#{value}::#{left.inspect}|#{right.inspect}}"
  end
  
  def include?(input)
    case value <=> input
      when 1 then left.include?(input)
      when -1 then right.include?(input)
      when 0 then true
    end
  end
  
  def build_tree(array = nil)
    array.each { |value| self.insert(value) }
  end
  
  private
  
  def insert_left(input)
    left.insert(input) or self.left = Node.new(input)
  end
  
  def insert_right(input)
    right.insert(input) or self.right = Node.new(input)
  end
end

class EmptyNode
  def initialize
    @value = nil
  end
  
  def include?(*)
    false
  end
  
  def insert(*)
    false
  end
  
  def inspect
    "{}"
  end
end


tree = Node.new(1)
tree.build_tree([4,6,7,2,3,74,88,99])
tree.insert 5
puts tree.inspect