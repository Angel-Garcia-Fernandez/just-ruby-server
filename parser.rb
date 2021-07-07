require 'optparse'

Options = Struct.new(:port)

class Parser
  def self.parse(options)
    args = Options.new()

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: ruby server.rb [options]"

      opts.on("-pPORT", "--port=PORT", "port number") do |p|
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

