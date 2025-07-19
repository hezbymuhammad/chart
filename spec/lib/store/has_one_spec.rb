# frozen_string_literal: true

require_relative './dummy_model'

RSpec.describe Chart::Store::HasOne do
  before(:each) do
    TestModel.send(:instance_variable_set, :@store, [])
    ModelRelation.send(:instance_variable_set, :@store, [])
  end

  describe 'has_one association' do
    let!(:main_model) { TestModel.new(id: 1, name: 'test') }
    let!(:another_model) { ModelRelation.new(id: 2, name: 'example') }

    it 'allows setting and getting the associated model' do
      main_model.model_relation = another_model
      expect(main_model.model_relation).to eq(another_model)
    end

    it 'saves the associated model when set' do
      main_model.model_relation = another_model
      main_model.save

      expect(TestModel.select(id: 1).first.model_relation).to eq(another_model)
    end

    it 'saves the associated model separately' do
      another_model.save
      expect(ModelRelation.all).to include(another_model)
    end

    it 'validate instance class before assignment' do
      expect { main_model.model_relation = double('Instance 1') }.to raise_error(ArgumentError)
    end
  end
end
