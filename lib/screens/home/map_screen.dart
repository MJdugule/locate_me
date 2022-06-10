import 'package:flutter/material.dart';
import 'package:locate_me/models/theme_model.dart';
import 'package:locate_me/services/auth.dart';
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

          leading: ElevatedButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  themeNotifier.isDark ? Icons.nightlight : Icons.wb_sunny,
                  color: themeNotifier.isDark
                      ? Colors.blue.shade700
                      : Colors.orange,
                ),
                const SizedBox(height: 5),
                Text(
                  themeNotifier.isDark ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontSize: 8,
                    color: themeNotifier.isDark
                        ? Colors.blue.shade700
                        : Colors.orange,
                  ),
                ),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
            onPressed: () {
              themeNotifier.isDark
                  ? themeNotifier.isDark = false
                  : themeNotifier.isDark = true;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Authentication().logOut(context);
              },
              child: Text('Logout',
                  style: TextStyle(
                    fontSize: 14,
                    color: themeNotifier.isDark
                        ? Colors.blue.shade700
                        : Colors.orange,
                  )),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade300),
              ),
            ),
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
