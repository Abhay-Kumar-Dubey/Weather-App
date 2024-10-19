import 'package:flutter/material.dart';
import 'package:weather_info/services/forecast.dart';
import 'package:weather_info/utilities/constants.dart';
import 'package:weather_info/services/weather.dart';
import 'package:weather_info/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherData);

  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? cityName;
  late double temperature;
  late String weatherIcon;
  late String weatherText;
  WeatherModel weather = WeatherModel();
  late String weatherInfo;
  late var weatherIcon2;
  List? scrollTemp;
  late String TopScrollText;
  List? scrollIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    temperature = weatherData['Temperature'];
    cityName = weatherData['Name'];
    // weatherIcon = (weatherData['WeatherIcon']).toString();
    weatherIcon = weather.getWeatherIcon(weatherData['WeatherIcon']);
    weatherText = weather.getMessage(temperature);
    weatherInfo = (weatherData['WeatherInfo']).toString();
    weatherIcon2 = weatherData['WeatherIcon2'];
    scrollTemp = weatherData['ScrollTemp'];
    scrollIcon = weatherData['ScrollIcon'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bgimage.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     TextButton(
              //       onPressed: () {},
              //       child: Icon(
              //         Icons.near_me,
              //         size: 50.0,
              //       ),
              //     ),
              //     TextButton(
              //       onPressed: () {},
              //       child: Icon(
              //         Icons.location_city,
              //         size: 50.0,
              //       ),
              //     ),
              //   ],
              // ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '$cityName',
                      style: kMessageTextStyle,
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToLastDescent: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                        textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$weatherInfo',
                          style: kButtonTextStyle,
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        // Image(
                        //   image: NetworkImage(
                        //       weatherIcon.substring(1, weatherIcon.length - 1)),
                        // ),
                        // Text(
                        //   // '☀️',
                        //   '$weatherIcon',
                        //   style: kConditionTextStyle,
                        // ),
                        Image.network('http:$weatherIcon2'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity, // Or set a specific width
                      height: 350, // Set the height based on your needs

                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                            0.25,
                          ),
                          borderRadius: BorderRadius.circular(
                              25.0)), // Set your desired color and opacity
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Weather Forecast For the Day',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 43),
                      child: SizedBox(
                        height: 3,
                        width: double.infinity,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 270.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: scrollTemp?.length,
                            itemBuilder: (context, index) {
                              final Forecast1 = scrollTemp?[index];
                              final IconUrl = scrollIcon?[index];
                              // scrollTemp!.map((index) {
                              //   var Forecast1 = index.temp_c;
                              // });
                              if (index == 0) {
                                TopScrollText = '12 AM';
                              } else if (index > 0 && index < 12) {
                                TopScrollText = '$index AM';
                              } else if (index == 12) {
                                TopScrollText = '$index PM';
                              } else {
                                int set = index - 12;
                                TopScrollText = '$set PM';
                              }
                              return Container(
                                width: 100.0,
                                margin: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(
                                      0.56,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Text(
                                        '$TopScrollText',
                                        style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                    Image.network('http:$IconUrl'),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        '$Forecast1',
                                        style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            // itemExtent: 70.0,
                          ),
                        ),
                      ),
                    )
                    // Text(
                    //   "$weatherText in $cityName!",
                    //   textAlign: TextAlign.center,
                    //   style: kMessageTextStyle,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
