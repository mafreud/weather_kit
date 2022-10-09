import 'package:flutter/material.dart';
import 'package:weather_kit/weather_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Kit DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather kit demo'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              const pem = """
-----BEGIN PRIVATE KEY-----
test
-----END PRIVATE KEY-----
""";
              final weatherKit = WeatherKit();
              final jwt = weatherKit.generateJWT(
                bundleId: 'com.ai.hokusai',
                teamId: 'T4W85DPBVX',
                keyId: 'RFC9H5A57J',
                pem: pem,
                expiresIn: const Duration(hours: 1),
              );
              final now = DateTime.now();
              // final currentWeather = await weatherKit.obtainWeatherData(
              //   jwt: jwt,
              //   language: 'ja',
              //   latitude: 35.91238777,
              //   longitude: 139.60285321,
              //   dataSets: DataSet.currentWeather,
              //   timezone: 'Asia/Tokyo',
              //   countryCode: 'JP',
              //   currentAsOf: now.add(
              //     const Duration(days: -1),
              //   ),
              // );
              // final availability = await weatherKit.obtainAvailability(
              //   country: 'JP',
              //   jwt: jwt,
              //   latitude: 35.91238777,
              //   longitude: 139.60285321,
              // );
            },
            child: const Text('Generate JWT'),
          )
        ],
      )),
    );
  }
}
