import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_info/services/forecast.dart';

class Networking {
  Networking(this.url);

  final String url;
  Future getData() async {
    print(url);
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      dynamic data = response.body;
      var weatherIcon = jsonDecode(data)['current']['condition']['code'];
      var positionName = jsonDecode(data)['location']['region'];
      var temperature = jsonDecode(data)['current']['temp_c'];
      var weatherinfo = jsonDecode(data)['current']['condition']['text'];
      var weatherIcon2 = jsonDecode(data)['current']['condition']['icon'];
      var scrollData = Forecast.fromJson(jsonDecode(data));
      var forecast = scrollData.hours;
      var scrollIcon = ForecastIcon.fromJson(jsonDecode(data));
      var forecastIcon = scrollIcon.icon;
      ;

      return {
        'Name': positionName,
        'Temperature': temperature,
        'WeatherIcon': weatherIcon,
        'WeatherInfo': weatherinfo,
        'WeatherIcon2': weatherIcon2,
        'ScrollTemp': forecast,
        'ScrollIcon': forecastIcon,
      };
    } else {
      print(response.statusCode);
    }
  }
}
