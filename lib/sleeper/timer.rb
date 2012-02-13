module Sleeper
  # TODO: Need to figure out how to handle keyed vs non-keyed schedules
  class Timer
    attr_reader :schedule

    def initialize(schedule, cyclic=false)
      @cyclic = cyclic
      hash_sched(schedule) if schedule.class == Hash
      array_sched(schedule) if schedule.class == Array
    end


    private

    def hash_sched(schedule)
      @schedule = {}

      schedule.each_pair do |key, values|
        @schedule[key] = Schedule.new values, @cyclic
      end
    end

    def array_sched(schedule)
      @schedule = Schedule.new schedule, @cyclic
    end
  end
end