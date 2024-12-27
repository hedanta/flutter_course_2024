import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/features/kanji/presentation/provider/kanji_provider.dart';
import 'package:final_project/features/kanji/presentation/screens/starred_screen.dart';
import 'package:final_project/features/kanji/presentation/widgets/kanji_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Kanji Dictionary'),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<KanjiProvider>(
                builder: (context, kanjiProvider, child) {
                  return TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter Kanji',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => kanjiProvider.fetchKanjiInfo(controller.text),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kanjiProvider.isError ? Colors.red : Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kanjiProvider.isError ? Colors.red : Colors.blueGrey,
                        ),
                      ),
                    ),
                    onSubmitted: kanjiProvider.fetchKanjiInfo,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Consumer<KanjiProvider>(
                        builder: (context, kanjiProvider, child) {
                          if (kanjiProvider.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (kanjiProvider.isKanjiFound) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: KanjiWidget(kanji: kanjiProvider.kanjiInfo!),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xffa37f83),
                                    textStyle: const TextStyle(fontSize: 18),
                                  ),
                                  child: Text(
                                    kanjiProvider.isKanjiStarred(kanjiProvider.kanjiInfo!) ? 'Saved' : 'Save',
                                  ),
                                  onPressed: () => kanjiProvider.toggleStarredKanji(kanjiProvider.kanjiInfo!),
                                ),
                              ],
                            );
                          } else if (kanjiProvider.errorMessage != null) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                kanjiProvider.errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            );
                          } else {
                            return const Text('', style: TextStyle(fontSize: 16));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffe3cfd1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StarredScreen()),
          );
        },
        child: const Icon(
          Icons.star,
          color: Color(0xff855f64),
        ),
      ),
    );
  }
}