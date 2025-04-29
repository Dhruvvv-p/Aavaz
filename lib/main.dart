import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aavaz/core/notifier/nfc_notifier.dart';
import 'package:aavaz/core/notifier/history_notifier.dart';
import 'package:aavaz/presentation/widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NFCNotifier()),
        ChangeNotifierProvider(create: (_) => HistoryNotifier()),
      ],
      child: MaterialApp(
        title: 'Aavaz NFC App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.deepPurpleAccent,
            unselectedItemColor: Colors.grey,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const BottomNavigationScreen(),
      ),
    );
  }
}
