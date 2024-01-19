import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_surveillance_system/Auth/MainPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Main_Page()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Video Surveillance \n         System",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                  // style: TextStyle(
                  //   fontSize: 38.0,
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.white,
                  //   letterSpacing: 2.0,
                  //   shadows: [
                  //     Shadow(
                  //       color: Colors.black,
                  //       blurRadius: 4,
                  //       offset: Offset(2, 2),
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
            Center(
                // child: Lottie.asset('animations/animation_lnq1scwe.json',
                //     height: 400, width: 400, repeat: true, reverse: true),
                ),
          ],
        ),
      ),
    );
  }
}
