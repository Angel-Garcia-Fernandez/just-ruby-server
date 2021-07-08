require 'yaml/store'

class PersistenceModel
  class << self
    def start
      # Load all model classes
      Dir['app/models/*.rb'].each { |file| require_relative "../#{file}" }
    end
  end

  def initialize(model, id_field = :id)
    @model = model
    @id = id_field
  end

  def all
    store.transaction do
      _all || []
    end
  end

  def save(params)
    store.transaction do
      id = params[@id]
      obj = _find(id)
      if obj
        _delete(id)
      end
      _all << params
      _find(id)
    end
    true
  end

  def find(id)
    store.transaction do
      _find(id)
    end
  end

  def delete(id)
    store.transaction do
      _delete(id)
    end
  end

  private

  attr_reader :model

  def _all
    store[model.to_sym]
  end

  def _find(id)
    store[model.to_sym].detect { |object| object[@id].to_s === id.to_s }
  end

  def _delete(id)
    obj = _find(id)
    _all.delete(obj)
  end

  def store
    @store ||= YAML::Store.new('persistance/data.yml')
  end
end