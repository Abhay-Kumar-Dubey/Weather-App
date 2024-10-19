class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition == 260) {
      return '🌩';
    } else if (condition == 176 || condition == 179 || condition == 200) {
      return '🌧';
    } else if (condition == 248) {
      return '☔️';
    } else if (condition == 227) {
      return '☃️';
    } else if (condition == 122) {
      return '🌫';
    } else if (condition == 113) {
      return '☀️';
    } else if (condition == 116) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
