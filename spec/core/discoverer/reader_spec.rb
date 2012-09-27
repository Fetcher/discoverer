require 'spec_helper'

describe Core::Discoverer::Reader do
  describe '#has_reader?' do
    context 'this class has in fact a Reader' do 
      before do
        class Klass; extend Core::Discoverer::Reader; end
        module Reader; class Klass; end; end;
      end

      it 'should return true' do
        Klass.should have_reader
      end

      context 'the class is inside modules' do
        before do
          module Moddd; module Blah; class Klass;
              extend Core::Discoverer::Reader
          end; end; end

          module Reader; module Moddd; module Blah; class Klass;
          end; end; end; end
        end

        it 'should return true' do
          Moddd::Blah::Klass.should have_reader
        end
      end
    end

    context 'this class has no Reader' do
      before do; class Klassss; extend Core::Discoverer::Reader; end; end

      it 'should return false' do
        Klassss.should_not have_reader
      end
    end
  end

  describe '#reader' do
    context 'this class has a reader' do
      before do 
        module Modd; class Kless; extend Core::Discoverer::Reader;
        end; end

        module Reader; module Modd; class Kless; end; end; end
      end

      it 'should return the reader class' do 
        Modd::Kless.reader.should == Reader::Modd::Kless
      end
    end

    context 'the superclass has a reader' do
      before do
        module Modd; class Kless; extend Core::Discoverer::Reader;
        end; end

        module Reader; module Modd; class Kless; end; end; end        

        class Kley < Modd::Kless; end
      end

      it 'should return the superclass reader class' do
        Kley.reader.should == Reader::Modd::Kless
      end
    end

    context 'an implemented module has a reader' do
      before do 
        module Modd; module Kluss; extend Core::Discoverer::Reader;
        end; end

        module Reader; module Modd; class Kluss; end; end; end        

        class Kleya; include Modd::Kluss; end
      end

      it 'should return the module reader class' do
        Kleya.reader.should == Reader::Modd::Kluss
      end
    end

    context 'the superclass has a reader and its superclass has one too' do
      before do
        module Modd; class Kloss; extend Core::Discoverer::Reader;
        end; end

        module Reader; module Modd; class Kloss; end; end; end        
        module Reader; module Kleye; end; end

        class Kleye < Modd::Kloss; end

        class Kles < Kleye; end
      end

      it 'should return the superclass\'s reader' do
        Kles.reader.should == Reader::Kleye
      end
    end

    context 'some ancestor does not respond to #reader' do
      it 'should skip over it' do
        module Ances; end
        class Anter; end

        module Reader; class Anter; end; end
        class Hejda < Anter; include Ances; end

        Hejda.reader.should == Reader::Anter
      end
    end

    context 'there is no reader in the hierarchy' do
      before do 
        class Ehh; extend Core::Discoverer::Reader; end
      end

      it 'should return an exception' do 
        expect { Ehh.reader
        }.to raise_error Core::Discoverer::Reader::NotFoundError,
          "There is no reader for Ehh or any of its ancestors"
      end
    end
  end
end