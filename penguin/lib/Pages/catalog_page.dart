import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/search_ice_cream_bottom_sheet.dart';
import 'package:penguin/widgets/bottom_bar_widget.dart';
import 'package:penguin/widgets/ice/ice_cream_group_list_widget.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late ScrollController _scrollController;

  final List<Map<String, dynamic>> categories = [
    {'label': 'Популярное', 'id': 'popular'},
    {'label': 'Премиум', 'id': 'premium'},
    {'label': 'Пломбир', 'id': 'plombir'},
    {'label': 'Эскимо', 'id': 'plombir'},
    {'label': 'Фрукт. лед', 'id': 'premium'},
  ];

  String selectedCategoryId = 'popular';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const FractionallySizedBox(
          heightFactor: 0.9,
          child: SearchIceCreamBottomSheet(),
        );
      },
    );
  }

  void _scrollToCategory(String categoryId) {
    final offsets = {
      'popular': 0.0,
      'premium': 500.0,
      'plombir': 1000.0,
      'eskimoe': 1500.0,
      'fruit_ice': 2000.0,
    };

    _scrollController.animateTo(
      offsets[categoryId] ?? 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    setState(() {
      selectedCategoryId = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        leftText: '',
        rightText: '',
        showSignOutButton: true,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onTap: () => _showSearchBottomSheet(context),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Поиск мороженого',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(84, 170, 242, 0.5)),
                  prefixIcon: Icon(Icons.search,
                      color: Color.fromRGBO(84, 170, 242, 0.5)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            floating: true,
            backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isActive = selectedCategoryId == category['id'];

                  return Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: isActive
                            ? const Color.fromRGBO(84, 170, 242, 1)
                            : const Color.fromRGBO(84, 170, 242, 0.5),
                      ),
                      label: Text(
                        category['label'],
                        style: TextStyle(
                          color: isActive
                              ? const Color.fromRGBO(84, 170, 242, 1)
                              : const Color.fromRGBO(84, 170, 242, 0.5),
                        ),
                      ),
                      icon: const SizedBox.shrink(),
                      onPressed: () =>
                          _scrollToCategory(category['id']),
                    ),
                  );
                },
              ),
            ),
          ),
          ...categories.map(
            (category) => SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      category['label'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IceCreamGroupList(groupName: category['id']),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}