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

  has_one :model_relation

  attr_accessor :id, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def save
    self.class.save(self)
  end
end
