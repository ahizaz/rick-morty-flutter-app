import 'package:get/get.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import '../services/hive_service.dart';

class CharacterController extends GetxController {
  final characters = <Character>[].obs;
  final page = 1.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  final isError = false.obs;
  final query = ''.obs;
  final filterStatus = Rx<String?>(null);
  final filterSpecies = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  Future<void> loadInitial() async {
    page.value = 1;
    characters.clear();
    hasMore.value = true;
    await fetchPage(page.value, replace: true);
  }

  Future<void> fetchPage(int p, {bool replace = false}) async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    isError.value = false;
    try {
      Map<String, dynamic>? data;
      try {
        data = await ApiService.fetchPage(p, query: query.value.isEmpty ? null : query.value, status: filterStatus.value, species: filterSpecies.value);
        final results = data['results'] as List<dynamic>;
        await HiveService.cachePage(p, results);
        for (var r in results) {
          await HiveService.cacheCharacter((r as Map)['id'] as int, (r).cast<String, dynamic>());
        }
      } catch (_) {
        final cached = HiveService.getCachedPage(p);
        if (cached == null) rethrow;
        data = {'results': cached, 'info': {'pages': p}};
      }
      final items = (data['results'] as List).map((e) {
        final map = (e as Map).cast<String, dynamic>();
        final base = Character.fromMap(map);
        final overrides = HiveService.getEdits(base.id);
        return base.copyWithOverrides(overrides);
      }).toList();

      if (replace) {
        characters.assignAll(items);
      } else {
        characters.addAll(items);
      }

      final infoPages = ((data['info']?['pages']) ?? (p + 1));
      hasMore.value = p < infoPages;
      page.value = p;
    } catch (e) {
      isError.value = true;
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNext() async {
    if (!hasMore.value) return;
    await fetchPage(page.value + 1);
  }

  Character? getById(int id) {
    final c = characters.firstWhereOrNull((x) => x.id == id);
    if (c != null) return c;
    final cached = HiveService.getCachedCharacter(id);
    if (cached != null) return Character.fromMap(cached).copyWithOverrides(HiveService.getEdits(id));
    return null;
  }

  @override
  Future<void> refresh() async => await loadInitial();

  // Edits
  Future<void> saveEdits(int id, Map<String, dynamic> edits) async {
    await HiveService.saveEdits(id, edits);
    final idx = characters.indexWhere((c) => c.id == id);
    if (idx != -1) {
      final base = Character.fromMap(HiveService.getCachedCharacter(id) ?? characters[idx].toMap());
      characters[idx] = base.copyWithOverrides(edits);
    }
  }

  Future<void> resetEdits(int id) async {
    await HiveService.removeEdits(id);
    final idx = characters.indexWhere((c) => c.id == id);
    if (idx != -1) {
      final base = Character.fromMap(HiveService.getCachedCharacter(id) ?? characters[idx].toMap());
      characters[idx] = base;
    }
  }

  // Favorites
  bool isFavorite(int id) => HiveService.isFavorite(id);
  Future<void> toggleFavorite(int id) async {
    await HiveService.toggleFavorite(id);
    refresh();
  }

  void setQuery(String q) {
    query.value = q;
    loadInitial();
  }

  void setFilter({String? status, String? species}) {
    filterStatus.value = status;
    filterSpecies.value = species;
    loadInitial();
  }
}
