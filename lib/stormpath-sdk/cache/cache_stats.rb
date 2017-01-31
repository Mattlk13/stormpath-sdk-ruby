module Stormpath
  module Cache
    class CacheStats
      attr_accessor :puts, :hits, :misses, :expirations, :size

      def initialize
        @puts = @hits = @misses = @expirations = @size = 0
      end

      def put
        @puts += 1
        @size += 1
      end

      def hit
        @hits += 1
      end

      def miss(expired = false)
        @misses += 1
        @expirations += 1 if expired
      end

      def delete
        @size -= 1 if @size > 0
      end

      def summary
        [@puts, @hits, @misses, @expirations, @size]
      end
    end
  end
end
