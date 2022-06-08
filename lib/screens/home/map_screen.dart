import 'package:flutter/material.dart';
import 'package:locate_me/models/theme_model.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
          // centerTitle: true,
          elevation: 0,
          actions: [
            SizedBox(
              width: 100,
              child: ElevatedButton.icon(
                label: Text(
                  themeNotifier.isDark ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    color: themeNotifier.isDark
                        ? Colors.blue.shade700
                        : Colors.orange,
                  ),
                ),
                icon: Icon(
                  themeNotifier.isDark ? Icons.nightlight : Icons.wb_sunny,
                  color: themeNotifier.isDark
                      ? Colors.blue.shade700
                      : Colors.orange,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                ),
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                },
              ),
            )
          ],
        ),
        body: const SafeArea(
          child: Text('Map Screen stuff goes here',
              style: TextStyle(fontSize: 24)),
        ),
      );
    });
  }
}
