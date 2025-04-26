import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:aavaz/presentation/widgets/dialogs.dart';

class WriteNFCScreen extends StatelessWidget {
  const WriteNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
    TextEditingController(text: "Hello from Aavaz App!");

    return ChangeNotifierProvider(
      create: (context) => NFCNotifier(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Write NFC Tag"),
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

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Enter data to write',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      scanningDialog(context); // ✅ Show scanning dialog
                      Provider.of<NFCNotifier>(context, listen: false)
                        ..updateWriteContent(controller.text)
                        ..startNFCOperation(
                          nfcOperation: NFCOperation.write,
                        );
                    },
                    child: const Text("Write to Tag"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
