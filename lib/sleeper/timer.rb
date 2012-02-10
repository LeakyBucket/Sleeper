module Sleeper
  # TODO: Need to figure out how to handle keyed vs non-keyed schedules
  class Timer
    attr_reader :schedule, :pos

    def initialize(schedule, cyclic=false)
      
    end


    private

    def hash_sched(schedule)
      
    end

    def array_sched(schedule)
      x = 0

      schedule.inject({}) do |schedule, value|
        if value.respond_to? :length
          value.length > 1 ? schedule[value[0]] = value[1..-1] : schedule[x] = value
        else
          schedule[x] = value
        end

        x += 1

        schedule
      end
    end
  end
end