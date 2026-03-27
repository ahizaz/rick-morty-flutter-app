import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/character_controller.dart';
import '../models/character.dart';
import 'edit_page.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CharacterController>();
    Character? c = ctrl.getById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(c?.name ?? 'Character'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (c != null) {
                Get.to(() => EditPage(character: c!));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ctrl.resetEdits(id);
              Get.snackbar('Reset', 'Edits reset for [200mc?.name ?? id [0m');
            },
          )
        ],
      ),
      body: Obx(() {
        c = ctrl.getById(id);
        if (c == null) return const Center(child: Text('Not found'));
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            CachedNetworkImage(imageUrl: c!.image, height: 200),
            const SizedBox(height: 12),
            _row('Name', c!.name),
            _row('Status', c!.status),
            _row('Species', c!.species),
            _row('Type', c!.type.isEmpty ? '-' : c!.type),
            _row('Gender', c!.gender),
            _row('Origin', c!.originName),
            _row('Location', c!.locationName),
          ]),
        );
      }),
    );
  }

  Widget _row(String k, String v) => ListTile(title: Text(k), subtitle: Text(v));
}

// Edit bottom sheet removed; now handled by EditPage

