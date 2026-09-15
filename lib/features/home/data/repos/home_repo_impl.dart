import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:volt/core/errors/api_failures.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';
import 'package:volt/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this._homeRemoteDataSource);
  final HomeRemoteDataSource _homeRemoteDataSource;

  @override
  Future<Either<Failure, List<LessonHomeModel>>> getPublishedLessons() async {
    try {
      final result = await _homeRemoteDataSource.getPublishedLessons();
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
