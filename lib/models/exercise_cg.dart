import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ml_test/handlers/exercise_handler.dart';

part 'exercise_cg.freezed.dart';

@freezed
class Exercise with _$Exercise {
  const Exercise._();

  const factory Exercise({
    required String displayName,
    required String image,
    required String gif,
    required List<String> descriptionTexts,
    required ExerciseHandler handler,
  }) = _Exercise;
}
