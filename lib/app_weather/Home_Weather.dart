import 'package:api_flutter/app_weather/Class_Weather.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class HomeWeather extends StatefulWidget {
  const HomeWeather({super.key});

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  ////////////////////////////////////////
  ///////////
  ////////////////////////////////////////
  ClassWeather? classWeather;

  ////////////////////////////////////////
  ///////////
  ////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
        backgroundColor: Colors.blue,
        body:classWeather==null?Center(child: CircularProgressIndicator()): Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "City Name : ${classWeather!.cityName}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ), Image.network(
                "https://openweathermap.org/img/wn/${classWeather!.icon}@2x.png",
                width: 100,
                height: 100,
              ),

              SizedBox(height: 4),
              Text(
                "description : ${classWeather!.description}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),  SizedBox(height: 4),
              Text(
                "temp : ${classWeather!.temp}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),);
  }

  void getWeather() async {
    Dio dio = Dio();
    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        "lat": "13.55696360",
        "lon": "35.84789650",
        "appid": "a4c38309b51e5a05e6d4cc4f90f5ee6a",
        "units": "metric",
      },
    );
    print(response.data.toString());
    Map<String, dynamic> mapData = response.data;
    setState(() {
    classWeather = ClassWeather.fromMap(mapData);
    });


  }
}
