# Rick & Morty Explorer (GetX + Hive)

Simple Flutter app demonstrating:
- Paginated list from the Rick & Morty API
- Detail view
- Favorites persisted locally with Hive
- Local editable overrides that persist
- Offline-friendly page caching

Setup
1. Ensure Flutter stable SDK installed.
2. From project root run:

```bash
flutter pub get
flutter run
```

Notes
- State management: GetX (simple reactive controller).
- Storage: Hive boxes (`cache`, `edits`, `favorites`). No codegen required.
- If you want type adapters, add `hive_generator` + `build_runner` and generate adapters; not required here.
# rick_mortyflutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
