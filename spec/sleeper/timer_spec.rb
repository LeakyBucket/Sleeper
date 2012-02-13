require 'spec_helper'

describe 'Sleeper::Timer' do
  let (:schedule) { Sleeper::Timer.new [32, 68, 74] }
  let (:conditional) { { bob: [8, 12, 445], "no" => [22, 33, 44], 8 => [3838, 47475, 3734] } }

  describe "#new" do
    it "should set the schedule when given a hash" do
      timer = Sleeper::Timer.new conditional

      timer.instance_eval { @schedule }.each_pair do |key, values|
        values.should be_a Sleeper::Schedule
      end
    end

    it "should set the schedule when given an array" do
      schedule.instance_eval { @schedule }.should be_a Sleeper::Schedule
    end
  end

  describe "#start" do
    it "should initiate the sleep schedule"
  end

  describe "#reset" do
    it "should reset the schedule to the beginning if the schedule is not a hash"

    it "should reset the condition to the beginning if the schedule is a hash"
  end

  describe "#from_hash" do
    it "should convert a hash to a schedule" do
      schedule.send(:from_hash, { bob: [8, 12, 445], "no" => [22, 33, 44], 8 => [3838, 47475, 3734] })

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