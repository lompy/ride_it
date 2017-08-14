module Model
  # A struct describing a tariff with a particular name
  class Tariff
    attr_reader :name, :booking, :per_minute, :per_km, :min_fare
    def initialize(name, booking:, per_minute:, per_km:, min_fare:)
      @name = name.to_s
      @booking = Money.new(booking)
      @per_minute = Money.new(per_minute)
      @per_km = Money.new(per_km)
      @min_fare = Money.new(min_fare)
      freeze
    end

    def to_h
      {
        name: name,
        booking: Model.format_money(booking),
        per_minute: Model.format_money(per_minute),
        per_km: Model.format_money(per_km),
        min_fare: Model.format_money(min_fare)
      }
    end
  end
end
