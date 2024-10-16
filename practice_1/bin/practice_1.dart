import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/om/om_api.dart';
import 'package:practice_1/features/core/data/om/weather_repository_om.dart';
import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/data/osm/weather_repository_osm.dart';
import 'package:practice_1/features/core/presentation/app.dart';
import 'package:dotenv/dotenv.dart';

const String version = '0.0.1';

Future<void> main(List<String> arguments) async {
  var env = DotEnv()..load();
  final String osmUrl = env['OSM_API_URL']!;
  final String osmApiKey = env['OSM_API_KEY']!;
  final String omUrl = env['OM_API_URL']!;

  //var app = App(WeatherRepositoryOSM(OSMApi(osmUrl, osmApiKey)));
  var app = App(WeatherRepositoryOM(OMApi(omUrl)));
  app.run();
}
