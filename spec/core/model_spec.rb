require 'spec_helper'

describe Core::Model do 
  it 'should include Core::Reader' do
    Core::Model.ancestors.should include Core::Reader
  end

  it 'should include Core::Writer' do
    Core::Model.ancestors.should include Core::Writer
  end

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
            Core::Model.any_instance.should_receive(:from).and_return stub(:default => nil)
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

  describe '#initialize' do
    before do
      module Core
        class Model
          attribute :my_attr
          attribute :other_attr
        end
      end
    end

    context 'we have an extra attribute' do 
      context 'no argument is passed' do
        it 'should return a new instance with no attributes set' do
          mod = Core::Model.new
          mod.attributes!.should be_empty
        end

        it 'should not call the reader #from' do
          Core::Model.any_instance.should_not_receive :from
          Core::Model.new
        end
      end

      context 'a Hash with _id key is passed' do
        it 'should return a new instance with the attributes set' do
          mod = Core::Model.new :_id => "lala", :my_attr => "2354"
          mod._id.should == "lala"
          mod.my_attr.should == "2354"
        end

        it 'should not call the reader #from' do
          Core::Model.any_instance.should_not_receive :from
          Core::Model.new :_id => "lala", :my_attr => "2354"
        end
      end

      context 'a Hash without _id key is passed' do
        it 'should return a new instance with the attributes set' do
          reader = stub 'reader'
          Core::Model.any_instance.should_receive(:from).and_return reader
          reader.should_receive :default
          mod = Core::Model.new :my_attr => "345345"
          mod.my_attr.should == "345345"
        end

        it 'should call the reader #from and send the method #default' do
          reader = stub 'reader'
          Core::Model.any_instance.should_receive(:from).and_return reader
          reader.should_receive :default
          Core::Model.new :my_attr => "234"
        end
      end
    end
  end
end