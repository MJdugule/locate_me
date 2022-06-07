import 'package:flutter/material.dart';
import 'package:locate_me/screens/home/map_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // returning only map screen for now
    return const MapScreen();
  }
}
