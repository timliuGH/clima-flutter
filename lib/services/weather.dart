import 'package:climaflutter/services/location.dart';
import 'package:climaflutter/services/networking.dart';

const apiKey = '7bddd03815637ac5f2691302cc57a7fe';
const openWeatherMapAPI = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getWeatherData([String city]) async {
    if (city != null) {
      // Use location from user's input to get decoded data from api call
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapAPI?q=$city&appid=$apiKey&units=imperial');
      return await networkHelper.getData();
    } else {
      // Get location based on device's location
      Location location = Location();
      await location.getCurrentLocation();

      // Get decoded data from api call
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapAPI?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial');
      return await networkHelper.getData();
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 77) {
      return 'It\'s 🍦 time';
    } else if (temp > 68) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
