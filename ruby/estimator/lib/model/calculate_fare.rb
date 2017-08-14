module Model
  # Calculate ride fare based on given tariff and route
  module CalculateFare
    def self.call(tariff, route)
      fare = tariff.booking +
             tariff.per_km * route.distance / 1000 +
             tariff.per_minute * route.duration / 60
      tariff.min_fare > fare ? tariff.min_fare : fare
    end

    def self.to_proc
      method(:call).to_proc
    end
  end
end
