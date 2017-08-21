require "test_helper"

class RouteTest < Minitest::Test
  def test_initialize_from_hash
    assert_equal(
      Router::Route.new(
        **{
          map_points: [{ lat: '10.101', long: '20.202' },
                       { lat: '10.101', long: '20.202' }],
          distance: '20',
          duration: '20'
        }
      ),
      Router::Route.new(
        map_points: [Router::MapPoint.new(lat: 10.101, long: 20.202),
                     Router::MapPoint.new(lat: 10.101, long: 20.202)],
        distance: 20,
        duration: 20
      )
    )
  end
end
