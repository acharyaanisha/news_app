import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      emit(ThemeLoaded(isDark: isDark));
    } catch (e) {
      emit(ThemeLoaded(isDark: false));
    }
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is ThemeLoaded) {
      final currentState = state as ThemeLoaded;
      final newIsDark = !currentState.isDark;

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isDarkMode', newIsDark);
        emit(ThemeLoaded(isDark: newIsDark));
      } catch (e) {
        // If saving fails, still emit the new state
        emit(ThemeLoaded(isDark: newIsDark));
      }
    }
  }
}
