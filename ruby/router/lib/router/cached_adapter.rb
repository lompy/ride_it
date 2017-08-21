module Router
  class CachedAdapter
    def initialize(adapter, cache)
      @cache = cache
      @adapter = adapter
    end

    def call(origin, destination)
      @cache.fetch(key(origin, destination)) do
        @adapter.call(origin, destination)
      end
    end

    private

    def key(origin, destination)
      # TODO: Implement hashing algo with given precision, not exact values.
      "#{origin.lat},#{origin.long};#{destination.lat},#{destination.long}"
    end
  end
end
