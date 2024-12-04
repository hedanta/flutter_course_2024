
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:practice_1/features/core/data/om/om_api.dart';
import 'package:practice_1/features/core/data/om/weather_repository_om.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ru')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? errorMessage;
  bool _isError = false;
  String? _searchedCity;

  late final WeatherRepositoryOM weatherRepository;
  final TextEditingController _controller = TextEditingController();

  IconData? weatherIcon;
  String? temperature;
  String? condition;
  String? windSpeed;
  String? isDay;
  String? minTemp;
  String? maxTemp;
  bool isLoading = false;
  Locale _locale = const Locale('en');

  final String omUrl = dotenv.env['OM_API_URL']!;
  final String geoUrl = dotenv.env['GEO_OM_API_URL']!;

  void clearWeather() {
    setState(() {
      temperature = null;
      condition = null;
      windSpeed = null;
      minTemp = null;
      maxTemp = null;
      weatherIcon = null;
    });
  }

  @override
  void initState() {
    super.initState();

    weatherRepository = WeatherRepositoryOM(OMApi(
      omUrl,
      geoUrl,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchWeather(String city) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      isLoading = false;
    });

    try {
      var resp = await weatherRepository.getWeather(
        SearchQueryCity(city, language: _locale.languageCode),
      );

      setState(() {
        weatherIcon = getWeatherIcon(resp.type.toString());
        temperature = resp.temp.toString();
        windSpeed = resp.windSpeed.toString();
        isDay = resp.isDay.toString();
        condition = resp.type.toString();
        minTemp = resp.minTemp.toString();
        maxTemp = resp.maxTemp.toString();
        isLoading = false;
        _isError = false;

      });
    } catch (e) {
      if (e is CityNotFoundException) {
        setState(() {
          errorMessage = _locale.languageCode == 'en'
              ? 'City not found'
              : 'Город не найден';
          isLoading = false;
          _isError = true;
        });
        clearWeather();
      }
    }
  }

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'cloudy':
        return WeatherIcons.cloudy;
      case 'rain':
        return WeatherIcons.rain;
      case 'snow':
        return WeatherIcons.snow;
      case 'fog':
        return WeatherIcons.fog;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      default:
        return WeatherIcons.na;
    }
  }

  String getLocalizedCondition(String condition) {
    if (_locale.languageCode == 'ru') {
      switch (condition.toLowerCase()) {
        case 'clear':
          return 'Ясно';
        case 'cloudy':
          return 'Облачно';
        case 'rain':
          return 'Дождь';
        case 'snow':
          return 'Снег';
        case 'fog':
          return 'Туман';
        case 'thunderstorm':
          return 'Гроза';
        default:
          return 'Неизвестно';
      }
    }
    return condition;
  }

  void toggleLocale() {
    clearWeather();
    setState(() {
      _locale =
      _locale.languageCode == 'en' ? const Locale('ru') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_locale.languageCode == 'en' ? 'Weather App' : 'Погода'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLocale,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _isError = false;
                  errorMessage = null;
                });
              },
              decoration: InputDecoration(
                labelText: _locale.languageCode == 'en' ? 'Enter city' : 'Введите город',
                prefixIcon: _isError
                    ? const Icon(Icons.error, color: Colors.red)
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isError ? Colors.red : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isError ? Colors.red : Colors.blueGrey,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                      _isError = false;
                      errorMessage = null;
                    });
                    if (_controller.text != "") {
                      await fetchWeather(_controller.text);
                    }
                    setState(() {
                      _searchedCity = _controller.text;
                      isLoading = false;
                    });
                  },
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),

            Expanded(
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : (_searchedCity != "" && temperature != null)
                    ? Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDay == '1'
                        ? (condition == 'clear'
                        ? Color(0xff73a5c6)
                        : Color(0xffaeb7c8))
                        : (condition == 'clear'
                        ? const Color(0xff1e3f66)
                        : Color(0xff606774)),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on,
                              size: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black45,
                                ),
                              ]),
                          const SizedBox(width: 8),
                          Text(
                            _searchedCity!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Icon(
                        weatherIcon,
                        key: ValueKey(weatherIcon),
                        size: 150,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 30),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${temperature!}°',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'H:${maxTemp!}°',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3.0,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'L:${minTemp!}°',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3.0,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      if (condition != null)
                        Text(
                          getLocalizedCondition(condition!),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 3),

                      if (windSpeed != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.air,
                                size: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.black45,
                                  ),
                                ]),
                            const SizedBox(width: 8),
                            Text(
                              '${windSpeed!} m/s',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}