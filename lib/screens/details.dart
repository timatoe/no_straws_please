import 'package:flutter/cupertino.dart';
import 'package:no_straw_please/data/app_state.dart';
import 'package:no_straw_please/widgets/close_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class InfoView extends StatelessWidget {
  final int id;

  const InfoView(this.id);

  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    final phrase = appState.getPhrase(id);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8,),
          Text(
            phrase.language.toString(),
            style: Styles.detailsTitleText,
          ),
          SizedBox(height: 8,),
          Text(
            phrase.phrase,
            style: Styles.detailsDescriptionText
          ),
          SizedBox(height: 24,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoSwitch(
                value: phrase.isSelected,
                onChanged: (value) {
                  appState.setIsSelected(id, value);
                },
              ),
              SizedBox(width: 8,),
              Text('Save Language')
            ],
          )
        ],
      )
    );
  }
}

class DetailsScreen extends StatefulWidget {
  final int id;
  
  DetailsScreen(this.id);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  Widget _buildHeader(BuildContext context, AppState model) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   child: Image.asset(
          //     '',
          //     color: phrase.color,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: CloseButton(() {
                Navigator.of(context).pop();
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildHeader(context, appState),
                SizedBox(height: 20),
                InfoView(widget.id)
              ],
            )
          )
        ],
      )
    );
  }
}