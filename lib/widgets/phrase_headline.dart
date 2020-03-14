

import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:no_straw_please/screens/details.dart';

import '../styles.dart';

class PhraseHeadline extends StatelessWidget {
  final Phrase phrase; 

  const PhraseHeadline(this.phrase);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(CupertinoPageRoute(
        builder: (context) => DetailsScreen(phrase.id),
        fullscreenDialog: true,
      )),
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
                    Text(phrase.language.toString(), style: Styles.headlineName),
                  ],
                ),
                // Text(
                //   phrase.phrase,
                //   style: Styles.headlineDescription,
                // )
              ]
            ),
          )
        ],
      ),
    );
  }
}