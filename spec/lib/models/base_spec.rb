# frozen_string_literal: true

class TestModel < Chart::Models::Base
  attr_accessor :id, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
  end
end

RSpec.describe Chart::Models::Base do
  before(:each) do
    TestModel.send(:instance_variable_set, :@store, [])
  end

  describe '.store' do
    it 'initializes the store as an empty array' do
      expect(TestModel.store).to eq([])
    end
  end

  describe '#save' do
    it 'saves an instance to the store' do
      instance = TestModel.new(id: 1, name: 'test')
      instance.save

      expect(TestModel.store).to include(instance)
    end
  end

  describe '.find' do
    it 'finds instances by attributes' do
      instance1 = TestModel.new(id: 1, name: 'test')
      instance2 = TestModel.new(id: 2, name: 'example')

      instance1.save
      instance2.save

      found = TestModel.select(id: 1)
      expect(found).to contain_exactly(instance1)

      found = TestModel.select(id: 2)
      expect(found).to contain_exactly(instance2)
    end

    it 'returns an empty array if no instances match' do
      instance1 = TestModel.new(id: 1, name: 'test')
      instance1.save

      found = TestModel.select(id: 2)
      expect(found).to be_empty
    end
  end
end
