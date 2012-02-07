require 'spec_helper'

describe "Sleeper::Cycle" do
  let (:cycle) { Sleeper::Cycle.new [18, 22243, 274] }

  describe "#new" do
    it "should initialize @values" do
      cycle.values.should == [18, 22243, 274]
    end

    it "should initialize @index to 0" do
      cycle.index.should == -1
    end
  end

  describe "#next" do
    it "should return the next value in the cycle" do
      cycle.next.should == 18
    end

    it "should increment the cycle position" do
      cycle.next

      cycle.index.should == 0
    end
  end

  describe "#recycle?" do
    it "should return true if the values should be looped over" do
      cycle = Sleeper::Cycle.new [8], true

      cycle.recycle?.should be_true
    end

    it "should return false if the values shouldn't be looped over" do
      cycle.recycle?.should be_false
    end
  end

  describe "#reset" do
    it "should description" do
      
    end
  end
end