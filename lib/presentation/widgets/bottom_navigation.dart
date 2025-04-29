import 'package:flutter/material.dart';
import 'package:aavaz/presentation/screen/read_nfc_screen.dart';
import 'package:aavaz/presentation/screen/write_nfc_screen.dart';
import 'package:aavaz/presentation/screen/history_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ReadNFCScreen(),
    const WriteNFCScreen(),
    const HistoryScreen(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi_tethering), // Read icon
            label: 'Read',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note), // Write icon
            label: 'Write',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history), // History icon
            label: 'History',
          ),
        ],
      ),
    );
  }
}
