import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteNFCScreen extends StatelessWidget {
  const WriteNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nfcNotifier = Provider.of<NFCNotifier>(context);
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Write NFC'),
      ),
      body: Center(
        child: nfcNotifier.isProcessing
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Text to Write',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit_note),
                label: const Text('Write to NFC'),
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    nfcNotifier
                      ..updateWriteContent(controller.text.trim())
                      ..startNFCOperation(
                        context: context,
                        nfcOperation: NFCOperation.write,
                      );
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                nfcNotifier.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
