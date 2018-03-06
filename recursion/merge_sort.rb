def merge_sort(array)
  size = array.size
  return array if size < 2
  mid = size / 2
  left = array[0...mid]
  right = array[mid...size]
  merge(merge_sort(left), merge_sort(right))
end
  
def merge(left, right)
  sorted_array = []
  puts "left half: #{left}, right half: #{right}"
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted_array << left.shift
    else
      sorted_array << right.shift
    end
  end
  sorted_array.concat(left).concat(right)
end
  

puts merge_sort([1,5,3,2,4,8,9,6,7,0])