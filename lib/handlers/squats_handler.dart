import 'package:ml_test/handlers/exercise_handler.dart';

class SquatsHandler extends ExerciseHandler {
  @override
  void init() {
    limbs = [
      Limb(
        /// leftHip, leftKnee, leftAnkle
        bodyParts: [11, 13, 15],
        minAngle: 30,
        maxAngle: 185,
      ),
      Limb(
        /// rightHip, rightKnee, rightAnkle
        bodyParts: [12, 14, 16],
        minAngle: 30,
        maxAngle: 185,
      ),
      Limb(
        /// leftShoulder, leftHip, leftKnee
        bodyParts: [5, 11, 13],
        minAngle: 30,
        maxAngle: 185,
      ),
      Limb(
        /// rightShoulder, rightHip, rightKnee
        bodyParts: [6, 12, 14],
        minAngle: 30,
        maxAngle: 185,
      ),
    ];
    super.init();
  }

  @override
  RepetitionHandlerResult doReps(List<InferenceResult> inferenceResults) {
    if (isPostureCorrect()) {
      // left leg
      int a = 11;
      int b = 13;
      int c = 15;
      double leftLeg = getAngle(
        inferenceResults[a].point,
        inferenceResults[b].point,
        inferenceResults[c].point,
      );

      // right leg
      a = 12;
      b = 14;
      c = 16;
      double rightLeg = getAngle(
        inferenceResults[a].point,
        inferenceResults[b].point,
        inferenceResults[c].point,
      );

      // //left shoulder
      // a = 7;
      // b = 5;
      // c = 11;
      // double leftShoulder = getAngle(
      //   inferenceResults[a].point,
      //   inferenceResults[b].point,
      //   inferenceResults[c].point,
      // );

      // //right shoulder
      // a = 8;
      // b = 6;
      // c = 12;
      // double rightShoulder = getAngle(
      //   inferenceResults[a].point,
      //   inferenceResults[b].point,
      //   inferenceResults[c].point,
      // );

      //left hip
      a = 5;
      b = 11;
      c = 13;
      double leftHip = getAngle(
        inferenceResults[a].point,
        inferenceResults[b].point,
        inferenceResults[c].point,
      );

      //right hip
      a = 6;
      b = 12;
      c = 14;
      double rightHip = getAngle(
        inferenceResults[a].point,
        inferenceResults[b].point,
        inferenceResults[c].point,
      );

      double hips = (rightHip + leftHip) / 2;
      double legs = (rightLeg + leftLeg) / 2;

      final angles = [
        AngleResult(
          name: 'Legs',
          angle: legs,
          fromAngle: 180,
          toAngle: 100,
        ),
        AngleResult(
          name: 'Hips',
          angle: hips,
          fromAngle: 180,
          toAngle: 100,
        ),
      ];

      if (stage == Stage.start) {
        if (legs > 150 && hips > 150) {
          stage = Stage.down;
        }
      } else {
        if (legs > 150 && hips > 150) {
          stage = Stage.down;
        }
        if (legs < 100 && stage == Stage.down) {
          stage = Stage.up;
          doneReps += 1;
          return RepetitionHandlerResult(
            repDone: true,
            angles: angles,
            isPostureCorrect: true,
          );
        }
      }
      return RepetitionHandlerResult(
        repDone: false,
        angles: angles,
        isPostureCorrect: true,
      );
    } else {
      stage = Stage.start;
      return RepetitionHandlerResult(
        repDone: false,
        angles: [
          AngleResult(
            name: 'Legs',
            angle: 0,
            fromAngle: 180,
            toAngle: 100,
          ),
          AngleResult(
            name: 'Hips',
            angle: 0,
            fromAngle: 180,
            toAngle: 100,
          ),
        ],
        isPostureCorrect: false,
      );
    }
  }
}
