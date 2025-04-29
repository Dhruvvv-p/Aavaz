import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadNFCScreen extends StatelessWidget {
  const ReadNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nfcNotifier = Provider.of<NFCNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read NFC'),
      ),
      body: Center(
        child: nfcNotifier.isProcessing
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.wifi_tethering),
              label: const Text('Start Reading NFC'),
              onPressed: () {
                nfcNotifier.startNFCOperation(
                  context: context,
                  nfcOperation: NFCOperation.read,
                );
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
    );
  }
}
