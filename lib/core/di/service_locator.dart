import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/network/interceptors/cache_interceptor_helper.dart';
import 'package:volt/core/network/interceptors/response_unwrapper_interceptor.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:volt/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';
import 'package:volt/features/auth/data/repos/auth_repo_impl.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:volt/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:volt/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:volt/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:volt/features/home/data/repos/home_repo.dart';
import 'package:volt/features/home/data/repos/home_repo_impl.dart';
import 'package:volt/features/home/presentation/cubits/home_cubit.dart';
import 'package:volt/features/lessons/data/data_sources/lessons_local_data_source.dart';
import 'package:volt/features/lessons/data/data_sources/lessons_remote_data_source.dart';
import 'package:volt/features/lessons/data/repos/lessons_repo.dart';
import 'package:volt/features/lessons/data/repos/lessons_repo_impl.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_content_cubit/lesson_content_cubit.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_quiz_cubit/lesson_quiz_cubit.dart';
import 'package:volt/features/main_layout/presentation/cubits/main_layout_cubit/main_layout_cubit.dart';
import 'package:volt/features/placement_quiz/data/data_sources/placement_remote_data_source.dart';
import 'package:volt/features/placement_quiz/data/repos/placement_repo.dart';
import 'package:volt/features/placement_quiz/data/repos/placement_repo_impl.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';
import 'package:volt/volt_app.dart';

import '../network/api_service.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/cache_debug_interceptor.dart';
import '../network/interceptors/cache_header_injector_interceptor.dart';
import '../network/network_cache_manager.dart';
import '../storage/secure_storage_helper.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _initCore();
  _initAuthFeature();
  _initHome();
  _initLessonFeature();
  _initPlacementFeature();
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

  final cacheDir = await getApplicationDocumentsDirectory();
  final cacheStore = HiveCacheStore(cacheDir.path);
  sl.registerLazySingleton(() => cacheStore);
  sl.registerLazySingleton(() => NetworkCacheManager(sl()));

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
        navigatorKey.currentContext?.pushNamedAndRemoveAll(Routes.auth);
        sl<AuthCubit>().logout();
      },
    ),
    CacheHeaderInjectorInterceptor(),
    CacheInterceptorHelper.getCacheInterceptor(hiveCacheStore: sl()),
    CacheDebugInterceptor(),

    ResponseUnwrapperInterceptor(),

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

  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl(), sl(), sl()));

  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
}

void _initHome() {
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => MainLayoutCubit());
}

void _initLessonFeature() {
  sl.registerLazySingleton<LessonsRemoteDataSource>(() => LessonsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LessonsLocalDataSource>(() => LessonsLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<LessonsRepo>(() => LessonsRepoImpl(sl(), sl()));
  sl.registerFactory(() => LessonContentCubit(sl()));
  sl.registerFactory(() => LessonQuizCubit(sl()));
}

void _initPlacementFeature() {
  sl.registerLazySingleton<PlacementRemoteDataSource>(
    () => PlacementRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PlacementRepo>(() => PlacementRepoImpl(sl()));
  sl.registerFactory(() => PlacementQuizCubit(sl()));
}
