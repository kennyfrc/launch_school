require "sinatra"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("public/*").map {|file| File.basename(file) }
  @files.reverse! if params[:sort] == "desc"
  erb :list
end