import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:penguin/models/ice_cream_model.dart';

class IceCreamService {
  static const String basePath = 'ice_cream';

  // Получение мороженого по группе
  static Future<List<IceCream>> getIceCreamsByGroup(String groupName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('$basePath/$groupName/ice')
          .get();
      return snapshot.docs
          .map((doc) => IceCream.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      log('Error getting ice creams: $e');
      return [];
    }
  }

static Stream<List<IceCream>> streamSearchIceCreamByName(String searchTerm) {
  final String query = searchTerm.trim().toLowerCase();

  if (query.isEmpty || query.length < 2) {
    return Stream.value([]);
  }

  try {
    return FirebaseFirestore.instance
        .collectionGroup('ice')
        .snapshots()
        .map((snapshot) {
      // Получаем все документы
      final List<IceCream> results = snapshot.docs
          .map((doc) => IceCream.fromMap(doc.data(), doc.id))
          .toList();

      // Фильтруем на стороне Dart по частичному совпадению
      final List<IceCream> filtered = results
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      debugPrint("Всего товаров в базе: ${results.length}");
      debugPrint("Найдено по запросу '$query': ${filtered.length}");

      return filtered;
    });
  } catch (e) {
    log('Error creating search stream: $e');
    return Stream.value([]);
  }
}

  // Поиск по имени (разовый запрос)
  static Future<List<IceCream>> searchIceCreamByName(String searchTerm) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('ice')
          .orderBy('name')
          .startAt([searchTerm])
          .endAt(['$searchTerm\uf8ff'])
          .get();

      return querySnapshot.docs
          .map((doc) => IceCream.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      log('Ошибка при поиске мороженого по имени: $e');
      return [];
    }
  }
}