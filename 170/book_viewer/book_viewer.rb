require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Whatever"
  @contents = File.readlines("data/toc.txt")
  erb :home
end

get "/chapters/1" do
  @contents = File.read("data/chp1.txt")
  erb :chapter
end
