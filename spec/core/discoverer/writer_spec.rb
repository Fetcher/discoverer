require 'spec_helper'

describe Core::Discoverer::Writer do
  describe '#has_writer?' do
    context 'this class has in fact a Writer' do 
      before do
        class Klass; extend Core::Discoverer::Writer; end
        module Writer; class Klass; end; end;
      end

      it 'should return true' do
        Klass.should have_writer
      end

      context 'the class is inside modules' do
        before do
          module Moddd; module Blah; class Klass;
              extend Core::Discoverer::Writer
          end; end; end

          module Writer; module Moddd; module Blah; class Klass;
          end; end; end; end
        end

        it 'should return true' do
          Moddd::Blah::Klass.should have_writer
        end
      end
    end

    context 'this class has no Writer' do
      before do; class Klassss; extend Core::Discoverer::Writer; end; end

      it 'should return false' do
        Klassss.should_not have_writer
      end
    end
  end

  describe '#writer' do
    context 'this class has a writer' do
      before do 
        module Modd; class Kless; extend Core::Discoverer::Writer;
        end; end

        module Writer; module Modd; class Kless; end; end; end
      end

      it 'should return the writer class' do 
        Modd::Kless.writer.should == Writer::Modd::Kless
      end
    end

    context 'the superclass has a writer' do
      before do
        module Modd; class Kless; extend Core::Discoverer::Writer;
        end; end

        module Writer; module Modd; class Kless; end; end; end        

        class Kley < Modd::Kless; end
      end

      it 'should return the superclass writer class' do
        Kley.writer.should == Writer::Modd::Kless
      end
    end

    context 'an implemented module has a writer' do
      before do 
        module Modd; module Kluss; extend Core::Discoverer::Writer;
        end; end

        module Writer; module Modd; class Kluss; end; end; end        

        class Kleya; include Modd::Kluss; end
      end

      it 'should return the module writer class' do
        Kleya.writer.should == Writer::Modd::Kluss
      end
    end

    context 'the superclass has a writer and its superclass has one too' do
      before do
        module Modd; class Kloss; extend Core::Discoverer::Writer;
        end; end

        module Writer; module Modd; class Kloss; end; end; end        
        module Writer; module Kleye; end; end

        class Kleye < Modd::Kloss; end

        class Kles < Kleye; end
      end

      it 'should return the superclass\'s writer' do
        Kles.writer.should == Writer::Kleye
      end
    end

    context 'some ancestor does not respond to #writer' do
      it 'should skip over it' do
        module Ances; end
        class Anter; end

        module Writer; class Anter; end; end
        class Hejda < Anter; include Ances; end

        Hejda.writer.should == Writer::Anter
      end
    end

    context 'there is no writer in the hierarchy' do
      before do 
        class Ehh; extend Core::Discoverer::Writer; end
      end

      it 'should return an exception' do 
        expect { Ehh.writer
        }.to raise_error Core::Discoverer::Writer::NotFoundError,
          "There is no writer for Ehh or any of its ancestors"
      end
    end
  end
end