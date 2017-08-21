## Ride it, man.
JSON API for ride fare estimation.

### Estimator.
Estimator calculates estimated ride fare based on tariff,
origin and destination coordinates. It does this using
router.

Estimator is written as a Sinatra app as Sinatra is a
simple and fast ruby micro-framework. Users are faced with
a JSON API which is easy to parse and comprehend.

To run the app use following commands:
```
cd ruby/estimator
bundle install
bundle exec ruby application.rb
```

API usage example:
```
// GET http://localhost:4567/tariffs
{
  "tariffs":[{
    "name":"business",
    "booking":"150.00",
    "per_minute":"15.00",
    "per_km":"38.00",
    "min_fare":"299.00"
  }],
  "currency":"RUB"
}


// GET http://localhost:4568/estimate?origin=55.709876,37.653323&destination=55.804302,37.5835381
{
  "routes":[{
    "map_points":[{
      "lat":55.709876,"long":37.653323
    },{
      "lat":55.804302,"long":37.583538
    }],
    "distance":19934,
    "duration":1511,
    "fare":"1285.24"
  }],
  "tariff":"business",
  "currency":"RUB"
}
```

### Router gem.
Router estimates distance and duration betweed origin and destination.
Router is an adapter for third party routing geo-services.

You can use router as a gem in your ruby application and build adapters for desired
services. But also Router gem can be run as a sinatra application providing adapter
for itself.

To run router as a sinatra application run.

```
cd ruby/router
bundle install
bundle exec ruby application.rb
```

API usage example:

```
// GET http://localhost:4567/estimate?origin=55.709876,37.653323&destination=55.804302,37.5835381
{
  "routes":[{
    "map_points":[{
      "lat":55.709876,"long":37.653323
    },{
      "lat":55.804302,"long":37.583538
    }],
    "distance":19934,
    "duration":1511
  }]
}
```

Estimator uses Router's SelfAdapter to get routing from Router's
sinatra application via HTTP:

```
router = Router.build(adapter: :Self, cache: true)
router.call(
  Router::MapPoint.new(lat: 55.709876, long: 37.653323)
  Router::MapPoint.new(lat: 55.804302, long: 37.583538)
) # => [<#Router::Route @map_points=[...] @distance=19934 @duration=1511>]
```

But it can easily skip HTTP step and use other adapters directly skipping
Router as a microservice:

```
router = Router.build(adapter: :OSM, cache: true)
```

At the moment Router supports only OSM backend and uses it by default.

### OSM backend.
In order to use OSM adapter you need to run osrm service with some actual geodata.

```
mkdir osrm && cd osrm
wget http://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf
docker pull osrm/osrm-backend
docker run -t -v $(pwd):/data osrm/osrm-backend osrm-extract -p /opt/car.lua /data/central-fed-district-latest.osm.pbf
docker run -t -v $(pwd):/data osrm/osrm-backend osrm-contract /data/central-fed-district-latest.osrm
docker run -t -i -p 5000:5000 -v $(pwd):/data osrm/osrm-backend osrm-routed /data/central-fed-district-latest.osrm
```

### TODO.
- TESTS
- Tariff repository.
- Cache hashing algorithm.
- Command line options.
- Edge cases and error handling.
- Golang version of apps and speed comparison.
