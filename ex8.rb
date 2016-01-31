arr = ["first", 1, "second", 2]
hash_1 = Hash[*arr]
hash_2 = {"first": 1, "second": 2}
hash_3 = {:first => 1, :second => 2}

puts hash_1
puts hash_2
puts hash_3