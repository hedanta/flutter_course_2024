import 'package:flutter/material.dart';

import 'package:final_project/features/kanji/domain/entities/kanji.dart';

class KanjiWidget extends StatelessWidget {
  final Kanji kanji;

  const KanjiWidget({super.key, required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            kanji.kanji,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 16),
          if (kanji.meanings.isNotEmpty) ...[
            Text(
              'Meanings: ${kanji.meanings.join(", ")}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
          ],
          if (kanji.kunReadings.isNotEmpty) ...[
            Text(
              'Kun Readings: ${kanji.kunReadings.join(", ")}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
          ],
          if (kanji.onReadings.isNotEmpty) ...[
            Text(
              'On Readings: ${kanji.onReadings.join(", ")}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
          ],
          if (kanji.heisig != '') ...[
            Text(
              'Heisig: ${kanji.heisig}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
          ],
          if (kanji.jlpt > 0) ...[
            Text(
              'JLPT Level: N${kanji.jlpt}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}