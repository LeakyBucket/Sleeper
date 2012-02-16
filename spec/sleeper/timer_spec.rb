require 'spec_helper'

describe 'Sleeper::Timer' do
  let (:schedule) { Sleeper::Timer.new [32, 68, 74] }
  let (:conditional) { { bob: [8, 12, 445], "no" => [22, 33, 44], 8 => [3838, 47475, 3734] } }

  # TODO: Need more test cases, single value schedules etc...
  describe "#new" do
    it "should set the schedule when given a hash" do
      timer = Sleeper::Timer.new conditional

      timer.instance_eval { @schedule }.should be_a Hash

      timer.instance_eval { @schedule }.each_pair do |key, values|
        values.should be_a Sleeper::Schedule
      end
    end

    it "should set the schedule when given an array" do
      schedule.instance_eval { @schedule }.should be_a Sleeper::Schedule
    end
  end

  describe "#run" do
    it "should sleep for the \"next\" time interval if non-conditional" do
      schedule.run
      time = Time.now

      schedule.run

      (Time.now - time).to_i.should == schedule.instance_eval { @schedule.last }
    end

    it "should sleep for the \"next\" appropriate time interval if conditional" do
      timer = Sleeper::Timer.new conditional
      time = Time.now

      timer.run { :bob }

      (Time.now - time).to_i.should == timer.instance_eval { @schedule[:bob].last }
    end
  end

  describe "#reset" do
    it "should reset the schedule to the beginning if the schedule is not a hash" do
      schedule.reset

      schedule.instance_eval { @schedule.index }.should == 0
    end

    it "should reset the condition to the beginning if the schedule is a hash" do
      timer = Sleeper::Timer.new conditional
      timer.run { :bob }
      timer.reset(:bob)

      timer.instance_eval { @schedule[:bob].index }.should == 0
    end
  end

  describe "#default=" do
    it "should set a schedule if given an array" do
      schedule.default = [0, 12, 33]

      schedule.default.should be_a Sleeper::Schedule
    end

    it "should set a schedule if given a single value" do
      schedule.default = 8

      schedule.default.should be_a Sleeper::Schedule
    end

    it "should set @default to nil if given nil" do
      schedule.default = 8
      schedule.default = nil

      schedule.default.should be_nil
    end
  end

  describe "#from_hash" do
    it "should convert a hash to a schedule" do
      schedule.send(:from_hash, conditional)

      schedule.instance_eval { @schedule }.each_pair do |key, values|
        values.should be_a Sleeper::Schedule
      end
    end
  end

  describe "#from_array" do
    it "should convert an array of integers to a sequencial hash" do
      schedule.send(:from_array, [32, 33353, 675])

      schedule.instance_eval { @schedule }.should be_a Sleeper::Schedule
    end
  end
end