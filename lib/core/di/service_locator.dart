import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:volt/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';
import 'package:volt/features/auth/data/repos/auth_repo_impl.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:volt/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:volt/features/auth/presentation/cubits/register_cubit/register_cubit.dart';

import '../network/api_service.dart';
import '../network/auth_interceptor.dart';
import '../storage/secure_storage_helper.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _initCore();
  _initAuthFeature();
}

Future<void> _initCore() async {
  // SharedPreferences تهيئة
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => CacheHelper(sharedPreferences));

  // 1. Storage
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  sl.registerLazySingleton(() => SecureStorageHelper(secureStorage));

  // 2. Dio Setup
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(
      dio: dio,
      secureStorageHelper: sl(),
      onUnauthorized: () {
        sl<AuthCubit>().logout();
      },
    ),
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
  ]);

  sl.registerLazySingleton(() => dio);

  // 3. ApiService
  sl.registerLazySingleton(() => ApiService(sl()));
}

void _initAuthFeature() {
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl()));

  sl.registerLazySingleton(() => AuthCubit(sl()));
  sl.registerLazySingleton(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => RegisterCubit(sl()));
}
