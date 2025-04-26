import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:aavaz/presentation/widgets/dialogs.dart';

class ReadNFCScreen extends StatelessWidget {
  const ReadNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier()..announceWelcome(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Read NFC Tag"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Consumer<NFCNotifier>(
          builder: (context, provider, _) {
            if (provider.message.isNotEmpty && !provider.isProcessing) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                showResultDialog(context, provider.message);
              });
            }

            return Center(
              child: ElevatedButton(
                onPressed: () {
                  scanningDialog(context); // ✅ Show scanning dialog
                  Provider.of<NFCNotifier>(context, listen: false)
                      .startNFCOperation(nfcOperation: NFCOperation.read);
                },
                child: const Text("Scan to Read"),
              ),
            );
          },
        ),
      ),
    );
  }
}
