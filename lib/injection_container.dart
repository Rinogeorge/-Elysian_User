import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysian_user/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:elysian_user/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elysian_user/features/auth/domain/repositories/auth_repository.dart';
import 'package:elysian_user/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/login_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/logout_usecase.dart';
import 'package:elysian_user/features/auth/domain/usecases/signup_usecase.dart';
import 'package:elysian_user/features/auth/logic/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/login/login_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/profile/profile_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/signup/signup_bloc.dart';
import 'package:elysian_user/features/home/data/datasources/home_remote_datasource.dart';
import 'package:elysian_user/features/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:elysian_user/features/home/data/repositories/home_repository_impl.dart';
import 'package:elysian_user/features/home/domain/repositories/home_repository.dart';
import 'package:elysian_user/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_destinations_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_offers_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_user_points_usecase.dart';
import 'package:elysian_user/features/home/logic/bloc/home/home_bloc.dart';
import 'package:elysian_user/features/bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:elysian_user/features/bookings/data/datasources/bookings_remote_datasource_impl.dart';
import 'package:elysian_user/features/bookings/data/repositories/bookings_repository_impl.dart';
import 'package:elysian_user/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:elysian_user/features/bookings/domain/usecases/get_bookings_usecase.dart';
import 'package:elysian_user/features/bookings/logic/bloc/bookings/bookings_bloc.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => LoginBloc(loginUseCase: sl(), googleLoginUseCase: sl()),
  );
  sl.registerFactory(
    () => SignupBloc(signupUseCase: sl(), googleLoginUseCase: sl()),
  );
  sl.registerFactory(
    () => ProfileBloc(
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
      deleteAccountUseCase: sl(),
    ),
  );
  sl.registerFactory(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  sl.registerFactory(
    () => HomeBloc(
      getCategoriesUseCase: sl(),
      getDestinationsUseCase: sl(),
      getOffersUseCase: sl(),
      getUserPointsUseCase: sl(),
    ),
  );
  sl.registerFactory(() => BookingsBloc(getBookingsUseCase: sl()));
  sl.registerFactory(() => BottomNavBloc());

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetDestinationsUseCase(sl()));
  sl.registerLazySingleton(() => GetOffersUseCase(sl()));
  sl.registerLazySingleton(() => GetUserPointsUseCase(sl()));
  sl.registerLazySingleton(() => GetBookingsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BookingsRepository>(
    () => BookingsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<BookingsRemoteDataSource>(
    () => BookingsRemoteDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
}
