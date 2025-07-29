import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/domain/domain.dart';
import 'package:galactic_football_league/presentation/features/news/news.dart';
import 'package:galactic_football_league/presentation/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:galactic_football_league/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/locales.dart';

@RoutePage()
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        getNewsUseCase: GetIt.instance<GetNewsUseCase>(),
      )..add(LoadNews()),
      child: const NewsView(),
    );
  }
}

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.newsFeed.getString(context)),
        actions: [
          // Кнопка смены языка
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final localization = FlutterLocalization.instance;
              if (localization.currentLocale?.languageCode == 'en') {
                localization.translate('ru');
              } else {
                localization.translate('en');
              }
            },
          ),
          // Кнопка смены темы
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: Provider.of<ThemeProvider>(context),
        builder: (context, child) => Theme(
          data: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          child: child ?? SizedBox(),
        ),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NewsLoaded) {
              if (state.newsItems.isEmpty) {
                return Center(
                  child: Text(
                    AppLocale.noNews.getString(context),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.newsItems.length,
                itemBuilder: (context, index) {
                  final newsItem = state.newsItems[index];

                  final rawContent =
                      newsItem.contentTemplateKey.getString(context);
                  final formattedContent = rawContent
                      .replaceAll('{team1}', newsItem.team1Name)
                      .replaceAll('{team2}', newsItem.team2Name)
                      .replaceAll('{score1}', newsItem.score1.toString())
                      .replaceAll('{score2}', newsItem.score2.toString());

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsItem.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat.yMMMd().format(newsItem.date),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Divider(height: 24),
                          Text(
                            formattedContent,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is NewsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
