require "socket" #bunch of classes and methods

server = TCPServer.new("localhost", 3003) 
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  client.puts request_line
  client.close
end

# networking protocol. it's the layer beneath HTTP. let's take it for granted that it's this thing that exists that we ubild on top of. 
# creating a server on localhost. requests go to localhost. we will use port 3003. port just tells which port we want to connect to as part of the server. there can be many ports. the standard ones are 80 and 443 (if encrypted). you'd want to use ports that are not used.
# server.accept -> waits for a request. once a request comes in, it accepts that call then returns a client object
# we use gets the first line of whatevers in client (e.g. get /)
# then we send it back to the client to make sure it shows in the browser
# then close it