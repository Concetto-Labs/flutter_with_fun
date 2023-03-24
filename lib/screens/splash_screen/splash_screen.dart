import 'package:filter_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:filter_app/common/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delayNext();
  }

  void delayNext() async {
    await Future.delayed(const Duration(seconds: 6)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size info = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.splashLogo,
          fit: BoxFit.fill,
          // height: info.height,
          // width: info.width,
        ),
      ),
    );
  }
}
