import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_tile.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CharacterController ctrl;
  late final ScrollController scroll;
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(CharacterController());
    scroll = ScrollController();
    scroll.addListener(() {
      if (!scroll.hasClients) return;
      final maxExtent = scroll.position.maxScrollExtent;
      final pixels = scroll.position.pixels;
      if (maxExtent <= 0) return;
      if (pixels > maxExtent - 300 && !ctrl.isLoading.value && ctrl.hasMore.value) {
        ctrl.fetchNext();
      }
    });
  }

  @override
  void dispose() {
    scroll.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick & Morty'),
        actions: [
          IconButton(onPressed: () => Get.to(() => const FavoritesPage()), icon: const Icon(Icons.favorite))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: Container(
            height: 56.h,
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(hintText: 'Search by name', border: OutlineInputBorder()),
                      onChanged: (v) {
                        ctrl.setQuery(v);
                      },
                      onSubmitted: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                PopupMenuButton<String>(
                  onSelected: (s) => ctrl.setFilter(status: s == 'All' ? null : s),
                  itemBuilder: (_) => ['All', 'alive', 'dead', 'unknown']
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (ctrl.isError.value && ctrl.characters.isEmpty) {
          return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Failed to load'),
            ElevatedButton(onPressed: ctrl.loadInitial, child: const Text('Retry'))
          ]));
        }
        if (ctrl.characters.isEmpty && ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.characters.isEmpty) {
          return const Center(child: Text('No characters'));
        }
        return RefreshIndicator(
          onRefresh: ctrl.refresh,
          child: GridView.builder(
            controller: scroll,
            padding: EdgeInsets.all(8.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 0.62,
            ),
            itemCount: ctrl.characters.length + (ctrl.hasMore.value ? 1 : 0),
            itemBuilder: (context, i) {
              if (i >= ctrl.characters.length) {
                if (ctrl.isLoading.value) return Center(child: SizedBox(width: 24.w, height: 24.w, child: const CircularProgressIndicator()));
                return const SizedBox();
              }
              final c = ctrl.characters[i];
              return CharacterTile(character: c);
            },
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Characters'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        onTap: (i) {
          if (i == 1) {
            Get.to(() => const FavoritesPage());
            return;
          }
          setState(() => _selectedIndex = i);
        },
      ),
    );
  }
}
