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
    def run(&block)
      block_given? ? schedule = @schedule[block.call] : schedule = @schedule
      
      # TODO: If schedule nil then use default?
      follow_schedule(schedule)
    end

    def follow_schedule(schedule)
      period = schedule.current

      sleep(period)
      schedule.next

      period
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