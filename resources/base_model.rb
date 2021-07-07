require 'yaml/store'

class BaseModel
  @@id = :id
  @@fields = []
  @@data = PersistanceModel.store

  class << self
    def find

    end

    def all
      @@data.transaction do
        @@data[self.class.to_s.downcase.to_sym]
      end
    end

    def set_id_field(id_field)
      puts 'set id'
      @@id = id_field.to_sym
    end

    def set_fields(*fields)
      puts 'set fields'
      @@fields = fields.flat_map(&:to_s).map(&:to_sym)
    end
  end

  def initialize(params= {})
    @local = Struct.new(*@@fields).new
    @@fields.each do |field|
      #getters
      self.class.send(:define_method, field, proc { @local.send(field) } )
      #setters
      self.class.define_method(setter = "#{field}=") do |value|
        @local.send(setter, value)
      end
    end
    assign(params)
  end

  def save

  end

  def assign(params)
    params.slice(*@@fields).each { |key, value| self.send("#{key}=", value) }
    self
  end

  def destroy

  end
end