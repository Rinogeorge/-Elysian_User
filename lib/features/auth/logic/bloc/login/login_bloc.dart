import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elysian_user/features/auth/domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final GoogleLoginUseCase googleLoginUseCase;

  LoginBloc({required this.loginUseCase, required this.googleLoginUseCase})
    : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await googleLoginUseCase(NoParams());
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
