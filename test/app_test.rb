ENV["APP_ENV"] = "test"

require_relative "../app"
require "minitest/autorun"
require "rack/test"

class TestApp < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    get "/"
    assert last_response.ok?
    assert_equal "Hello World", last_response.body
  end
end
