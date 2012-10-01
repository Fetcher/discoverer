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

    context 'no adapter exists for the given constante' do
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
  end

  describe '.adapter_for' do
    context 'this class has a adapter_for' do
      it 'should return the adapter class'
    end

    context 'the superclass has a adapter_for' do
      it 'should return the superclass adapter class'
    end

    context 'an implemented module has a adapter_for' do
      it 'should return the module adapter class'
    end

    context 'the superclass has a adapter_for and its superclass has one too' do
      it 'should return the superclass\'s adapter'
    end

    context 'some ancestor does not respond to #adapter_for' do
      it 'should skip over it'
    end

    context 'there is no adapter_for in the hierarchy' do
      it 'should return an exception'
    end
  end
end