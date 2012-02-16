module Sleeper
  # TODO: StateMachine?
  class Timer
    attr_reader :schedule

    def initialize(schedule, cyclic=false)
      @cyclic = cyclic
      from_hash(schedule) if schedule.class == Hash
      from_array(schedule) if schedule.class == Array
    end

    # TODO: Should raise exception if @schedule[key] is nil
    # TODO: Need two separate method calls here for block or no block
    def run(&block)
      if block_given?
        key = block.call
        sleep(@schedule[key].current)
        @schedule[key].next
      else
        sleep(@schedule.current)
        @schedule.next
      end
      # TODO: Currently returning next value.  That should be changed.
    end

    def reset(key=nil)
      key.nil? ?  @schedule.reset : @schedule[key].reset
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