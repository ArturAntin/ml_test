import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class IsolateUtils {
  static const String debugName = "InferenceIsolate";
  late final PoseDetector poseDetector;

  Future<void> start(InputImage inputImage) async {
    poseDetector = PoseDetector(options: PoseDetectorOptions());
    await Isolate.spawn<InputImage>(
      poseDetector.processImage,
      inputImage,
      debugName: debugName,
    );
  }
}
