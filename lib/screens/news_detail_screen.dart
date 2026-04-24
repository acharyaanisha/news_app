import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news.dart';
import '../blocs/news/news_bloc.dart';
import '../constants/app_constants.dart';
import '../constants/app_themes.dart';
import '../l10n/app_localizations.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late News currentNews;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    currentNews = widget.news;
    isBookmarked = widget.news.isBookmarked;
  }

  Future<void> _launchUrl(String url) async {
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Could not open URL')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _toggleBookmark() {
    context.read<NewsBloc>().add(ToggleBookmark(newsId: currentNews.id));
    setState(() {
      isBookmarked = !isBookmarked;
      currentNews = currentNews.copyWith(isBookmarked: !isBookmarked);
    });
  }

  void _shareNews() {
    // final text =
    //     '${currentNews.title}\n\n${currentNews.description}\n\nRead more: ${currentNews.link}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('News shared!'),
        action: SnackBarAction(label: 'Copy', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            elevation: 0,
            backgroundColor: theme.colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: currentNews.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: currentNews.imageUrl,
                      fit: BoxFit.cover,

                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Center(child: CircularProgressIndicator()),
                      ),

                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.article,
                        size: 64,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? Colors.black54 : Colors.white.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black54 : Colors.white.withAlpha(200),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? theme.colorScheme.primary : null,
                  ),
                  onPressed: _toggleBookmark,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black54 : Colors.white.withAlpha(200),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: _shareNews,
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          AppColors.categoryColors[currentNews.category] ??
                          theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getCategoryDisplayName(currentNews.category),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    currentNews.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Source Info Row
                  Row(
                    children: [
                      if (currentNews.sourceIcon.isNotEmpty)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: currentNews.sourceIcon,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.newspaper,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentNews.sourceName,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _formatDate(currentNews.publishedAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Divider
                  Divider(color: theme.colorScheme.onSurfaceVariant),

                  const SizedBox(height: 16),

                  // Author
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 20,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'By ${currentNews.author}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description/Content
                  Text(
                    'Description',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    currentNews.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 24),

                  // Read Full Article Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl(currentNews.link),
                      icon: const Icon(Icons.open_in_browser),
                      label: Text(localizations.readMore),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Related Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Article Info',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          theme,
                          Icons.visibility,
                          'Views',
                          _formatViews(currentNews.views),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          theme,
                          Icons.bookmark,
                          'Status',
                          isBookmarked ? 'Bookmarked' : 'Not bookmarked',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          theme,
                          Icons.category,
                          'Category',
                          _getCategoryDisplayName(currentNews.category),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
      case 'crime':
        return 'Crime';
      case 'business':
        return 'Business';
      case 'top':
        return 'Top News';
      default:
        return category.replaceFirst(category[0], category[0].toUpperCase());
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    } else {
      return views.toString();
    }
  }
}
