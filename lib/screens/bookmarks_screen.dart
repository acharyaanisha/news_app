import 'package:flutter/material.dart';
import '../widgets/news_card.dart';
import '../models/news.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleBookmarkedNews = <News>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: false,
        elevation: 0,
      ),
      body: sampleBookmarkedNews.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 80,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No saved articles yet',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap the bookmark icon on an article to save it here for later.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: sampleBookmarkedNews.length,
              itemBuilder: (context, index) {
                final news = sampleBookmarkedNews[index];
                return NewsCard(news: news, onTap: () {}, onBookmarkTap: () {});
              },
            ),
    );
  }
}
