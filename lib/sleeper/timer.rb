module Sleeper
  # TODO: Need to figure out how to handle keyed vs non-keyed schedules
  class Timer
    attr_reader :schedule

    def initialize(schedule, cyclic=false)
      @cyclic = cyclic
      from_hash(schedule) if schedule.class == Hash
      from_array(schedule) if schedule.class == Array
    end



    private

    def from_hash(schedule)
      @schedule = {}

      schedule.each_pair do |key, values|
        @schedule[key] = Schedule.new values, @cyclic
      end
    end

    def from_array(schedule)
      @schedule = Schedule.new schedule, @cyclic
    end
  end
end