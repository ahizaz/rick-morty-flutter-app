import 'package:hive/hive.dart';

class HiveService {
  static late Box cacheBox;
  static late Box editsBox;
  static late Box favoritesBox;

  static Future<void> initBoxes() async {
    cacheBox = await Hive.openBox('cache');
    editsBox = await Hive.openBox('edits');
    favoritesBox = await Hive.openBox('favorites');
  }

  // Cache helpers
  static Future<void> cachePage(int page, List<dynamic> charactersJson) async {
    await cacheBox.put('page_$page', charactersJson);
  }

  static List<dynamic>? getCachedPage(int page) => cacheBox.get('page_$page')?.cast<dynamic>();

  static Future<void> cacheCharacter(int id, Map<String, dynamic> json) async {
    await cacheBox.put('char_$id', json);
  }

  static Map<String, dynamic>? getCachedCharacter(int id) => (cacheBox.get('char_$id') as Map?)?.cast<String, dynamic>();

  // Edits
  static Future<void> saveEdits(int id, Map<String, dynamic> edits) async {
    await editsBox.put(id.toString(), edits);
  }

  static Map<String, dynamic>? getEdits(int id) => (editsBox.get(id.toString()) as Map?)?.cast<String, dynamic>();

  static Future<void> removeEdits(int id) async => editsBox.delete(id.toString());

  // Favorites
  static List<int> getFavorites() => (favoritesBox.get('list') as List?)?.cast<int>() ?? [];

  static Future<void> toggleFavorite(int id) async {
    final fav = getFavorites();
    if (fav.contains(id)) {
      fav.remove(id);
    } else {
      fav.add(id);
    }
    await favoritesBox.put('list', fav);
  }

  static bool isFavorite(int id) => getFavorites().contains(id);
}
