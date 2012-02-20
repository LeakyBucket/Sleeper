module Sleeper
  # TODO: StateMachine?
  # TODO: Need to be able to add and remove schedules?
  class Timer
    attr_reader :schedule, :default

    # TODO: Behavior here needs to be cleaned up.
    def initialize(schedule, opts={})
      @cyclic = opts[:cyclic] || false
      @default = from_array(opts[:default]) if opts[:default] || nil
      from_hash(schedule) if schedule.class == Hash
      from_array(schedule) if schedule.class == Array
    end

    def run(&block)
      block_given? ? schedule = @schedule[block.call] : schedule = @schedule
      
      raise 'Missing Schedule' if schedule.nil? && @default.nil?

      schedule.nil? ? follow_schedule(@default) : follow_schedule(schedule)
    end

    def follow_schedule(schedule)
      period = schedule.current

      sleep(period)
      schedule.next

      period
    end

    def reset(key=nil)
      return @schedule[key].reset unless key.nil?

      if @schedule.class == Hash
        @schedule.values.each do |schedule|
          schedule.reset
        end
      else
        @schedule.reset
      end
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