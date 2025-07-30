import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_football_league/navigation/app_router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Временная заглушка для логики авторизации
  void _login(BuildContext context) {
    // Здесь должна быть проверка по локальному списку
    context.router.replace(const MainRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.shield_moon, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Вход в Лигу',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text('Войти'),
            ),
            TextButton(
              onPressed: () => _login(context),
              child: const Text('Продолжить как гость'),
            ),
          ],
        ),
      ),
    );
  }
}