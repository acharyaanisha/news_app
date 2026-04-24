import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOtp>(_onSendOtp);
    on<VerifyOtp>(_onVerifyOtp);
    on<LoginWithPhone>(_onLoginWithPhone);
    on<SignupWithPhone>(_onSignupWithPhone);
    on<Logout>(_onLogout);
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(OtpSent(phoneNumber: event.phoneNumber));
    } catch (e) {
      emit(AuthError(message: 'Failed to send OTP'));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (event.otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(event.otp)) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(message: 'Invalid OTP'));
      }
    } catch (e) {
      emit(AuthError(message: 'Failed to verify OTP'));
    }
  }

  Future<void> _onLoginWithPhone(
    LoginWithPhone event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      // In real app, this would authenticate with backend
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: 'Login failed'));
    }
  }

  Future<void> _onSignupWithPhone(
    SignupWithPhone event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: 'Signup failed'));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Logout failed'));
    }
  }
}
