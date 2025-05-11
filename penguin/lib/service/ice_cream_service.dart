import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penguin/models/ice_cream_model.dart';

class IceCreamService {
  static const String basePath = 'ice_cream';

  // Получение всех мороженых из определённой группы (например, 'popular')
  static Future<List<IceCream>> getIceCreamsByGroup(String groupName) async {
    final collectionPath = '$basePath/$groupName/ice';
    try {
      final snapshot = await FirebaseFirestore.instance.collection(collectionPath).get();
      return snapshot.docs.map((doc) => IceCream.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      log('Ошибка при получении мороженого из группы $groupName: $e');
      return [];
    }
  }

  // Поиск мороженого по имени (во всех группах)
  static Future<List<IceCream>> searchIceCreamByName(String searchTerm) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('ice')
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
        .get();

    return querySnapshot.docs.map((doc) => IceCream.fromMap(doc.data(), doc.id)).toList();
  } catch (e) {
    log('Ошибка при поиске мороженого по имени: $e');
    return [];
  }
}

  // Реактивный поиск по имени
  static Stream<List<IceCream>> streamSearchIceCreamByName(String searchTerm) {
    return FirebaseFirestore.instance
        .collectionGroup('ice')
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => IceCream.fromMap(doc.data(), doc.id)).toList();
    });
  }
}