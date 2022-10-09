library weather_kit;

export 'src/models/data_set.dart';

import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:weather_kit/src/constants/base_url.dart';
import 'package:weather_kit/src/models/current_weather_data.dart';
import 'package:weather_kit/src/models/data_set.dart';

class WeatherKit {
  String generateJWT({
    required String bundleId,
    required String teamId,
    required String keyId,
    required String pem,
    required Duration expiresIn,
  }) {
    final jwt = JWT(
      {
        'sub': bundleId,
      },
      issuer: teamId,
      header: {
        "typ": "JWT",
        'id': "$teamId.$bundleId",
        'alg': 'ES256',
        'kid': keyId,
      },
    );
    final token = jwt.sign(
      ECPrivateKey(
        pem,
      ),
      algorithm: JWTAlgorithm.ES256,
      expiresIn: expiresIn,
    );
    return token;
  }

  /// [country] should be the ISO Alpha-2 country code.
  Future<List<dynamic>> obtainAvailability({
    required String jwt,
    required double latitude,
    required double longitude,
    required String country,
  }) async {
    assert(latitude >= -90 || latitude <= 90);
    assert(latitude >= -180 || latitude <= 180);
    final response = await http.get(
      Uri.parse("$baseUrl/availability/$latitude/$longitude?country=$country"),
      headers: {HttpHeaders.authorizationHeader: jwt},
    );
    final decode = json.decode(response.body);

    return decode;
  }

  /// Obtain weather data for the specified location.
  Future<CurrentWeatherData> obtainWeatherData({
    required String jwt,
    required String language,
    required double latitude,
    required double longitude,
    required DataSet dataSets,
    required String timezone,
    String? countryCode,
    DateTime? currentAsOf,
    DateTime? dailyEnd,
    DateTime? dailyStart,
    DateTime? hourlyEnd,
    DateTime? hourlyStart,
  }) async {
    assert(latitude >= -90 || latitude <= 90);
    assert(latitude >= -180 || latitude <= 180);
    String url =
        "$baseUrl/weather/$language/$latitude/$longitude?dataSets=${dataSets.name}&timezone=$timezone";

    if (countryCode != null) {
      url = '$url&countryCode=$countryCode';
    }
    if (currentAsOf != null) {
      url = '$url&currentAsOf=${currentAsOf.toIso8601String()}Z';
    }
    if (dailyEnd != null) {
      url = '$url&dailyEnd=${dailyEnd.toIso8601String()}Z';
    }
    if (dailyStart != null) {
      url = '$url&dailyStart=${dailyStart.toIso8601String()}Z';
    }
    if (hourlyEnd != null) {
      url = '$url&hourlyEnd=${hourlyEnd.toIso8601String()}Z';
    }
    if (hourlyStart != null) {
      url = '$url&hourlyStart=${hourlyStart.toIso8601String()}Z';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: jwt},
    );
    return CurrentWeatherData.fromJson(response.body);
  }
}
