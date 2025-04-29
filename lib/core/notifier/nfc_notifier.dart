import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/history_notifier.dart';

enum NFCOperation { read, write }

class NFCNotifier extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool isProcessing = false;
  String message = '';
  String writeContent = '';

  void announceWelcome() {
    _flutterTts.speak("Welcome to the NFC App");
  }

  Future<void> startNFCOperation({
    required NFCOperation nfcOperation,
    required context, // pass context for history
  }) async {
    isProcessing = true;
    message = '';
    notifyListeners();

    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) {
        message = 'NFC is not available on this device';
        isProcessing = false;
        notifyListeners();
        return;
      }

      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        if (ndef == null) {
          message = 'NDEF not supported on this tag';
        } else if (!ndef.isWritable && nfcOperation == NFCOperation.write) {
          message = 'Tag is not writable';
        } else {
          if (nfcOperation == NFCOperation.read) {
            final cachedMessage = ndef.cachedMessage;
            if (cachedMessage != null && cachedMessage.records.isNotEmpty) {
              message = cachedMessage.records.first.payload
                  .skip(3)
                  .map((e) => String.fromCharCode(e))
                  .join();
              await _flutterTts.speak(message);
              Provider.of<HistoryNotifier>(context, listen: false)
                  .addHistory('Read', message);
            } else {
              message = 'No data found on tag';
            }
          } else {
            await ndef.write(
              NdefMessage([
                NdefRecord.createText(writeContent),
              ]),
            );
            message = 'Data written: $writeContent';
            await _flutterTts.speak("Data written successfully");
            Provider.of<HistoryNotifier>(context, listen: false)
                .addHistory('Write', writeContent);
          }
        }
        isProcessing = false;
        notifyListeners();
        NfcManager.instance.stopSession();
      });
    } catch (e) {
      message = 'Error: $e';
      isProcessing = false;
      notifyListeners();
      NfcManager.instance.stopSession(errorMessage: e.toString());
    }
  }

  void updateWriteContent(String content) {
    writeContent = content;
  }
}
