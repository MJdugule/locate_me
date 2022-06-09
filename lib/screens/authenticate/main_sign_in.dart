import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:locate_me/services/auth.dart';
import 'package:locate_me/shared_constants/colors.dart';

class MainSignIn extends StatefulWidget {
  const MainSignIn({Key? key}) : super(key: key);

  @override
  State<MainSignIn> createState() => _MainSignInState();
}

class _MainSignInState extends State<MainSignIn> {
  Authentication google = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(tag: 'logo', child: Image.asset('assets/Logo.png')),
            const SizedBox(
              height: 250,
            ),
            Text('WELCOME', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            googleAuth(),
            facebookAuth()
          ],
        ),
      ),
    );
  }

  googleAuth() {
    return InkWell(
      onTap: ()async{
       await google.signInWithGoogle(context);
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 40,
          width: 250,
          decoration: const BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: const Center(
              child: Text(
            'Login with google',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: buttonColor, width: 5),
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: Colors.white),
            child: Image.asset(
              'assets/google.png',
              fit: BoxFit.fill,
            )),
      ]),
    );
  }
   facebookAuth() {
    return InkWell(
      onTap: ()async{
       await google.signInWithFacebook(context);
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      
        Container(
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: buttonColor, width: 5),
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: Colors.white),
            child: Image.asset(
              'assets/facebook.png', width: 65, height: 60,
              fit: BoxFit.contain,
            )),
              Container(
          height: 40,
          width: 250,
          decoration: const BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: const Center(
              child: Text(
            'Login with Facebook',
            style: TextStyle(color: Colors.white, fontSize: 20,  fontWeight: FontWeight.bold),
          )),
        ),
      ]),
    );
  }

  //facebookAuth() {}
}
