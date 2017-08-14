## Ride it, man.

JSON API for ride fare estimation.

### Estimator.
Estimator calculates estimated ride fare based on tariff,
origin and destination coordinates. It does this using
router.

Estimator is written as a Sinatra app as Sinatra is a
simple and fast ruby micro-framework. Users are faced with
a JSON API which is easy to parse and comprehend.

To run the app use simple commands:
```
cd ruby/estimator
ruby application.rb
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


// GET http://localhost:4567/estimate?origin=55.709876,37.653323&destination=55.804302,37.5835381
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

### Router.
Router estimates distance and duration betweed origin and destination.
Router is an adapter for third party routing geo-services.

### TODO.
- Tariff repository.
- Router adapters for OSM and Google distance API.
- Router caching.
- Command line options.
- Edge cases and error handling.
- Make geo-services adapters as a gem.
- Golang version of apps and speed comparison.
