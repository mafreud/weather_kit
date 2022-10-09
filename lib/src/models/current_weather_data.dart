import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_kit/src/models/metadata.dart';
import 'package:weather_kit/src/models/pressure_trend.dart';

/// The current weather object.
@immutable
class CurrentWeatherData {
  final String name;
  final Metadata metadata;
  final DateTime asOf;
  final double? cloudCover;
  final String conditionCode;
  final bool? daylight;
  final double humidity;
  final double precipitationIntensity;
  final double pressure;
  final PressureTrend pressureTrend;
  final double temperature;
  final double temperatureApparent;
  final double temperatureDewPoint;
  final int uvIndex;
  final double visibility;
  final int? windDirection;
  final double? windGust;
  final double windSpeed;

  const CurrentWeatherData({
    required this.name,
    required this.metadata,
    required this.asOf,
    this.cloudCover,
    required this.conditionCode,
    this.daylight,
    required this.humidity,
    required this.precipitationIntensity,
    required this.pressure,
    required this.pressureTrend,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    required this.visibility,
    this.windDirection,
    this.windGust,
    required this.windSpeed,
  });

  factory CurrentWeatherData.fromMap(Map<String, dynamic> map) {
    final result = map['currentWeather'];
    return CurrentWeatherData(
      name: result['name'],
      metadata: Metadata.fromMap(result['metadata']),
      asOf: DateTime.parse(result['asOf']),
      cloudCover: result['cloudCover'],
      conditionCode: result['conditionCode'],
      daylight: result['daylight'],
      humidity: result['humidity'],
      precipitationIntensity: result['precipitationIntensity'],
      pressure: result['pressure'],
      pressureTrend: PressureTrend.values.byName(result['pressureTrend']),
      temperature: result['temperature'],
      temperatureApparent: result['temperatureApparent'],
      temperatureDewPoint: result['temperatureDewPoint'],
      uvIndex: result['uvIndex'],
      visibility: result['visibility'],
      windDirection: result['windDirection'],
      windGust: result['windGust'],
      windSpeed: result['windSpeed'],
    );
  }

  factory CurrentWeatherData.fromJson(String source) =>
      CurrentWeatherData.fromMap(json.decode(source) as Map<String, dynamic>);
}
