require 'yaml/store'

class BaseModel
  @@id = :id
  @@fields = []

  class << self
    def find(id)
      obj = persistence.find(id)
      new(obj) if obj
    end

    def all
      persistence.all.map { |obj| new(obj) }
    end

    def set_id_field(id_field)
      @@id = id_field.to_sym
    end

    def set_fields(*fields)
      @@fields = fields.flat_map(&:to_s).map(&:to_sym)
    end

    def modelname
      self.to_s.downcase
    end

    private

    def persistence
      @persistance ||= PersistenceModel.new(modelname, @@id)
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
    persistence.save(attributes)
  end

  def assign(params)
    params.slice(*@@fields).each { |key, value| self.send("#{key}=", value) }
    self
  end

  def destroy
    persistence.delete(send(@@id))
  end

  def attributes
    @@fields.reduce({}) { |hash, field| hash[field] = self.send(field); hash }
  end

  def modelname
    self.class.to_s.downcase
  end

  private

  def persistence
    @persistence ||= PersistenceModel.new(modelname, @@id)
  end
end