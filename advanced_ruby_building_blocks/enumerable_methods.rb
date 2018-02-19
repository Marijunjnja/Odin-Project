module Enumerable 
  
  def my_each
    
    if block_given?
      for element in self
        yield(element)
      end
      self
    else
      self.to_enum(:my_each)
    end
  
  end
  
  def my_each_with_index
    
    if block_given?
      for i in 0...self.length
        yield(self[i], i)
      end
      self
    else
      self.to_enum(:my_each_with_index)
    end
    
  end
  
  def my_select
    
    new_array = []
    
    if block_given?
      for element in self
        new_array.push(element) if yield(element)
      end
    else
      self.to_enum(:my_select)
    end
    
    new_array
    
  end
  
  def my_all?
    
    result = true
    
    if block_given?
      for element in self
        if yield(element) == false
          result = false
        end
      end
    else
      self.to_enum(:my_all?)
    end
    
    result
    
  end
  
  def my_any?
    
    result = false
    
    if block_given?
      for element in self
        if yield(element) == true
          result = true
        end
      end
    else
      self.to_enum(:my_any?)
    end
    
    result
    
  end
  
  def my_none?
    
    result = true
    
    if block_given?
      for element in self
        if yield(element) == true
          result = false
        end
      end
    else
      self.to_enum(:my_none?)
    end
    
    result
    
  end
  
  def my_count
    
    count = 0
    
    for element in self
      if block_given?
        count += 1 if yield(element)
      elsif item
        count += 1 if element == item
      else
        count += 1
      end
    end
    
    count
    
  end
  
  def my_map(my_proc = nil)
    
    mapped_array = []
    
    for element in self
      if my_proc?
        my_proc.call(element)
      elsif block_given?
        mapped_array.push(yield(element))
      else
        mapped_array.push(element)
      end
    end
    
    mapped_array
    
  end
  
  def my_inject(memo = nil, enum = self.each)
    
    return enum_for(:my_inject) unless block_given?
    
    memo = enum.next if memo.nil?
    my_inject(yield(memo, enum.next), enum, &Proc.new)
  
  rescue StopIteration
  
    memo
    
  end

end

def multiply_els(array)
    
  array.my_inject(1) { |memo, enum| memo *= enum }
    
end