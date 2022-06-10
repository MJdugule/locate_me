import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:locate_me/screens/authenticate/main_sign_in.dart';
import 'package:locate_me/screens/home/map_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => MainSignIn())));});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Hero(tag: 'logo',child: Image.asset('assets/Logo.png')),),
    );
  }
}