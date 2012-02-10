require 'spec_helper'

describe "Sleeper::Cycle" do
  let (:cycle) { Sleeper::Schedule.new [18, 22243, 274], true }

  describe "#new" do
    it "should initialize @values" do
      cycle.instance_eval { @values }.should == [18, 22243, 274]
    end

    it "should initialize @index to 0" do
      cycle.index.should == 0
    end
  end

  describe "#current" do
    it "should should return value current value" do
      cycle.current.should == 18
    end
  end

  describe "#next" do
    it "should return the next value in the cycle" do
      cycle.next.should == 22243
    end

    it "should return the same value when there is only one" do
      cycle = Sleeper::Schedule.new [18], true

      cycle.next.should == 18
      cycle.next.should == 18
    end

    it "should return subsequent values when there are multiple" do
      cycle.next.should == 22243
      cycle.next.should == 274
    end

    it "should increment the cycle position" do
      cycle.next

      cycle.index.should == 1
    end
  end

  describe "#reset" do
    it "should reset the index to 0" do
      cycle.next
      cycle.reset

      cycle.index.should == 0
    end
  end
end