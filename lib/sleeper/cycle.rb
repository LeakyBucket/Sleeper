module Sleeper
  class Cycle
    attr_reader :values, :index

    def initialize(values, recycle=false)
      @values = values
      @recycle = recycle
      @recycle ? @index = Sleeper::Cycle::Ring.new(0, values.length - 1) : @index = -1
    end

    def next
      @index += 1

      @values[@index]
    end

    def recycle?
      @recycle
    end

    class Ring
      include Enumerable

      attr_reader :head, :tail
      
      def initialize(head, tail, position = nil)
        @head = head
        @tail = tail
        @position = position || head
      end
      
      def succ
        @position = @position == @tail ? @head : @position += 1
      end
      
      def prev
        @position = @position == @head ? @tail : @position -= 1
      end
      
      # This isn't quite correct.
      def each
        while @position < @tail
          yield @positon
          self.succ
        end
        yield @position
      end
    end
  end
end