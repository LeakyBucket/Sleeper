module Sleeper
  # TODO: StateMachine?
  # TODO: Need to be able to add and remove schedules?
  class Timer
    attr_reader :schedule, :default

    def initialize(schedule, opts={})
      @cyclic = opts[:cyclic] || false
      @default = opts[:default] || nil
      from_hash(schedule) if schedule.class == Hash
      from_array(schedule) if schedule.class == Array
    end

    # TODO: Should raise exception if @schedule[key] is nil or use default value
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
      # TODO: Currently returning next value.  That should be changed to be the value slept for.
    end

    # TODO: Hash reset should be separate method and should handle entire hash or specific keys.
    def reset(key=nil)
      key.nil? ? @schedule.reset : @schedule[key].reset
    end

    def default=(value)
      value.nil? ? @default = nil : @default = Schedule.new(Array(value), @cyclic)
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