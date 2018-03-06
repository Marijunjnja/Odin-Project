class LinkedList
  attr_accessor :head, :tail
  def initialize(value = nil)
    @head = Node.new(value)
  end
  
  def append(value)
    current = head
    while current.next_node != nil
      current = current.next_node
    end
    current.next_node = Node.new(value)
  end
  
  def prepend(value)
    current = Node.new(value, head)
    @head = current
  end
  
  def size
    size = 0
    current = head
    while current.next_node != nil
      size += 1
    end
    size
  end
  
  def head
    @head
  end
  
  def tail
    current = head
    while current.next_node != nil
      current = current.next_node
    end
    current
  end
  
  def at(index)
    current = head
    counter = 0
    until counter == index
      counter += 1
      current = current.next_node
    end
    current.value
  end
  
  def pop
    current = head
    while current.next_node != nil
      previous = current
      current = current.next_node
    end
    previous.next_node = nil
    current
  end
  
  def contains?(value)
    current = head
    while current.next_node != nil
      if current.value == value
        return true
      end
      current = current.next_node
    end
    return false
  end
  
  def find(value)
    current = head
    position = 0
    while current.next_node != nil
      if current.value == value
        return position
      end
      current = current.next_node
      position += 1
    end
    return nil
  end
  
  def to_s
    current = head
    string = "( #{current.value} )"
    while current.next_node != nil
      current = current.next_node
      string += " -> ( #{current.value} )"
    end
    string
  end
  
  def insert_at(value, index)
    current = head
    position = 0
    until position == index
      position += 1
      previous = current
      current = current.next_node
    end
    new_node = Node.new(value)
    previous.next_node = new_node
    new_node.next_node = current
  end
  
  def remove_at(index)
    current = head
    position = 0
    until position == index
      position += 1
      previous = current
      current = current.next_node
    end
    previous.next_node = current.next_node
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end



list = LinkedList.new 1
list.append 24
list.append 2
list.append 5
list.append 4
list.append 7
list.append 235
puts list.to_s
list.prepend 777
puts list.pop
puts list.to_s
puts list.contains? 4
puts list.contains? 6
puts list.find 2
puts list.at 2
list.insert_at 111, 3
puts list.to_s
list.remove_at 3
puts list.to_s