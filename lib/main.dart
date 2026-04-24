import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/news/news_bloc.dart';
import 'blocs/language/language_bloc.dart';
import 'constants/app_themes.dart';
import 'l10n/app_localizations.dart';
import 'screens/auth_screen.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const NewsPortal());
}

class NewsPortal extends StatelessWidget {
  const NewsPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(LoadTheme()),
        ),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc()..add(LoadLanguage()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          final locale = languageState is LanguageLoaded
              ? languageState.locale
              : const Locale('en');

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              final isDark = themeState is ThemeLoaded
                  ? themeState.isDark
                  : false;

              return MaterialApp(
                title: 'News Portal',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English
                  Locale('ne', ''), // Nepali
                ],
                home: const AppShell(),
                routes: {
                  '/home': (context) => const AppShell(),
                  '/auth': (context) => const AuthScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
