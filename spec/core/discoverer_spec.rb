require 'spec_helper'

describe Core::Discoverer do
  describe '.has_adapter_for?' do
    context 'an adapter exists matching the given constant and class' do
      it 'should return true' do
        module SomeAdaptation; class Klass; end; end

        class Klass; end

        Core::Discoverer.has_adapter_for? SomeAdaptation
      end
    end

    context 'no adapter exists for the given constante' do
      it 'should return false'
    end
  end
end