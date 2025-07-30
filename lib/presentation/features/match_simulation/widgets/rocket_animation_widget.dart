import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../../../localization/locales.dart';

// Главный виджет анимации
class RocketAnimationWidget extends StatefulWidget {
  const RocketAnimationWidget({super.key});

  @override
  State<RocketAnimationWidget> createState() => _RocketAnimationWidgetState();
}

class _RocketAnimationWidgetState extends State<RocketAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _flightController;
  late AnimationController _clashController;

  late Animation<double> _flightAnimation;
  late Animation<double> _clashAnimation;

  @override
  void initState() {
    super.initState();
    // Контроллер полета ракет
    _flightController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _flightAnimation =
        CurvedAnimation(parent: _flightController, curve: Curves.easeInOut);

    // Контроллер вспышки при столкновении
    _clashController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _clashAnimation =
        CurvedAnimation(parent: _clashController, curve: Curves.easeOut);

    // Запускаем полет и после него - вспышку
    _flightController.forward().whenComplete(() {
      _clashController.forward();
    });
  }

  @override
  void dispose() {
    _flightController.dispose();
    _clashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocale.simulationInProgress.getString(context),
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 60),
        SizedBox(
          height: 150,
          child: AnimatedBuilder(
            animation: Listenable.merge([_flightAnimation, _clashAnimation]),
            builder: (context, child) {
              final flightProgress = _flightAnimation.value;
              final clashProgress = _clashAnimation.value;

              return Stack(
                alignment: Alignment.center,
                children: [
                  // Левая ракета
                  Positioned(
                    left: (MediaQuery.of(context).size.width / 2) * flightProgress - 50,
                    child: Transform.rotate(
                      angle: pi / 4,
                      child: CustomPaint(
                        size: const Size(60, 60),
                        painter: RocketPainter(
                          color: Colors.redAccent,
                          trailProgress: flightProgress,
                        ),
                      ),
                    ),
                  ),
                  // Правая ракета
                  Positioned(
                    right: (MediaQuery.of(context).size.width / 2) * flightProgress - 50,
                    child: Transform.rotate(
                      angle: -pi / 4,
                      child: Transform.scale(
                        scaleX: -1, // Отражаем по горизонтали
                        child: CustomPaint(
                          size: const Size(60, 60),
                          painter: RocketPainter(
                            color: Colors.blueAccent,
                            trailProgress: flightProgress,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Вспышка
                  if (clashProgress > 0)
                    Transform.scale(
                      scale: clashProgress * 3,
                      child: Opacity(
                        opacity: 1.0 - clashProgress,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellowAccent.withOpacity(0.8),
                                blurRadius: 40 * clashProgress,
                                spreadRadius: 20 * clashProgress,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// Отрисовщик ракеты
class RocketPainter extends CustomPainter {
  final Color color;
  final double trailProgress;

  RocketPainter({required this.color, required this.trailProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bodyPaint = Paint()..color = color;
    final Paint cockpitPaint = Paint()..color = Colors.white.withOpacity(0.8);
    final Paint trailPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.orange, Colors.yellow.withOpacity(0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width * trailProgress * 2, size.height));

    // След от двигателя
    if (trailProgress > 0.1) {
      final trailPath = Path()
        ..moveTo(size.width * 0.4, size.height * 0.9)
        ..lineTo(size.width * 0.6, size.height * 0.9)
        ..lineTo(size.width * 0.5, size.height + (40 * trailProgress))
        ..close();
      canvas.drawPath(trailPath, trailPaint);
    }

    // Корпус
    final bodyPath = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.8, size.height * 0.8)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);

    // Крылья
    final wingPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.5)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.1, size.height)
      ..close();
    canvas.drawPath(wingPath, bodyPaint);

    final wingPath2 = Path()
      ..moveTo(size.width * 0.9, size.height * 0.5)
      ..lineTo(size.width * 0.8, size.height * 0.8)
      ..lineTo(size.width * 0.9, size.height)
      ..close();
    canvas.drawPath(wingPath2, bodyPaint);

    // Иллюминатор
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4),
        size.width * 0.1, cockpitPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}