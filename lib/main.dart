import 'package:flutter/material.dart';
import 'package:locate_me/models/theme_model.dart';
import 'package:locate_me/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'Locate Me',
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            home: Wrapper(),
          );
        },
      ),
    );
  }
}
