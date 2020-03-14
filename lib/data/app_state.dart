
import 'package:no_straw_please/data/local_phrase_provider.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  List<Phrase> _phrases;

  AppState() : _phrases = LocalPhraseProvider.phrases;

  List<Phrase> get allPhrases => List<Phrase>.from(_phrases);

  Phrase getPhrase(int id) => _phrases.singleWhere((v) => v.id == id);

  List<Phrase> get selectedPhrases => _phrases.where((v) => v.isSelected).toList();

  List<Phrase> searchPhrases(String terms) => _phrases
  .where((v) => v.language.toString().toLowerCase().contains(terms.toLowerCase()))
  .toList();
  
  void setIsSelected(int id, bool isSelected) {
    Phrase phrase = getPhrase(id);
    phrase.isSelected = isSelected;
    notifyListeners();
  }
}