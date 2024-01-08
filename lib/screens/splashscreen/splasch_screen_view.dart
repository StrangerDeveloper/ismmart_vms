import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInView()),
            (Route<dynamic> route) => false));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
              )
                  .animate()
                  .slideY(begin: -0.9, end: 0.5, duration: 0.9.seconds)
                  .then(delay: 200.milliseconds)
                  // .slideY(end: -0.5, duration: 0.9.seconds)
                  // .then(delay: 200.milliseconds)
                  .slideY(end: -0.5, duration: 0.5.seconds)
                  .then(delay: 1.seconds)
                  .scaleXY(end: 20, duration: 2.seconds)
                  .then(delay: 2.seconds),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/ismartsplashscreen.png")
                .animate()
                .fadeIn(delay: 2.seconds, duration: 900.milliseconds)
                .slideX(begin: 3, duration: .5.seconds),
          ),
        ],
      ),
    );
  }
}
