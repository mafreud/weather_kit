# Weather Kit

## Usage

To use this plugin, add `weather_kit` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

### Examples

Here are small examples that show you how to use the API.

#### Generate JWT

```dart
final weatherKit = WeatherKit();
final token = weatherKit.generateJWT(
  bundleId: 'com.example',
  teamId: 'team id',
  keyId: 'key id',
  pem: 'example.p8',
  expiresIn: const Duration(hours: 1),
);
```

#### Obtain current weather

```dart
final result = await weatherKit.obtainWeatherData(
  jwt: token,
  language: 'ja',
  latitude: '35.71',
  longitude: '139.811',
  dataSets: 'currentWeather',
);
```

## References

https://zenn.dev/bon/articles/weatherkit-restapi

https://allthecode.co/blog/post/setting-up-weatherkit-rest-api-in-node-js
