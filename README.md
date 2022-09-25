# Weather Kit

## Prerequisite

### Apple Developer Program

You must be a member of the Apple Developer Program to use this package.

### Bundle ID

You can register and check bundle id from Xcode or [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list).

### Team ID

You can check Team ID from [Membership](https://developer.apple.com/account/#!/membership).

### keyID and p8 certificate for Weather Kit

In order to use the Weather Kit, 

1. Access to [Certificates, Identifiers & Profiles / Keys](https://developer.apple.com/account/resources/authkeys/list)
2. Enter any Key Name in the form and check the Weather Kit checkbox.
3. Tap "register" and you can check Key Id
4. Tap "Download" to get p8 certificate.

<img src="https://user-images.githubusercontent.com/28733986/192140345-58481fb2-eae4-46db-bc03-7c3a97629fbf.gif" width="600"  />

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
## Pricing
First 500,000 calls are free. For more details, check [this](https://developer.apple.com/weatherkit/get-started/).

## References

- https://developer.apple.com/weatherkit/
- https://developer.apple.com/videos/play/wwdc2022/10003/
- https://zenn.dev/bon/articles/weatherkit-restapi
- https://allthecode.co/blog/post/setting-up-weatherkit-rest-api-in-node-js
