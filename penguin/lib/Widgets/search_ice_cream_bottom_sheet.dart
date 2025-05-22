import 'package:flutter/material.dart';
import 'package:penguin/models/ice_cream_model.dart';
import 'package:penguin/service/ice_cream_service.dart';
import 'package:penguin/widgets/ice/ice_cream_card_widget.dart';

class SearchIceCreamBottomSheet extends StatefulWidget {
  const SearchIceCreamBottomSheet({super.key});

  @override
  State<SearchIceCreamBottomSheet> createState() =>
      _SearchIceCreamBottomSheetState();
}

class _SearchIceCreamBottomSheetState
    extends State<SearchIceCreamBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<List<IceCream>> searchStream;

  @override
  void initState() {
    super.initState();
    searchStream = Stream.value([]);
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchStream = IceCreamService.streamSearchIceCreamByName(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск мороженого...',
              hintStyle: const TextStyle(
                color: Color.fromRGBO(84, 170, 242, 1),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color.fromRGBO(84, 170, 242, 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: _updateSearchQuery,
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color.fromRGBO(84, 170, 242, 1),
              ),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Назад"),
              onPressed: Navigator.of(context).pop,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: StreamBuilder<List<IceCream>>(
              stream: searchStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Ничего не найдено'));
                }

                return GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return IceCreamCard(iceCream: snapshot.data![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}