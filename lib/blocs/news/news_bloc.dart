import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/news.dart';
import '../../services/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;

  NewsBloc({NewsService? newsService})
    : _newsService = newsService ?? NewsService(),
      super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<LoadNewsByCategory>(_onLoadNewsByCategory);
    on<SearchNews>(_onSearchNews);
    on<ToggleBookmark>(_onToggleBookmark);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final news = await _newsService.fetchAllNews();
      emit(NewsLoaded(news: news));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  Future<void> _onLoadNewsByCategory(
    LoadNewsByCategory event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      if (event.category == 'all') {
        final news = await _newsService.fetchAllNews();
        emit(NewsLoaded(news: news));
      } else {
        final news = await _newsService.fetchNewsByCategory(event.category);
        emit(NewsLoaded(news: news));
      }
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final news = await _newsService.searchNews(event.query);
      emit(NewsLoaded(news: news));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  Future<void> _onToggleBookmark(
    ToggleBookmark event,
    Emitter<NewsState> emit,
  ) async {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final updatedNews = currentState.news.map((news) {
        if (news.id == event.newsId) {
          return news.copyWith(isBookmarked: !news.isBookmarked);
        }
        return news;
      }).toList();

      emit(NewsLoaded(news: updatedNews));
    }
  }
}
