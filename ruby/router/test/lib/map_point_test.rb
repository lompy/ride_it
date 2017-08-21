require "test_helper"

class MapPointTest < Minitest::Test
  def test_to_h
    assert_equal(
      Router::MapPoint.new(lat: '10.101', long: '20.202').to_h,
      lat: 10.101, long: 20.202
    )
  end

  def test_use_as_argument_for_initializer
    mp = Router::MapPoint.new(lat: '10.101', long: '20.202')
    assert_equal(mp, Router::MapPoint.new(**mp))
  end

  def test_dump_to_json
    mp = Router::MapPoint.new(lat: '10.101', long: '20.202')
    assert_equal(JSON.dump(mp.to_h), '{"lat":10.101,"long":20.202}')
  end
end
