import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:no_straw_please/screens/home.dart';
import 'package:no_straw_please/styles.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/app_state.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(
    ScopedModel<AppState>(
      model: AppState()..load(),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        color: Styles.appBackground,
        home: HomeScreen(),
      ),
    )
  );
}