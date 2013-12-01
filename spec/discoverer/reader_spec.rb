# encoding: utf-8
require 'spec_helper'

describe Discoverer::Reader do
  describe "#from" do
    context "para la clase Klass" do
      it "should instance the class Reader::Klass" do
        module Reader
          class Klass
          end
        end

        Reader::Klass.should_receive :new

        class Klass
          include Discoverer::Reader
        end

        obj = Klass.new
        obj.from
      end

      it "should pass the currect object as argument" do
        module Reader
          class Klass
          end
        end

        class ::Klass
          include Discoverer::Reader
        end

        obj = ::Klass.new

        Reader::Klass.should_receive( :new ).with obj

        obj.from
      end

      it "should return the same reader if its called twice" do
        module Reader
          class Klass
          end
        end

        class ::Klass
          include Discoverer::Reader
        end

        obj = ::Klass.new

        reader = double 'reader'
        Reader::Klass.should_receive( :new ).with( obj ).and_return reader

        obj.from.should === reader
        obj.from.should === reader
      end
    end

    context "for a subclass" do
      it "should simply work, provided the pattern is right" do
        module Reader
          class UserR
          end
        end

        class Model
          include Discoverer::Reader
        end

        class UserR < Model
        end
        obj = UserR.new
        Reader::UserR.should_receive( :new ).with obj
        obj.from
      end
    end

    context "there is a reader" do
      it 'should fail with a descriptive error' do
        class Ponele
          include Discoverer::Reader
        end

        obj = Ponele.new
        expect { obj.from
        }.to raise_error Discoverer::Reader::MissingReaderError,
          "The reader for Ponele (Reader::Ponele) wasn't found, please create it"
      end
    end
  end
end