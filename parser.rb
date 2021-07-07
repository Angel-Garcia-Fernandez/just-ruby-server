require 'optparse'

Options = Struct.new(:port)

class Parser
  def self.parse(options)
    args = Options.new()

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: ruby server.rb [options]\n" +
        "Description: creates an http server with a RESTful books API."

      opts.on("-pPORT", "--port=PORT", "port number (default 9999") do |p|
        args.port = p
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end

