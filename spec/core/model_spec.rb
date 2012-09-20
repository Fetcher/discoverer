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
        it 'should return an empty hash' do 
          model = Core::Model.new {}
          model.attributes!.should == {}
        end
      end

      context 'only one attribute is set' do
        context 'my_attr was set' do
          it 'should return the attribute that was set' do 
            model = Core::Model.new :my_attr => "value"
            model.attributes!.should == { :my_attr => "value" }
          end
        end

        context '_id was set' do
          it 'should return the attribute that was set' do 
            model = Core::Model.new :_id => "value"
            model.attributes!.should == { :_id => "value" }
          end
        end
      end

      context 'both attributes are set' do
        it 'should return both attributes' do
          model = Core::Model.new :my_attr => 'value', :_id => "123456"
          model.attributes!.should == { :_id => '123456', :my_attr => 'value' }
        end
      end
    end
  end
end