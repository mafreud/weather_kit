library weather_kit;

export 'src/models/data_set.dart';

import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:weather_kit/src/constants/base_url.dart';
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
  Future<http.Response> obtainAvailability({
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
    return response;
  }

  /// Obtain weather data for the specified location.
  Future<http.Response> obtainWeatherData({
    required String jwt,
    required String language,
    required double latitude,
    required double longitude,
    required DataSet dataSets,
    required String timezone,
  }) async {
    assert(latitude >= -90 || latitude <= 90);
    assert(latitude >= -180 || latitude <= 180);
    final response = await http.get(
      Uri.parse(
        "$baseUrl/weather/$language/$latitude/$longitude?dataSets=${dataSets.name}&timezone=$timezone",
      ),
      headers: {HttpHeaders.authorizationHeader: jwt},
    );
    return response;
  }
}
