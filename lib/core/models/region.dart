import 'package:flutter/material.dart';
import './country.dart';

class Region {
  final String? regionName;
  final Color? regionColor;
  final List<Country>? countries;

  Region({
    required this.regionName,
    required this.regionColor,
    required this.countries,
  });

  factory Region.fromJSON(
    String name,
    Color color,
    List<Country> countries,
  ) {
    return Region(
      regionName: name,
      regionColor: color,
      countries: countries,
    );
  }
}
