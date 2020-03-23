

import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/app_state.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:no_straw_please/extensions.dart';
import 'package:scoped_model/scoped_model.dart';
import '../styles.dart';

class PhraseHeadline extends StatelessWidget {
  final Phrase phrase; 

  const PhraseHeadline(this.phrase);

  @override
  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return GestureDetector(
      onTap: () => {
        appState.setSelectedPhrase(phrase.id),
        Navigator.of(context).pop()
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8,),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      phrase.language.toString().split(".").last.capitalize(), 
                      style: isDark ? Styles.darkHeadlineName : Styles.headlineName
                      ),
                  ],
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}