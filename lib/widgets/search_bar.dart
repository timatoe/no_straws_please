import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? Styles.darkSearchBackground : Styles.searchBackground,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            ExcludeSemantics(
              child: Icon(
                CupertinoIcons.search,
                color: Styles.searchIconColor,
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                decoration: null,
                style: isDark ? Styles.darkSearchText : Styles.searchText,
                cursorColor: Styles.searchCursorColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clear();
              },
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                semanticLabel: 'Clear search terms',
                color: Styles.searchIconColor,
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
