import 'package:flutter/material.dart';

class ReadNFCScreen extends StatelessWidget {
  const ReadNFCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read NFC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Start NFC read logic
              },
              icon: const Icon(Icons.wifi_tethering),
              label: const Text('Start Reading NFC'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hold your NFC card near the device',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
