import 'package:flutter/foundation.dart';

class HistoryItem {
  final String action; // Read or Write
  final String content;
  final DateTime timestamp;

  HistoryItem({
    required this.action,
    required this.content,
    required this.timestamp,
  });
}

class HistoryNotifier extends ChangeNotifier {
  final List<HistoryItem> _history = [];

  List<HistoryItem> get history => List.unmodifiable(_history);

  void addHistory(String action, String content) {
    _history.add(HistoryItem(
      action: action,
      content: content,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
