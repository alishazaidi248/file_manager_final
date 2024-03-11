
import 'package:flutter/material.dart';

import 'archive.dart';
import 'home.dart';

class SettingsPage extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  SettingsPage({required this.onThemeChanged});

  Type currentPageType = SettingsPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('select ur theme: '),
            Switch(
              activeColor: Colors.red,
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                onThemeChanged(value);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archive',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.red),
        onTap: (int index) {
          if (index == 0 && currentPageType != MyHomePage) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1 && currentPageType != SettingsPage) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(onThemeChanged: onThemeChanged),
              ),
            );
          } else if (index == 2 && currentPageType != archive) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => archive(onThemeChanged: onThemeChanged),
              ),
            );
          }
        },
      ),
    );
  }
}