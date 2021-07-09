require 'socket'
require 'uri'

# require all the resources
Dir['resources/*.rb'].each { |file| require_relative file }

require_relative 'config/routes'
require_relative 'parser'
require_relative 'server_helper'

# Parse command line options
opts = Parser.parse ARGV

# Create TCP server
port = opts.port || 9999
server = TCPServer.new(port)

# Start persistence model
PersistenceModel.start

# Start server to listen to port
while session = server.accept
  # Listening to requests
  full_request = get_full_request(session)
  request_line = full_request[0]

  # Process requests
  unless request_line.nil?
    method_token, target, version_number = request_line.split

    # Extract data
    data = extract_data(full_request, session, method_token)

    # Server side correction of RESTful methods
    if method_token == 'POST' && ['PUT', 'DELETE'].include?(corrected_method_token = data['_method']&.upcase)
      method_token = corrected_method_token
    end

    # Log request
    puts "Received a #{method_token} request to #{target} with #{version_number}"

    # Route request & build response
    routes = Routes.new
    http_response = routes.resolve(method_token, target, data)

    # Send response
    session.puts http_response
  end
  session.close
end
