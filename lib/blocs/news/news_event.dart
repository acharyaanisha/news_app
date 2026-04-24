part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {}

class LoadNewsByCategory extends NewsEvent {
  final String category;

  const LoadNewsByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class SearchNews extends NewsEvent {
  final String query;

  const SearchNews({required this.query});

  @override
  List<Object> get props => [query];
}

class ToggleBookmark extends NewsEvent {
  final String newsId;

  const ToggleBookmark({required this.newsId});

  @override
  List<Object> get props => [newsId];
}
