import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zubair_onward_academy/viewmodel/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff151215), Color(0xff1E161E), Color(0xff574c0e)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated SVG Logo
              SvgPicture.asset('assets/images/zoalogo.svg', height: screenHeight * 0.2, width: screenWidth * 0.2,)
                  .animate() // Start animation
                  .fadeIn(duration: 1000.ms) // Fade in animation
                  .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 1000.ms) // Scale animation
                  .then(delay: 500.ms) // Delay before next animation
                  .shake(duration: 1000.ms) // Shake animation
                  .then(delay: 500.ms) // Delay before next animation
                  .slide(begin: const Offset(0, 0), end: const Offset(0, -0.5), duration: 1000.ms), // Slide up animation
            ],
          ),
        ),
      ),
    );
  }
}