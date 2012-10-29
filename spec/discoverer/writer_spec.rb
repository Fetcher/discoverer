# encoding: utf-8
require 'spec_helper'

describe Discoverer::Writer do
  describe "#to" do
    before do
      module Writer
        class TestClass
        end
      end
      class TestClass
        include Discoverer::Writer
      end
    end

    context "when the methos is call" do
      it "should try to instance the class reader with self(actual class that call the methos)" do

        Writer::TestClass.should_receive :new

        obj = TestClass.new
        obj.to
      end

      it "should pass as argument self" do
        obj = TestClass.new
        Writer::TestClass.should_receive(:new).with(obj)
        obj.to
      end

      it "should retrive the same writer if it's called twice" do
        writer = stub "writer"
        aux = TestClass.new

        Writer::TestClass.should_receive(:new).with(aux).and_return(writer)

        aux.to.should eq writer
        aux.to.should eq writer

      end
    end

    context "for a subclass" do
      it "should work at once, provided the implementation of the pattern is done" do
        module Writer
          class UserW
          end
        end

        class UserW < TestClass
        end

        obj = UserW.new
        Writer::UserW.should_receive( :new ).with obj
        obj.to
      end
    end


    context "there is no writer" do
      it "should fail with a friendly error" do
        class Fail
          include Discoverer::Writer
        end

        obj = Fail.new
        expect { 
          obj.to
        }.to raise_error Discoverer::Writer::MissingWriterError,
          "The writer for Fail (Writer::Fail) wasn't found, please create it"
         
      end
    end



  end  
end