import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:aavaz/presentation/widgets/dialogs.dart';

class ReadWriteNFCScreen extends StatelessWidget {
  const ReadWriteNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier()..announceWelcome(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("NFC Reader & Writer"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Builder(
          builder: (context) {
            return Consumer<NFCNotifier>(
              builder: (context, provider, _) {
                if (provider.message.isNotEmpty && !provider.isProcessing) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    showResultDialog(context, provider.message);
                  });
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          minimumSize: const Size(250, 60),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          scanningDialog(context);
                          Provider.of<NFCNotifier>(context, listen: false)
                              .startNFCOperation(nfcOperation: NFCOperation.read);
                        },
                        child: const Text("Read NFC Tag"),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          minimumSize: const Size(250, 60),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          scanningDialog(context);
                          Provider.of<NFCNotifier>(context, listen: false)
                              .startNFCOperation(
                            nfcOperation: NFCOperation.write,
                            data: "Hello from Aavaz App!",
                          );
                        },
                        child: const Text("Write NFC Tag"),
                      ),
                      const SizedBox(height: 40),
                      if (provider.isProcessing) const CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}