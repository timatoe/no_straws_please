
import 'package:no_straw_please/data/local_phrase_provider.dart';
import 'package:no_straw_please/data/phrase.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends Model {
  // In-memory State
  List<Phrase> _phrases;

  AppState() : _phrases = LocalPhraseProvider.phrases;

  List<Phrase> get allPhrases => List<Phrase>.from(_phrases);

  Phrase getPhrase(int id) => _phrases.singleWhere((v) => v.id == id);

  Future<List<Phrase>> get selectedPhrases async {
    await _loading;
    return _phrases.where((v) => v.isSelected).toList();
  } 

  List<Phrase> searchPhrases(String terms) => _phrases
  .where((v) => v.language.toString().toLowerCase().contains(terms.toLowerCase()))
  .toList();

  void setIsSelected(int id, bool isSelected) {
    Phrase phrase = getPhrase(id);
    phrase.isSelected = isSelected;
    setSelectedPhraseId(isSelected ? id : -1);
    notifyListeners();
  }

  // SharedPreferences State
  static const _selectedPhraseIdKey = 'selectedPhraseIdKey';

  Future<void> _loading;

  int _selectedPhraseId = -1;

  Future<void> setSelectedPhraseId(int id) async {
    _selectedPhraseId = id;
    await _saveToSharedPrefs();
    notifyListeners();
  }

  void load() {
    _loading = _loadFromSharedPrefs();
  }

  Future<void> _saveToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedPhraseIdKey, _selectedPhraseId);
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(_selectedPhraseIdKey) ?? -1;
    if (id != -1) {
      Phrase phrase = getPhrase(id);
      phrase.isSelected = true;
    }
    notifyListeners();
  }
}