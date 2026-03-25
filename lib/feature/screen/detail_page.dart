import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/character_controller.dart';
import '../models/character.dart';

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
            onPressed: () => _showEditSheet(context, ctrl, c),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ctrl.resetEdits(id);
              Get.snackbar('Reset', 'Edits reset for ${c?.name ?? id}');
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

void _showEditSheet(BuildContext context, CharacterController ctrl, Character? c) {
  final name = TextEditingController(text: c?.name ?? '');
  final status = TextEditingController(text: c?.status ?? '');
  final species = TextEditingController(text: c?.species ?? '');
  final type = TextEditingController(text: c?.type ?? '');
  final gender = TextEditingController(text: c?.gender ?? '');
  final origin = TextEditingController(text: c?.originName ?? '');
  final location = TextEditingController(text: c?.locationName ?? '');

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Edit character', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: status, decoration: const InputDecoration(labelText: 'Status')),
          TextField(controller: species, decoration: const InputDecoration(labelText: 'Species')),
          TextField(controller: type, decoration: const InputDecoration(labelText: 'Type')),
          TextField(controller: gender, decoration: const InputDecoration(labelText: 'Gender')),
          TextField(controller: origin, decoration: const InputDecoration(labelText: 'Origin name')),
          TextField(controller: location, decoration: const InputDecoration(labelText: 'Location name')),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final edits = {
                'name': name.text,
                'status': status.text,
                'species': species.text,
                'type': type.text,
                'gender': gender.text,
                'originName': origin.text,
                'locationName': location.text,
              };
              if (c != null) await ctrl.saveEdits(c.id, edits);
              Get.back();
              Get.snackbar('Saved', 'Local edits saved');
            },
            child: const Text('Save edits locally'),
          ),
          TextButton(onPressed: () { Get.back(); }, child: const Text('Cancel')),
        ]),
      ),
    ),
    isScrollControlled: true,
  );
}
