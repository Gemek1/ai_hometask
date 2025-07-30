import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_football_league/navigation/app_router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rocket_launch, size: 80),
            SizedBox(height: 20),
            Text('Galactic Football League', style: TextStyle(fontSize: 24)),
            SizedBox(height: 40),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}