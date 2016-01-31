arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

def print_values_in_an_array(arr)
  new_arr = []
  arr.each do |e|
    new_arr = arr.select { |e| e.odd?}
  end
  return new_arr
end