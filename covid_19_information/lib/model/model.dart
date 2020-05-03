import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Days>> fetchPhotos() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/muhammederem/json0/master/dataset.json');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Days> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Days>((json) => Days.fromJson(json)).toList();
}

class Days {
  String cases;
  String totalCases;
  String deaths;
  String totalDeaths;
  String recovered;
  String totalRecovered;
  String totalIntubated;
  String totalIntensiveCare;
  String tests;
  String totalTests;
  String date;
  String id;

  Days(
      {this.cases,
      this.date,
      this.deaths,
      this.id,
      this.recovered,
      this.tests,
      this.totalCases,
      this.totalDeaths,
      this.totalIntensiveCare,
      this.totalIntubated,
      this.totalRecovered,
      this.totalTests});

  factory Days.fromJson(Map<String, dynamic> json) {
    return Days(
      cases: json["cases"] as String,
      date: json["date"] as String,
      deaths: json["deaths"] as String,
      id: json["id"] as String,
      recovered: json["recovered"] as String,
      tests: json["tests"] as String,
      totalCases: json["totalCases"] as String,
      totalDeaths: json["totalDeaths"] as String,
      totalIntensiveCare: json["totalIntensiveCare"] as String,
      totalIntubated: json["totalIntubated"] as String,
      totalRecovered: json["totalRecovered"] as String,
      totalTests: json["totalTests"] as String,
    );
  }
}
