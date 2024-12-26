import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/features/kanji/presentation/provider/kanji_provider.dart';
import 'package:final_project/features/kanji/domain/entities/kanji.dart';
import 'package:final_project/features/kanji/presentation/widgets/kanji_widget.dart';

class StarredScreen extends StatelessWidget {
  const StarredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffe3cfd1),
        title: Text('Saved Kanjis'),
      ),
      body: Consumer<KanjiProvider>(
        builder: (context, kanjiProvider, child) {
          return ListView.separated(
            itemCount: kanjiProvider.starredKanjis.length,
            itemBuilder: (context, index) {
              final Kanji kanji = kanjiProvider.starredKanjis[index];
              return ListTile(
                title: Text('${kanji.kanji}  —  ${kanji.meanings.isNotEmpty ? kanji.meanings[0] : ''}'),
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => SizedBox(
                      height: 400,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: KanjiWidget(kanji: kanji),
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    kanjiProvider.removeStarredKanji(kanji);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          );
        },
      ),
    );
  }
}