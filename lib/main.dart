import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locate_me/models/theme_model.dart';
import 'package:locate_me/screens/wrapper.dart';
import 'package:locate_me/shared_constants/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            color: buttonColor,
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            home: Wrapper(),
          );
        },
      ),
    );
  }
}
