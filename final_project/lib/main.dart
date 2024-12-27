import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/features/kanji/data/data_sources/kanji_api.dart';
import 'package:final_project/features/kanji/data/kanji_repository.dart';
import 'package:final_project/features/kanji/presentation/provider/kanji_provider.dart';
import 'package:final_project/features/kanji/presentation/screens/home_screen.dart';
import 'package:final_project/features/kanji/data/data_sources/kanji_local.dart';

void main() async {
  await dotenv.load();
  final kanjiApi = KanjiApi(dotenv.env['KANJI_API_URL']!);
  final kanjiRepository = KanjiRepository(kanjiApi);

  runApp(
    ChangeNotifierProvider(
      create: (context) => KanjiProvider(KanjiLocalDataSource(), kanjiRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanji Dictionary',
      home: HomeScreen(),
    );
  }
}