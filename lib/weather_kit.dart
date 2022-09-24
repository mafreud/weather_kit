library weather_kit;

import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

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
      Uri.parse(
          "https://weatherkit.apple.com/api/v1/availability/$latitude/$longitude?country=$country"),
      headers: {HttpHeaders.authorizationHeader: jwt},
    );
    return response;
  }

  Future<http.Response> obtainWeatherData(
      {required String jwt,
      required String language,
      required String latitude,
      required String longitude,
      required String dataSets}) async {
    final response = await http.get(
      Uri.parse(
          "https://weatherkit.apple.com/api/v1/weather/$language/$latitude/$longitude?dataSets=$dataSets"),
      headers: {HttpHeaders.authorizationHeader: jwt},
    );
    return response;
  }
}
