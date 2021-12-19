class WeatherModel {
  num temp;
  num humidity;
  num windSpeed;
  String description;
  String icon;
  String main;


  WeatherModel({
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.main,
  });

  factory WeatherModel.fromJson(Map json) {
    return WeatherModel(
      temp: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
    );
  }
}