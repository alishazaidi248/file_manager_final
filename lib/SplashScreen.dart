
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  SplashScreen({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage(
              image: NetworkImage(
                'https://th.bing.com/th/id/OIG1.dmawXtuNjyWCJpVa.zN2?w=270&h=270&c=6&r=0&o=5&dpr=1.5&pid=ImgGn',
              ),
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              width: 270,
              height: 270,
              fadeOutDuration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}