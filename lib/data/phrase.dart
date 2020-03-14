import 'dart:ui';

enum Language {
  english,
  vietnamese
}

class Phrase {
  Phrase({
    this.id, 
    this.language, 
    this.phrase,
    this.color,
    this.isSelected = false,
  });

  final int id;
  final Language language;
  final String phrase;
  final Color color;
  bool isSelected;
}