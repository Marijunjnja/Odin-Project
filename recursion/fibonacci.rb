def  fibs(n)
  ary = [0, 1]
  i = 2
  current_number = 1
  previous_number = 0
  while i < n + 1 do
    current_number, previous_number = current_number + previous_number, current_number
    ary << current_number
    i += 1
  end
  ary
end

def fibs_rec(n)
  return 0 if n == 0
  return 1 if n == 1
  fibs_rec(n-1) + fibs_rec(n-2)
end

puts fibs 0
puts fibs 10

puts fibs_rec 0
puts fibs_rec 10