require 'spec_helper'

describe 'Sleeper::Schedule' do
  let (:schedule) { Sleeper::Schedule.new [32, 68, 74] }

  describe "#new" do
    it "should set the schedule"
  end

  describe "#hash_sched" do
    it "should convert a hash to a schedule"
  end

  describe "#array_sched" do
    it "should convert an array of integers to a sequencial hash" do
      schedule.send(:array_sched, [32, 33353, 675]).should == { 0 => 32, 1 => 33353, 2 => 675}
    end

    it "should convert an array of pairs into a key/value hash" do
      schedule.send(:array_sched, [["puffy", 3455], ["cat", 3776], [8, 67675]]).should == { "puffy" => 3455, "cat" => 3776, 8 => 67675 }
    end
  end
end