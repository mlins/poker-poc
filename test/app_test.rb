require "test_helper"

require_relative "../app"

class TestApp < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    get "/"
    assert last_response.ok?
    assert last_response.body.include?("Poker")
  end
end
