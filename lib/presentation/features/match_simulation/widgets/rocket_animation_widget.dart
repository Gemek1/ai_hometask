import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../../../localization/locales.dart';

class RocketAnimationWidget extends StatefulWidget {
  const RocketAnimationWidget({super.key});

  @override
  State<RocketAnimationWidget> createState() => _RocketAnimationWidgetState();
}

class _RocketAnimationWidgetState extends State<RocketAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation1 = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animation2 = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: const Offset(0.2, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocale.simulationInProgress.getString(context),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SlideTransition(
                position: _animation1,
                child: Image.asset('assets/images/rocket_1.png', height: 60),
              ),
              SlideTransition(
                position: _animation2,
                child: Transform.flip(
                  flipX: true,
                  child: Image.asset('assets/images/rocket_2.png', height: 60),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}