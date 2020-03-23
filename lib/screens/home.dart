

import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/app_state.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:no_straw_please/screens/search.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    final selectedPhrase = model.getSelectedPhrase();

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return CupertinoPageScaffold(
      child: FutureBuilder<Phrase>(
        future: selectedPhrase,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: snapshot.data == null
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'You haven\'t selected a language yet.',
                        style: isDark ? Styles.darkHeadlineDescription : Styles.headlineDescription
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        snapshot.data.phrase,
                        style: isDark ? Styles.darkHeadlineText : Styles.headlineText
                      ),
                    ), 
                  )
                ),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  child: Text(
                    'Select Language',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).push<void>(CupertinoPageRoute(
                      builder: (context) => SearchScreen(),
                      fullscreenDialog: true,
                    ));
                  }
                ),
                SizedBox(height: 32)
              ],
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
              ),
            );
          }
        },
      ),
    );
  }
}
