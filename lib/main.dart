import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/navigation/app_router.dart';
import 'package:galactic_football_league/presentation/theme/theme_provider.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import 'core/di/dependency_injection.dart' as di;
import 'localization/locales.dart';
import 'presentation/theme/app_theme.dart';

Future<void> main() async {
  // 1. Ensure the Flutter binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();

  // 2. Initialize async services like Hive and DI first.
  await di.init();

  // 3. Now, initialize the localization package synchronously after all awaits.
  final FlutterLocalization localization = FlutterLocalization.instance;
  localization.init(
    mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('ru', AppLocale.RU),
    ],
    initLanguageCode: 'en',
  );

  // 4. Finally, run the app.
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  final _appRouter = GetIt.instance<AppRouter>();

  @override
  void initState() {
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Galactic Football League',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: _appRouter.config(),
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
          );
        },
      ),
    );
  }
}
