# Rick & Morty Explorer

An offline-friendly Flutter app to browse, search, and favorite Rick & Morty characters. Built with GetX for state management and Hive for local storage.

## Features

- **Paginated character list** from the [Rick & Morty API](https://rickandmortyapi.com/)
- **Detail view** for each character (with editable fields)
- **Favorites**: Mark/unmark characters as favorites, persisted locally
- **Offline support**: Caches pages and character data for offline browsing
- **Local edits**: Edit character details locally (persisted in Hive)
- **Search & filter**: By name, status, and species

---

## Setup Instructions

1. **Install Flutter** (stable channel): [Flutter Install Guide](https://docs.flutter.dev/get-started/install)
2. **Clone this repo** and open the project root
3. **Install dependencies:**
	 ```bash
	 flutter pub get
	 ```
4. **Run the app:**
	 ```bash
	 flutter run
	 ```

---

## State Management Choice

**GetX** is used for state management. GetX provides a simple, reactive, and lightweight approach to managing state, navigation, and dependency injection. It enables:
- Reactive UI updates with minimal boilerplate
- Easy controller lifecycle management
- Clean separation of logic and UI

**Why GetX?**
- Minimal code for reactivity
- No context required for navigation or state
- Well-suited for small/medium apps needing fast development

---

## Storage Approach

**Hive** is used for local storage. Three boxes are used:
- `cache`: Stores paginated API responses and character data for offline access
- `edits`: Stores local edits to character fields (overrides API data)
- `favorites`: Stores a list of favorite character IDs

**Why Hive?**
- Fast, lightweight, and easy to use
- No code generation required for simple dynamic storage
- Works well for key-value and list storage patterns

---

## App Review

This app demonstrates a robust Flutter architecture for consuming a REST API with offline support and local data overrides. Key highlights:

- **Architecture:**
	- `GetX` controllers manage API fetching, pagination, search, and local state
	- `HiveService` abstracts all local storage logic
	- UI is split into screens (home, detail, favorites) and widgets (character tile)

- **Offline-first:**
	- All fetched pages and characters are cached
	- If API is unreachable, cached data is shown
	- Local edits and favorites persist regardless of connectivity

- **User Experience:**
	- Infinite scroll with smooth pagination
	- Search and filter with instant feedback
	- Favorites and edits update UI reactively
	- Responsive design using `flutter_screenutil`

- **Extensibility:**
	- Easy to add new filters or fields
	- Storage can be migrated to type-safe Hive adapters if needed

---

## Folder Structure

- `lib/feature/controllers/` – GetX controllers (business logic)
- `lib/feature/models/` – Data models
- `lib/feature/services/` – API and Hive service classes
- `lib/feature/screen/` – UI screens (home, detail, favorites)
- `lib/feature/widgets/` – Reusable widgets

---

## Credits

- [Rick & Morty API](https://rickandmortyapi.com/)
- [GetX](https://pub.dev/packages/get)
- [Hive](https://pub.dev/packages/hive)

---

_Made with Flutter ❤️_
