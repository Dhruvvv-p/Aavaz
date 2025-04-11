import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

import 'package:flutter_tts/flutter_tts.dart';

enum NFCOperation { read, write }

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  String _message = "";
  final FlutterTts _flutterTts = FlutterTts();

  bool get isProcessing => _isProcessing;
  String get message => _message;

  void announceWelcome() {
    _speak("Welcome to Aavaz. Tap Read or Write to interact with an NFC tag.");
  }

  Future<void> startNFCOperation({required NFCOperation nfcOperation, String? data}) async {
    try {
      _isProcessing = true;
      notifyListeners();

      bool isAvailable = await NfcManager.instance.isAvailable();

      if (!isAvailable) {
        _isProcessing = false;
        _message = "NFC is not available. Please enable it in settings.";
        notifyListeners();
        return;
      }

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          if (nfcOperation == NFCOperation.read) {
            await _readFromTag(tag);
          } else if (nfcOperation == NFCOperation.write && data != null) {
            await _writeToTag(tag, data);
          }

          _isProcessing = false;
          notifyListeners();
          await NfcManager.instance.stopSession();
        },
        onError: (error) async {
          _isProcessing = false;
          _message = "NFC Error: $error";
          notifyListeners();
        },
      );
    } catch (e) {
      _isProcessing = false;
      _message = "Error: $e";
      notifyListeners();
    }
  }

  Future<void> _readFromTag(NfcTag tag) async {
    try {
      final ndef = Ndef.from(tag);
      if (ndef == null || ndef.cachedMessage == null) {
        _message = "No readable data found.";
      } else {
        final record = ndef.cachedMessage!.records.first;
        final decodedText = utf8.decode(record.payload.sublist(3)); // Skips language code
        _message = decodedText;
        await _speak(decodedText);
      }
    } catch (e) {
      _message = "Error reading tag: $e";
    }
    notifyListeners();
  }

  Future<void> _writeToTag(NfcTag tag, String data) async {
    try {
      final ndef = Ndef.from(tag);
      if (ndef != null && ndef.isWritable) {
        final message = NdefMessage([NdefRecord.createText(data)]);
        await ndef.write(message);
        _message = "Write successful!";
      } else {
        final formatable = NdefFormatable.from(tag);
        if (formatable != null) {
          final message = NdefMessage([NdefRecord.createText(data)]);
          await formatable.format(message);
          _message = "Tag formatted and written successfully!";
        } else {
          _message = "Tag is not writable or not formatable.";
        }
      }
    } catch (e) {
      _message = "Error writing tag: $e";
    }
    notifyListeners();
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("hi-IN");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }
}
