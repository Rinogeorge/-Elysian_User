import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/signup_usecase.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;
  final GoogleLoginUseCase googleLoginUseCase;

  SignupBloc({required this.signupUseCase, required this.googleLoginUseCase})
    : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
    on<GoogleSignupRequested>(_onGoogleSignupRequested);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());
    final result = await signupUseCase(
      SignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }

  Future<void> _onGoogleSignupRequested(
    GoogleSignupRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());
    final result = await googleLoginUseCase(NoParams());
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
