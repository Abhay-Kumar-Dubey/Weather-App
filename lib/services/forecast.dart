class Forecast {
  List<Hours>? hours = [];
  Forecast({required this.hours});

  Forecast.fromJson(Map<String, dynamic> json) {
    var forecastDays = json['forecast']['forecastday'] as List;
    var firstDay = forecastDays[0];
    var hourList = firstDay['hour'] as List;

    (hourList as List).forEach((e) {
      hours!.add(Hours.fromJson(e));
    });
  }
}

class Hours {
  double? temp_c;
  Hours({required this.temp_c});
  Hours.fromJson(Map<String, dynamic> json) {
    temp_c = json['temp_c'];
  }

  @override
  String toString() {
    return '$temp_c°C';
  }
}

class ForecastIcon {
  List<Icon>? icon = [];
  ForecastIcon({required this.icon});

  ForecastIcon.fromJson(Map<String, dynamic> json) {
    var forecastDaysIcon = json['forecast']['forecastday'] as List;
    var firstDayIcon = forecastDaysIcon[0];
    var hourListIcon = firstDayIcon['hour'] as List;

    (hourListIcon as List).forEach((e) {
      icon!.add(Icon.fromJson(e));
    });
  }
}

class Icon {
  String? icon_url;
  Icon({required this.icon_url});
  Icon.fromJson(Map<String, dynamic> json) {
    icon_url = json['condition']['icon'];
  }

  @override
  String toString() {
    return '$icon_url';
  }
}
