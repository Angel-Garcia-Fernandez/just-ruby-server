require 'socket'
require 'uri'

Dir['resources/*.rb'].each { |file| require_relative file }

require_relative 'config/routes'
require_relative 'parser'

opts = Parser.parse ARGV
port = opts.port || 9999
server = TCPServer.new(port)


#Create a YAML Store
require 'yaml/store'
store = YAML::Store.new('persistance/data.yml')


while session = server.accept
  request = session.gets

  unless request.nil?
    method_token, target, version_number = request.split
    puts "Received a #{method_token} request to #{target} with #{version_number}"

    # Route request & build response
    routes = Routes.new
    http_response = routes.resolve(method_token, target)

    # Send response
    session.puts http_response
  end
  session.close
end

