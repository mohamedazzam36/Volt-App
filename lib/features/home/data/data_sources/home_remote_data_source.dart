import 'package:volt/core/network/api_endpoints.dart';
import 'package:volt/core/network/api_service.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<LessonHomeModel>> getPublishedLessons();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<List<LessonHomeModel>> getPublishedLessons() async {
    final result = await _apiService.get(ApiEndpoints.publishedLessons);
    return (result as List)
        .map((e) => LessonHomeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
