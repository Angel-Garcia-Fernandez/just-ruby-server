require 'socket'
require 'uri'

Dir['resources/*.rb'].each { |file| require_relative file }

require_relative 'config/routes'
require_relative 'persistance/persistance_model'
require_relative 'parser'

# Parse command line options
opts = Parser.parse ARGV

# Create TCP server
port = opts.port || 9999
server = TCPServer.new(port)

# Start persistance model
PersistanceModel.start

# Start server to listen to port
while session = server.accept
  # Listening to requests
  request = session.gets

  # Process requests
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

