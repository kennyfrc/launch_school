h = {a:1, b:2, c:3, d:4}

h[:b] # this will return 2

h[:e] = 5

h.reject! {|k,v| v < 3.5} 