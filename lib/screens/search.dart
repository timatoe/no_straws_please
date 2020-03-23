import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/app_state.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:no_straw_please/widgets/back_button.dart';
import 'package:no_straw_please/widgets/phrase_headline.dart';
import 'package:no_straw_please/widgets/search_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String terms = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() => terms = controller.text);
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: BackButton(() {
                Navigator.of(context).pop();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }

  Widget _buildSearchResults(List<Phrase> phrases) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    if (phrases.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'No languages matching your search terms were found.',
            style: isDark ? Styles.darkHeadlineDescription : Styles.headlineDescription,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: phrases.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: PhraseHeadline(phrases[i]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    return CupertinoPageScaffold(
        child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                _createSearchBox(),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: _buildSearchResults(model.searchPhrases(terms))
                )
              ],
            )
          )
    );
  }
}