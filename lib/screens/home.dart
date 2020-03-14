

import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/screens/search.dart';
import 'package:no_straw_please/screens/selected_phrases.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          title: Text('Search'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return SelectedPhrasesScreen();
        } else {
          return SearchScreen();
        }
      },
    );
  }
}
