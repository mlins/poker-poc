$:.unshift("lib")

require "sinatra"
require "game"

get '/' do
  @game = Game.new(File.open("poker.txt").read)

  erb :index
end
