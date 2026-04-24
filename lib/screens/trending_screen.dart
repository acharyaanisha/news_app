import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  // Sample trending topics
  final List<Map<String, dynamic>> trendingTopics = [
    {
      'name': 'Joe Biden',
      'initials': 'JB',
      'views': '12.4k',
      'color': const Color(0xFF1E88E5),
    },
    {
      'name': 'Demi Lovato',
      'initials': 'DL',
      'views': '8.4k',
      'color': const Color(0xFFE91E63),
    },
    {
      'name': 'Billie Eilish',
      'initials': 'BE',
      'views': '6.4k',
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'D Trump',
      'initials': 'DT',
      'views': '10.4k',
      'color': const Color(0xFFF57C00),
    },
    {
      'name': 'Dua Lipa',
      'initials': 'DL',
      'views': '5.4k',
      'color': const Color(0xFF00BCD4),
    },
    {
      'name': 'Elliot Page',
      'initials': 'EP',
      'views': '1.4k',
      'color': const Color(0xFF4CAF50),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Topics Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Trending Topics',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Main trending in center
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        trendingTopics[0]['color'],
                        trendingTopics[0]['color'].withAlpha(150),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: trendingTopics[0]['color'].withAlpha(100),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        trendingTopics[0]['initials'],
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        trendingTopics[0]['name'],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${trendingTopics[0]['views']} views',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Surrounding trending items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: trendingTopics.length - 1,
                itemBuilder: (context, index) {
                  final topic = trendingTopics[index + 1];
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [topic['color'], topic['color'].withAlpha(150)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: topic['color'].withAlpha(80),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${topic['name']} - ${topic['views']}',
                              ),
                            ),
                          );
                        },
                        customBorder: const CircleBorder(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              topic['initials'],
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                topic['name'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${topic['views']} views',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Top News Categories
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Trending Categories',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4,
                  mainAxisSpacing: 8,
                ),
                itemCount: [
                  'Politics',
                  'Sports',
                  'Technology',
                  'Health',
                ].length,
                itemBuilder: (context, index) {
                  final categories = [
                    'Politics',
                    'Sports',
                    'Technology',
                    'Health',
                  ];
                  final category = categories[index];
                  final colors = [
                    const Color(0xFF1E88E5),
                    const Color(0xFFF57C00),
                    const Color(0xFF00BCD4),
                    const Color(0xFF4CAF50),
                  ];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [colors[index], colors[index].withAlpha(150)],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white70),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
