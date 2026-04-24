import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String author;
  final DateTime publishedAt;
  final String sourceName;
  final String sourceIcon;
  final String link;
  final int views;
  final bool isBookmarked;

  const News({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.author,
    required this.publishedAt,
    required this.sourceName,
    required this.sourceIcon,
    required this.link,
    this.views = 0,
    this.isBookmarked = false,
  });

  News copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    String? author,
    DateTime? publishedAt,
    String? sourceName,
    String? sourceIcon,
    String? link,
    int? views,
    bool? isBookmarked,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      sourceName: sourceName ?? this.sourceName,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      link: link ?? this.link,
      views: views ?? this.views,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  factory News.fromJson(Map<String, dynamic> json) {
    final categories = json['category'] as List<dynamic>?;
    String category = 'general';
    if (categories != null && categories.isNotEmpty) {
      category = categories[0].toString();
    }

    final creators = json['creator'] as List<dynamic>?;
    String author = 'Unknown';
    if (creators != null && creators.isNotEmpty) {
      author = creators[0].toString();
    }

    return News(
      id: json['article_id'] as String? ?? json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'No Title',
      description:
          json['description'] as String? ?? json['summary'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      category: category,
      author: author,
      publishedAt: json['pubDate'] != null
          ? DateTime.parse(json['pubDate'] as String)
          : DateTime.now(),
      sourceName: json['source_name'] as String? ?? 'Unknown Source',
      sourceIcon: json['source_icon'] as String? ?? '',
      link: json['link'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'category': category,
      'creator': author,
      'pubDate': publishedAt.toIso8601String(),
      'source_name': sourceName,
      'source_icon': sourceIcon,
      'link': link,
      'views': views,
      'isBookmarked': isBookmarked,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    category,
    author,
    publishedAt,
    sourceName,
    sourceIcon,
    link,
    views,
    isBookmarked,
  ];
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;
  final List<String> preferences;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    this.preferences = const [],
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    List<String>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      preferences: preferences ?? this.preferences,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      preferences: List<String>.from(json['preferences'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'preferences': preferences,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    profileImageUrl,
    preferences,
  ];
}
