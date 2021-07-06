#Maple Ong's starting point

require 'socket'
require 'uri'
require 'yaml/store'

port = 9999
server = TCPServer.new(port)

#Create a YAML Store
store = YAML::Store.new('persistance/data.yml')

#ACTION VIEW
def daily_steps_form
  <<~STR
    <form action="/add/data" method="post" enctype="application/x-xxx-form-urlencoded">
      <p><label>Date <input type="date" name="date"></label></p>
      <p><label>Step Count <input type="number" name="step_count"></label></p>
      <p><button>Submit daily data</button></p>
    </form>
  STR
end

loop do
  #RACK WEB SERVER
  client = server.accept

  request_line = client.readline
  method_token, target, version_number = request_line.split
  puts "Received a #{method_token} request to #{target} with #{version_number}"

  #ACTION DISPATCH
  case [method_token, target]

  when ["GET", "/show/data"]
    #CONTROLLER
    status_code = '200 OK'
    response_message = "<h1> Daily Steps Tracker! </h1>" << daily_steps_form
    response_message << '<ul>'

    #ACTIVE RECORD/MODEL
    #READ data from file
    all_data = {}
    store.transaction do
      all_data = store[:daily_steps]
    end

    all_data.each do |daily_steps|
      response_message << "<li> On <b>#{daily_steps[:date]}</b>, I walked #{daily_steps[:step_count]} steps!"
    end
    response_message << '</ul>'
  when ["POST", "/add/data"]
    #CONTROLLER
    status_code ='303 See Other'
    response_message = ''

    headers = {}
    while true
      line = client.readline
      break if line == "\r\n"
      header_name, value = line.split(': ')
      headers[header_name] = value
    end

    body = client.read(headers['Content-Length'].to_i)
    new_daily_steps = URI.decode_www_form(body).to_h

    #ACTIVE RECORD/MODEL
    #WRITE user input to file
    store.transaction do
      store[:daily_steps] << new_daily_steps.transform_keys(&:to_sym)
    end
  end
end