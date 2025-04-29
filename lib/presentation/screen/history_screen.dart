import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/history_notifier.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryNotifier>().history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              context.read<HistoryNotifier>().clearHistory();
            },
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            leading: Icon(
              item.action == 'Read' ? Icons.wifi_tethering : Icons.edit_note,
              color: item.action == 'Read' ? Colors.blue : Colors.green,
            ),
            title: Text('${item.action}: ${item.content}'),
            subtitle: Text(item.timestamp.toString()),
          );
        },
      ),
    );
  }
}
