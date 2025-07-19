# frozen_string_literal: true

require_relative 'dummy_model'

RSpec.describe Chart::Store::Base do
  before(:each) do
    TestModel.send(:instance_variable_set, :@store, [])
    ModelRelation.send(:instance_variable_set, :@store, [])
  end

  describe '.store' do
    it 'initializes the store as an empty array' do
      expect(TestModel.store).to eq([])
    end
  end

  describe '.save' do
    it 'saves an instance to the store' do
      instance = double('Instance')
      TestModel.save(instance)

      expect(TestModel.store).to include(instance)
    end
  end

  describe '.all' do
    it 'returns all saved instances' do
      instance1 = double('Instance 1')
      instance2 = double('Instance 2')

      TestModel.save(instance1)
      TestModel.save(instance2)

      expect(TestModel.all).to contain_exactly(instance1, instance2)
    end
  end

  describe '.reset' do
    it 'returns all saved instances' do
      instance1 = double('Instance 1')
      instance2 = double('Instance 2')

      TestModel.save(instance1)
      TestModel.save(instance2)
      TestModel.reset

      expect(TestModel.all).to be_empty
    end
  end

  describe '.select' do
    it 'finds instances by attributes and returns a subset' do
      instance1 = TestModel.new(id: 1, name: 'test')
      instance2 = TestModel.new(id: 2, name: 'example')

      instance1.save
      instance2.save

      found = TestModel.select(id: 1, name: 'test')
      expect(found).to contain_exactly(instance1)

      found = TestModel.select(id: 2)
      expect(found).to contain_exactly(instance2)
    end

    it 'finds instances with has one association' do
      model_relation = ModelRelation.new(id: 2, name: 'example')
      model_relation.save

      instance = TestModel.new(id: 1, name: 'test')
      instance.model_relation = model_relation
      instance.save

      found = TestModel.select(id: 1)
      expect(found).to contain_exactly(instance)
      expect(found.first.model_relation).to eq(model_relation)
    end

    it 'returns an empty array if no instances match' do
      instance1 = TestModel.new(id: 1, name: 'test')
      instance1.save

      found = TestModel.select(id: 2)
      expect(found).to be_empty
    end
  end
end
