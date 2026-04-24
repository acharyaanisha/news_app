import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news/news_bloc.dart';
import '../l10n/app_localizations.dart';
import '../constants/app_constants.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.categories),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse Categories',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemCount: AppConstants.newsCategories.length,
                    itemBuilder: (context, index) {
                      final category = AppConstants.newsCategories[index];
                      final isSelected = _selectedCategory == category;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                          context.read<NewsBloc>().add(
                            LoadNewsByCategory(category: category),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Stack(
                            children: [
                              // Background gradient
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      isSelected
                                          ? theme.colorScheme.primary.withAlpha(
                                              200,
                                            )
                                          : theme.colorScheme.onSurfaceVariant
                                                .withValues(alpha: 0.4),
                                      isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.surface,
                                    ],
                                  ),
                                ),
                              ),
                              // Content
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _getCategoryIcon(category),
                                      size: 32,
                                      color: isSelected
                                          ? Colors.white
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _getCategoryDisplayName(category),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : theme
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // News List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Latest in ${_getCategoryDisplayName(_selectedCategory)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is NewsLoaded) {
                  if (state.news.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No news available',
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final news = state.news[index];
                      return NewsCard(
                        news: news,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(news: news),
                          ),
                        ),
                        onBookmarkTap: () {
                          context.read<NewsBloc>().add(
                            ToggleBookmark(newsId: news.id),
                          );
                        },
                      );
                    },
                  );
                } else if (state is NewsError) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Column(
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
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'political':
        return 'Political';
      case 'economic':
        return 'Economic';
      case 'sports':
        return 'Sports';
      case 'technology':
        return 'Technology';
      case 'entertainment':
        return 'Entertainment';
      case 'health':
        return 'Health';
      case 'education':
        return 'Education';
      case 'all':
        return 'All News';
      default:
        return category;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'political':
        return Icons.how_to_vote;
      case 'economic':
        return Icons.trending_up;
      case 'sports':
        return Icons.sports_soccer;
      case 'technology':
        return Icons.computer;
      case 'entertainment':
        return Icons.movie;
      case 'health':
        return Icons.health_and_safety;
      case 'education':
        return Icons.school;
      case 'all':
        return Icons.newspaper;
      default:
        return Icons.article;
    }
  }
}
