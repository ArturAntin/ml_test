import 'dart:math';

double getAngle(Point pointA, Point pointB, Point pointC) {
  double radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) -
      atan2(pointA.y - pointB.y, pointA.x - pointB.x);
  double angle = (radians * 180 / pi).abs();

  if (angle > 180) {
    angle = 360 - angle;
  }

  return angle;
}

abstract class ExerciseHandler {
  int doneReps = 0;
  late List<Limb> limbs;
  Stage stage = Stage.start;
  final scoreTreshold = 0.3;

  bool isPostureCorrect() {
    for (final limb in limbs) {
      if (limb.isCorrect == false) {
        return false;
      }
    }
    return true;
  }

  void checkLimbs(List<InferenceResult> inferenceResults) {
    for (final limb in limbs) {
      final angle = getAngle(
        inferenceResults[limb.bodyParts[0]].point,
        inferenceResults[limb.bodyParts[1]].point,
        inferenceResults[limb.bodyParts[2]].point,
      );
      if (angle >= limb.minAngle &&
          angle <= limb.maxAngle &&
          inferenceResults[limb.bodyParts[0]].score > scoreTreshold &&
          inferenceResults[limb.bodyParts[1]].score > scoreTreshold &&
          inferenceResults[limb.bodyParts[2]].score > scoreTreshold) {
        limb.isCorrect = true;
      } else {
        limb.isCorrect = false;
      }
    }
  }

  /// has to set limbs and targets of specific exercise
  void init() {
    doneReps = 0;
    stage = Stage.start;
  }

  /// returns true if a repetition is completed correctly, false otherwise
  RepetitionHandlerResult doReps(List<InferenceResult> inferenceResults);
}

class Limb {
  Limb({
    required this.bodyParts,
    this.isCorrect = false,
    required this.minAngle,
    required this.maxAngle,
  });

  List<int> bodyParts;
  bool isCorrect;
  int maxAngle;
  int minAngle;
}

class Point {
  Point(
    this.x,
    this.y,
  );

  int x, y;
}

class InferenceResult {
  Point point;
  double score;

  InferenceResult({
    required this.point,
    required this.score,
  });
}

class RepetitionHandlerResult {
  bool repDone;
  List<AngleResult> angles;
  bool isPostureCorrect;

  RepetitionHandlerResult({
    required this.repDone,
    required this.angles,
    required this.isPostureCorrect,
  });

  @override
  String toString() {
    return "repDone: $repDone | isPostureCorrect: $isPostureCorrect | angles: ${angles.toString()}";
  }
}

class AngleResult {
  String name;
  double angle;
  double fromAngle;
  double toAngle;
  bool isCorrect;

  AngleResult({
    required this.name,
    required this.angle,
    this.isCorrect = false,
    required this.fromAngle,
    required this.toAngle,
  });

  @override
  String toString() {
    return "name: $name | isCorrect: $isCorrect | angle: $angle | fromAngle: $fromAngle | toAngle: $toAngle";
  }
}

enum Stage { start, up, down }
