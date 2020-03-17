import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/app_state.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:no_straw_please/widgets/phrase_headline.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class SelectedPhrasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
        final selectedPhrases = model.selectedPhrases;
        
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(''),
          ),
          child: FutureBuilder<List<Phrase>>(
            future: selectedPhrases,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: snapshot.data.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'You haven\'t selected a language yet.',
                        style: Styles.headlineDescription,
                      ),
                    )
                  : ListView(
                    children: [
                      SizedBox(height: 24),
                      for (Phrase phrase in snapshot.data)
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: PhraseHeadline(phrase),
                        )
                    ],
                  ), 
                );
              } else {
                return Text('');
              }
            },
          ),
        );
      }
    );
  }
}