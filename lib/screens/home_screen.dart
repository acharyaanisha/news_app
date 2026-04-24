import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/language/language_bloc.dart';
import '../l10n/app_localizations.dart';
import '../constants/app_constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppConstants.newsCategories.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedCategory = AppConstants.newsCategories[_tabController.index];
        context.read<NewsBloc>().add(
          LoadNewsByCategory(category: _selectedCategory),
        );
      });
    });

    // Load initial news
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final isDark = state is ThemeLoaded ? state.isDark : false;
              return IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              );
            },
          ),

          // Settings
          IconButton(
            onPressed: () => _showSettingsDialog(context),
            icon: const Icon(Icons.settings),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 8,
                ),
                child: CustomTextField(
                  controller: _searchController,
                  hintText: localizations.searchNews,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      context.read<NewsBloc>().add(SearchNews(query: query));
                    } else {
                      context.read<NewsBloc>().add(
                        LoadNewsByCategory(category: _selectedCategory),
                      );
                    }
                  },
                ),
              ),

              // Category Tabs
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: AppConstants.newsCategories.map((category) {
                  return Tab(text: localizations.getCategoryName(category));
                }).toList(),
              ),
            ],
          ),
        ),
      ),

      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            if (state.news.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.noNews,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsBloc>().add(
                  LoadNewsByCategory(category: _selectedCategory),
                );
              },
              child: ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final news = state.news[index];
                  return NewsCard(
                    news: news,
                    onTap: () => _navigateToNewsDetail(news),
                    onBookmarkTap: () {
                      context.read<NewsBloc>().add(
                        ToggleBookmark(newsId: news.id),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is NewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NewsBloc>().add(
                        LoadNewsByCategory(category: _selectedCategory),
                      );
                    },
                    child: Text(localizations.retry),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToNewsDetail(dynamic news) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news)),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.settings),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, languageState) {
                final currentLocale = languageState is LanguageLoaded
                    ? languageState.locale
                    : const Locale('en');
                return ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(localizations.language),
                  subtitle: Text(
                    currentLocale.languageCode == 'en' ? 'English' : 'Nepali',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showLanguageDialog(context);
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(localizations.logout),
              onTap: () {
                Navigator.of(context).pop();
                // Logout logic would be implemented here
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                context.read<LanguageBloc>().add(
                  const ChangeLanguage(Locale('en')),
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Nepali'),
              onTap: () {
                context.read<LanguageBloc>().add(
                  const ChangeLanguage(Locale('ne')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
