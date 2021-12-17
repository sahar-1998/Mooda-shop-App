import 'package:Modda_shop/prefs/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
     String route = SharedPrefController().loggedIn ? '/OnBoarding': '/Sign_in';
     Navigator.pushReplacementNamed(context, route);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/launch.png',
            fit: BoxFit.fitHeight,
            height: double.infinity,
          ),

          const Padding(
            padding:  EdgeInsets.only(top: 580, left: 85, right: 80),
            child: Text(
              'MOODA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
