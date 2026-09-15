import 'package:dartz/dartz.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<LessonHomeModel>>> getPublishedLessons();
}
