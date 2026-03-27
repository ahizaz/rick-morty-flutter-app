import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';
import '../models/character.dart';

class EditPage extends StatefulWidget {
  final Character character;
  const EditPage({super.key, required this.character});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController name;
  late TextEditingController status;
  late TextEditingController species;
  late TextEditingController type;
  late TextEditingController gender;
  late TextEditingController origin;
  late TextEditingController location;

  @override
  void initState() {
    super.initState();
    final c = widget.character;
    name = TextEditingController(text: c.name);
    status = TextEditingController(text: c.status);
    species = TextEditingController(text: c.species);
    type = TextEditingController(text: c.type);
    gender = TextEditingController(text: c.gender);
    origin = TextEditingController(text: c.originName);
    location = TextEditingController(text: c.locationName);
  }

  @override
  void dispose() {
    name.dispose();
    status.dispose();
    species.dispose();
    type.dispose();
    gender.dispose();
    origin.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CharacterController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Character')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: status, decoration: const InputDecoration(labelText: 'Status')),
            TextField(controller: species, decoration: const InputDecoration(labelText: 'Species')),
            TextField(controller: type, decoration: const InputDecoration(labelText: 'Type')),
            TextField(controller: gender, decoration: const InputDecoration(labelText: 'Gender')),
            TextField(controller: origin, decoration: const InputDecoration(labelText: 'Origin name')),
            TextField(controller: location, decoration: const InputDecoration(labelText: 'Location name')),
            const SizedBox(height: 20),
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
                await ctrl.saveEdits(widget.character.id, edits);
                Get.back();
                Get.snackbar('Saved', 'Local edits saved');
              },
              child: const Text('Save edits locally'),
            ),
            TextButton(onPressed: () { Get.back(); }, child: const Text('Cancel')),
          ],
        ),
      ),
    );
  }
}
