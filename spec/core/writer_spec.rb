# encoding: utf-8
require 'spec_helper'

describe Core::Writer do
  describe "#from" do
    context "when the methos is call" do
      before do
        module Writer
          class TestClass
          end
        end
        class TestClass
          include Core::Writer
        end
      end
      it "should try to instance the class reader with self(actual class that call the methos)" do

        Writer::TestClass.should_receive :new

        obj = TestClass.new
        obj.from
      end

      it "should pass as argument self" do
        obj = TestClass.new
        Writer::TestClass.should_receive(:new).with(obj)
        obj.from
      end

    end
  end
  
end