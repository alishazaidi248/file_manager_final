
import 'package:filemanager/settings.dart';
import 'package:flutter/material.dart';

import 'archive.dart';
import 'home.dart';
import 'main.dart';

class Securefile extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  Securefile({required this.onThemeChanged});

  Type currentPageType = Securefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Files'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nothing Saved In Your Secure Files :/ '),

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
            label: 'archive',
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