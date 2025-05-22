import 'package:flutter/material.dart';

// Глобальный notifier для поискового запроса
final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');