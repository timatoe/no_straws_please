

import 'dart:ui';

import 'package:no_straw_please/data/phrase.dart';

class LocalPhraseProvider {
  static List<Phrase> phrases = [
    Phrase(
      id: 1, 
      language: Language.english, 
      phrase: "No plastic straw with my drink please",
      color: Color.fromRGBO(221, 47, 21, 1),
      isSelected: false
      ),
    Phrase(
      id: 2, 
      language: Language.vietnamese, 
      phrase: "Vui lòng không có ống hút nhựa",
      color: Color.fromRGBO(162, 102, 134, 1),
      isSelected: false
      )
  ];
}