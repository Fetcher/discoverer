require 'spec_helper'

describe Discoverer::Pattern do 
  describe '#initialize' do 
    it 'should set the source' do 
      source = double 'source'
      pattern = Discoverer::Pattern.new source
      pattern.source.should == source
    end
  end
end