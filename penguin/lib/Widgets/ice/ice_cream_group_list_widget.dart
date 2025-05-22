import 'package:flutter/material.dart';
import 'package:penguin/Widgets/ice/ice_cream_card_widget.dart';
import 'package:penguin/Widgets/loading_widget.dart';
import 'package:penguin/models/ice_cream_model.dart';
import 'package:penguin/service/ice_cream_service.dart';

class IceCreamGroupList extends StatefulWidget {
  final String groupName;

  const IceCreamGroupList({
    super.key,
    required this.groupName,
  });

  @override
  State<IceCreamGroupList> createState() => _IceCreamGroupListState();
}

class _IceCreamGroupListState extends State<IceCreamGroupList> {
  late Future<List<IceCream>> _iceCreamsFuture;

  @override
  void initState() {
    super.initState();
    _iceCreamsFuture = IceCreamService.getIceCreamsByGroup(widget.groupName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IceCream>>(
      future: _iceCreamsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingWidget());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        final iceCreams = snapshot.data ?? [];

        if (iceCreams.isEmpty) {
          return const Center(child: Text('Мороженое не найдено'));
        }

        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: iceCreams.length,
            itemBuilder: (context, index) {
              return IceCreamCard(iceCream: iceCreams[index]);
            },
          ),
        );
      },
    );
  }
}