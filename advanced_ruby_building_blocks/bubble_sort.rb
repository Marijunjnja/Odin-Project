def bubble_sort(items)
  
  n = items.length
  
  loop do
  
    swapped = false
    
    (n-1).times do |i|
    
      if items[i] > items[i + 1]
        
        items[i], items[i + 1] = items[i + 1], items[i]
        swapped = true
        
      end
    
    end
    
    break if not swapped
  
  end
  
  items
  
end

def bubble_sort_by(items)
  
  n = items.length
  
  loop do
    swapped = false
    
    (n-1).times do |i|
      
      if yield(items[i], items[i+1]) > 0
        
        items[i], items[i+1] = items[i+1], items[i]
        swapped = true
        
      end
      
    end
    
    break if not swapped
  
  end
  
  items
  
end


puts bubble_sort([4,3,78,2,0,2])

bubble_sort_by(["hi", "hello", "hey", "ocechobie", "los angeles", "at"]) do |left, right|
  
  left.length - right.length

end