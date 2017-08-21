require 'test_helper'

class APITest < Minitest::Test
  class DummyRouter
    def call(origin, destination)
      Model::Route.new([origin, destination], distance: 20, duration: 40)
    end
  end

  def setup
    @tariff = Model::Tariff.new(
      'business',
      booking: 150_00,
      per_minute: 15_00,
      per_km: 38_00,
      min_fare: 300_00
    )
    @api = API.new(@tariff, DummyRouter.new)
  end

  def test_estimate
    assert_equal(
      {
        routes: [
          {
            map_points: [
              { lat: 58.553715, long: 50.042356 },
              { lat: 58.541959, long: 50.040983 }
            ],
            distance: 20,
            duration: 40,
            fare: '300.00'
          }
        ],
        tariff: 'business',
        currency: 'RUB'
      },
      @api.estimate(
        'tariff' => 'business',
        'origin' => '58.553715,50.042356',
        'destination' => '58.541959,50.040983'
      )
    )
  end

  def test_tariffs
    assert_equal(
      {
        tariffs: [{
          name: 'business',
          booking: '150.00',
          per_minute: '15.00',
          per_km: '38.00',
          min_fare: '300.00'
        }],
        currency: 'RUB'
      },
      @api.tariffs
    )
  end
end
