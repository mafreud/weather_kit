# Weather Kit

## Prerequisite

### Apple Developer Program

このパッケージを使用するためには、Apple Developer Program に加入している必要があります。

### Bundle ID

Xcode もしくは [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list) から bundle Id を登録してください。

### Team ID

[Membership](https://developer.apple.com/account/#!/membership)から確認してください。

### keyID and p8 certificate for Weather Kit

Weather Kit を使用するためには、

1. [Certificates, Identifiers & Profiles / Keys](https://developer.apple.com/account/resources/authkeys/list) へアクセス
2. 任意の Key Name をフォームに入力し、Register a New Key で Weather Kit にチェックボックスを入れます。
3. その後、登録をし、p8 証明書をダウンロードします。

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
