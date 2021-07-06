require 'socket'
require 'uri'
require 'yaml/store'
Dir['resources/*.rb'].each { |file| require_relative file }
require_relative 'config/routes'

port = 3000
server = TCPServer.new(port)

#Create a YAML Store
store = YAML::Store.new('persistance/data.yml')


loop do
  client = server.accept

  request_line = client.readline
  method_token, target, version_number = request_line.split
  puts "Received a #{method_token} request to #{target} with #{version_number}"

  routes = Routes.new

  http_response = routes.resolve(method_token, target)

  client.puts http_response
  client.close
end

