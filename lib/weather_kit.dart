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

  Future<http.Response> fetchAvailability({
    required String jwt,
    required String latitude,
    required String longitude,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://weatherkit.apple.com/api/v1/availability/$latitude/$longitude"),
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
