require 'spec_helper'

describe Core::Discoverer do
  describe '.has_adapter_for?' do
    context 'an adapter exists matching the given constant and class' do
      it 'should return true' do
        module SomeAdaptation; class Klass; end; end

        class Klass; end

        Core::Discoverer.has_adapter_for?(SomeAdaptation, Klass).should == true
      end
    end

    context 'no adapter exists for the given constant' do
      it 'should return false' do
        module SomeAdaptation; end
        module Ja; class Kle; end; end

        Core::Discoverer.has_adapter_for?(SomeAdaptation, Ja::Kle).should == false
      end
    end

    context 'the constant does not exist' do
      it 'should raise a relevant error' do 
        expect { Core::Discoverer.has_adapter_for? DoesNotExist, Object
          }.to raise_error NameError
      end
    end

    context 'the class has not name' do
      it 'should return false' do
        module SomeAdaptation; end

        not_name = stub 'not name'
        not_name.should_receive(:name).and_return nil
        Core::Discoverer.has_adapter_for?(SomeAdaptation, not_name).should == false
      end
    end
  end

  describe '.for' do
    context 'this class has an adapter for the constant' do
      before do 
        module Some; class End; end; end
        class End; end
      end

      it 'should return the adapter class' do
        Core::Discoverer.for( Some, End ).should == Some::End
      end
    end

    context 'the superclass has a adapter_for' do
      before do 
        module Some1; class Super1; end; end

        class Super1; end
        class End1 < Super1; end
      end

      it 'should return the superclass adapter class' do
        Core::Discoverer.for( Some1, End1 ).should == Some1::Super1
      end
    end

    context 'an implemented module has a adapter_for' do
      before do 
        module Some2; class Module1; end; end
        module Module1; end

        class End2; include Module1; end
      end

      it 'should return the module adapter class' do
        Core::Discoverer.for( Some2, End2 ).should == Some2::Module1
      end
    end

    context 'the superclass has a adapter_for and its superclass has one too' do
      before do
        module Some3; class Super2; end; end
        module Some3; class Super3; end; end

        class Super2; end
        class Super3 < Super2; end 
        class End3 < Super3; end
      end

      it 'should return the superclass\'s adapter' do
        Core::Discoverer.for( Some3, End3 ).should == Some3::Super3
      end
    end

    # I keep it here for a memento, and a good laught:
    # Remember, remember the errors and bad practices that stem from going
    # halfway in abstraction of implementation
    context 'some ancestor does not have an adapter' do
      before do
        module Some5; class Super5; end; end
        class Super5; end
        module Module3; end
        class End5 < Super5; include Module3; end
      end

      it 'should skip over it' do
        Core::Discoverer.for( Some5, End5 ).should == Some5::Super5
      end
    end

    context 'there is no adapter for the class in the hierarchy' do
      before do
        module Some4; end
        class End4; end
      end

      it 'should return an exception' do
        expect { Core::Discoverer.for Some4, End4 
          }.to raise_error Core::Discoverer::NotFoundError, 
            "There is no some4 for End4 or any of its ancestors"
      end
    end
  end
end