require 'spec_helper'

describe Class do
  it 'should include Core::Discoverer::Reader' do
    Class.ancestors.should include Core::Discoverer::Reader
  end

  it 'should include Core::Discoverer::Writer' do 
    Class.ancestors.should include Core::Discoverer::Writer
  end
end