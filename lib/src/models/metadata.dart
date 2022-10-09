import 'package:flutter/material.dart';

@immutable
class Metadata {
  final String attributionURL;
  final DateTime expireTime;
  final double latitude;
  final double longitude;
  final DateTime readTime;
  final DateTime reportedTime;
  final String units;
  final int version;

  const Metadata({
    required this.attributionURL,
    required this.expireTime,
    required this.latitude,
    required this.longitude,
    required this.readTime,
    required this.reportedTime,
    required this.units,
    required this.version,
  });

  factory Metadata.fromMap(Map<String, dynamic> map) {
    return Metadata(
      attributionURL: map['attributionURL'] as String,
      expireTime: DateTime.parse(map['expireTime']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      readTime: DateTime.parse(map['readTime']),
      reportedTime: DateTime.parse(map['reportedTime']),
      units: map['units'],
      version: map['version'],
    );
  }
}
