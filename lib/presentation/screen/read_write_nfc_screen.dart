import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:aavaz/presentation/widgets/dialogs.dart';

class ReadWriteNFCScreen extends StatelessWidget {
  const ReadWriteNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NFCNotifier()..announceWelcome(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("NFC Reader & Writer"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Consumer<NFCNotifier>(
          builder: (context, provider, _) {
            // ✅ Handle result dialog ONCE and safely
            if (provider.message.isNotEmpty && !provider.isProcessing) {
              final message = provider.message;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;

                Navigator.of(context, rootNavigator: true)
                    .popUntil((route) => route.isFirst);

                showResultDialog(context, message);

                provider.clearMessage(); // 🔑 prevents loop & crashes
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
                    onPressed: provider.isProcessing
                        ? null
                        : () {
                      scanningDialog(context);
                      context
                          .read<NFCNotifier>()
                          .startNFCOperation(
                        nfcOperation: NFCOperation.read,
                      );
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
                    onPressed: provider.isProcessing
                        ? null
                        : () {
                      scanningDialog(context);
                      context
                          .read<NFCNotifier>()
                          .startNFCOperation(
                        nfcOperation: NFCOperation.write,
                        // data: "Hello from Aavaz App!",
                      );
                    },
                    child: const Text("Write NFC Tag"),
                  ),

                  const SizedBox(height: 40),

                  if (provider.isProcessing)
                    const CircularProgressIndicator(color: Colors.white),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
