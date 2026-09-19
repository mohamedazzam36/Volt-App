import 'package:bloc/bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/env/app_env.dart';
import 'package:volt/features/lessons/data/models/lesson_detail/lesson_content_model.dart';
import 'package:volt/features/lessons/data/repos/lessons_repo.dart';

part 'lesson_content_state.dart';

class LessonContentCubit extends Cubit<LessonContentState> {
  LessonContentCubit(this._lessonsRepo) : super(LessonContentInitial());
  final LessonsRepo _lessonsRepo;

  List<LessonContentModel> lessonContents = [];
  int currentContentIndex = 0;
  int _lessonId = 0;

  Future<void> getLessonContents({required int lessonId}) async {
    _lessonId = lessonId;
    emit(LessonContentLoading());

    final result = await _lessonsRepo.getLessonContents(id: lessonId);

    result.fold(
      (failure) => emit(LessonContentError(message: failure.errMessage)),
      (lessonContents) {
        if (lessonContents.isEmpty) {
          emit(const LessonContentError(message: 'محتوى هذا الدرس غير متوفر حالياً'));
          return;
        }
        this.lessonContents = lessonContents;
        currentContentIndex = 0;
        emit(
          LessonNextContent(
            content: lessonContents[0].content,
            mediaUrl: "${AppEnv.baseUrl}${lessonContents[0].mediaUrl}",
            contentTypeName: lessonContents[0].contentTypeName,
            progress: 0,
          ),
        );
      },
    );
  }

  Future<void> nextContent() async {
    if (currentContentIndex < lessonContents.length - 1) {
      currentContentIndex++;
      emit(
        LessonNextContent(
          content: lessonContents[currentContentIndex].content,
          mediaUrl: "${AppEnv.baseUrl}${lessonContents[currentContentIndex].mediaUrl}",
          contentTypeName: lessonContents[currentContentIndex].contentTypeName,
          progress: (currentContentIndex + 1) / lessonContents.length,
        ),
      );
    } else {
      _lessonsRepo.postLessonProgress(lessonId: _lessonId).ignore();
      emit(LessonContentDone(lessonId: _lessonId));
    }
  }

  void prevContent() {
    if (currentContentIndex > 0) {
      currentContentIndex--;
      emit(
        LessonNextContent(
          content: lessonContents[currentContentIndex].content,
          mediaUrl: "${AppEnv.baseUrl}${lessonContents[currentContentIndex].mediaUrl}",
          contentTypeName: lessonContents[currentContentIndex].contentTypeName,
          progress: (currentContentIndex + 1) / lessonContents.length,
        ),
      );
    }
  }
}
