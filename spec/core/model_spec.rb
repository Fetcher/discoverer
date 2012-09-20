require 'spec_helper'

describe Core::Model do 
  it 'should include Virtus' do 
    Core::Model.ancestors.should include Virtus
  end

  it 'should include the attribute _id' do 
    flag = false
    Core::Model.attribute_set.each do |attribute|
      flag = true if attribute.name == :_id
    end
    flag.should === true
  end

  describe '#attributes!' do 
    context 'we have another attribute' do
      before do
        module Core
          class Model
            attribute :my_attr
          end
        end
      end

      context 'no attribute is set' do
        it 'should return and empty hash' do 
          model = Core::Model.new {}
          model.attributes!.should == {}
        end
      end

      context 'only one attribute is set' 

      context 'both attributes are set'
    end
  end
end