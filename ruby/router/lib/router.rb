require 'json'
require 'faraday'
require 'active_support/core_ext/hash'
require 'active_support/cache'
require_relative './router/version'
require_relative './router/map_point'
require_relative './router/route'
require_relative './router/self_adapter'
require_relative './router/osm_adapter'
require_relative './router/cached_adapter'
require_relative './router/api'

module Router
  def self.build(adapter: :OSM, cache: false)
    router =
      case adapter
      when Hash
        adapter_name = adapter.keys.first
        const_get("#{adapter_name}Adapter").new(*adapter[adapter_name])
      when Symbol
        const_get("#{adapter}Adapter").new()
      else
        raise ArgumentError, "Adapter must be a Symbol or Hash"
      end
    if cache
      CachedAdapter.new(router, ActiveSupport::Cache::MemoryStore.new)
    else
      router
    end
  end
end
