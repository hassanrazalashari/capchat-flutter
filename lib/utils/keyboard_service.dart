import 'package:shared_preferences/shared_preferences.dart';
import 'keyboard_assets.dart';

class KeyboardService {
  static const String _recentEmojisKey = 'recent_emojis';
  List<String> recentEmojis = [];

  Future<void> loadRecentEmojis() async {
    final prefs = await SharedPreferences.getInstance();
    recentEmojis = prefs.getStringList(_recentEmojisKey) ?? [];
  }

  Future<void> saveRecentEmoji(String emoji) async {
    recentEmojis.remove(emoji);
    recentEmojis.insert(0, emoji);
    if (recentEmojis.length > 30) recentEmojis = recentEmojis.sublist(0, 30);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentEmojisKey, recentEmojis);
  }

  List<String> searchEmojis(String query) {
    final searchTerm = query.toLowerCase();
    return [
      ...emojisSmileysPeople,
      ...emojisAnimalsNature,
      ...emojisFoodDrink,
      ...emojisActivities,
      ...emojisTravelPlaces,
      ...emojisObjects,
      ...emojisSymbols,
    ].where((emoji) => emoji.toLowerCase().contains(searchTerm)).toList();
  }
}