module Sleeper
  class Schedule
    def initialize(values, recycle=false)
      @values = values
      @index = LoopableRange.new(0, values.length - 1, cyclic: recycle)
    end

    def next
      @values[@index.succ]
    end

    def current
      @values[index]
    end

    def last
      index == 0 ? prev = 0 : prev = index - 1

      @values[prev]
    end

    def index
      @index.position
    end

    def reset
      @index.reset
    end

    class LoopableRange
      include Enumerable

      attr_reader :position

      def initialize(start, finish, opts={})
        @start = start
        @finish = finish
        @cyclic = opts[:cyclic] || false
        @position = opts[:position] || start
      end
      
      def succ
        if cyclic?
          @position = @position == @finish ? @start : @position += 1
        else
          @position = @position == @finish ? @finish : @position += 1
        end
      end

      def prev
        if cyclic?
          @position = @position == @start ? @finish : @position -= 1
        else
          @position = @position == @start ? @start : @position -= 1
        end
      end

      def cyclic?
        @cyclic
      end

      def reset
        @position = @start
      end

      # This isn't quite correct.
      def each
        @position = @start

        while @position < @finish
          yield @positon
          self.succ
        end

        yield @position
      end
    end
  end
end