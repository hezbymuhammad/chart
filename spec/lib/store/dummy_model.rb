# frozen_string_literal: true

class ModelRelation
  extend Chart::Store::Base

  attr_accessor :id, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def save
    self.class.save(self)
  end
end

class TestModel
  extend Chart::Store::Base
  extend Chart::Store::HasOne
  extend Chart::Store::HasMany

  has_one :model_relation
  has_many :multiple_relations

  attr_accessor :id, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def save
    self.class.save(self)
  end
end
