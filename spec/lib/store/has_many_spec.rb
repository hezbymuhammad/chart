require_relative './dummy_model'

RSpec.describe Chart::Store::HasMany do
  before(:each) do
    TestModel.send(:instance_variable_set, :@store, [])
    ModelRelation.send(:instance_variable_set, :@store, [])
  end

  describe 'has_many association' do
    let(:main_model) { TestModel.new(id: 1, name: 'test') }
    let(:another_model) { ModelRelation.new(id: 2, name: 'example') }
    let(:third_model) { ModelRelation.new(id: 3, name: 'another example') }

    it 'allows adding multiple associated models' do
      main_model.multiple_relations << another_model
      main_model.multiple_relations << third_model
      main_model.save

      expect(main_model.multiple_relations).to include(another_model, third_model)
    end

    it 'saves the associated models when added' do
      main_model.multiple_relations << another_model
      main_model.save
      expect(TestModel.select(id: 1).first.multiple_relations).to include(another_model)
    end

    it 'does not add the same instance multiple times' do
      main_model.multiple_relations << another_model
      main_model.multiple_relations << another_model
      main_model.save

      expect(main_model.multiple_relations.size).to eq(1)
    end

    it 'validate instance class before assignment' do
      expect { main_model.multiple_relations << double('Instance 1') }.to raise_error(ArgumentError)
    end
  end
end
