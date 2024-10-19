import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_info/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '//enter Your API Key here';
double? longitude;
double? latitude;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      await _checkPermissions();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
      Networking networking = Networking(
          // 'http://api.weatherstack.com/current?access_key=$apiKey&query=$latitude,$longitude');
          'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude');

      var weatherData = await networking.getData();
      String location = weatherData['Name'];
      double temperature = weatherData['Temperature'];
      print(location);
      print(temperature);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData);
      }));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Build function called');
    return Scaffold(
      body: Center(child: spinkit),
    );
  }

  final spinkit = SpinKitDoubleBounce(
    color: Colors.grey,
    size: 80.0,
  );
}
