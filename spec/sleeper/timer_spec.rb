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

  describe "#hash_sched" do
    it "should convert a hash to a schedule" do
      schedule.send(:hash_sched, { bob: [8, 12, 445], "no" => [22, 33, 44], 8 => [3838, 47475, 3734] })

      schedule.instance_eval { @schedule }.each_pair do |key, values|
        values.should be_a Sleeper::Schedule
      end
    end
  end

  describe "#array_sched" do
    it "should convert an array of integers to a sequencial hash" do
      schedule.send(:array_sched, [32, 33353, 675])

      schedule.instance_eval { @schedule }.should be_a Sleeper::Schedule
    end
  end
end