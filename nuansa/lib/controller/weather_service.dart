import 'package:nuansa/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<WeatherModel> fetchDaily(double lat, double lon) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=07eeb579dd8585b5276412fb4221474e'));

  if (response.statusCode == 200) {
    return WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}