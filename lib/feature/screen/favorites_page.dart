import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CharacterController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        final ids = ctrl.characters.where((c) => ctrl.isFavorite(c.id)).map((c) => c.id).toList();
        if (ids.isEmpty) return const Center(child: Text('No favorites'));
        final favChars = ids.map((id) => ctrl.getById(id)).whereType().toList();
        return ListView.separated(
          itemCount: favChars.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, i) => CharacterTile(character: favChars[i]),
        );
      }),
    );
  }
}
