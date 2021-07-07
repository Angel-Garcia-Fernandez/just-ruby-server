require 'yaml/store'

class PersistanceModel
  @@store = nil

  class << self
    def start
      # Load all model classes
      Dir['app/models/*.rb'].each { |file| require_relative "../#{file}" }

      # Create a YAML Store
      # @@store = YAML::Store.new('persistance/data.yml')
    end

    def store
      @@store ||= YAML::Store.new('persistance/data.yml')
    end
  end
end