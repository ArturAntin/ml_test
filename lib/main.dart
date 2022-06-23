import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:ml_test/handlers/exercise_handler.dart';
import 'package:ml_test/handlers/squats_handler.dart';
import 'package:ml_test/models/exercise_cg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Model Tests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'ML Tests',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late VideoPlayerController _videoController;
  // final String assetName = "assets/videos/squats_test.MOV";
  final String assetName = "assets/pictures/person.jpg";
  final List<List<PoseResult>> _poses = [];
  late final Exercise exercise;
  RepetitionHandlerResult? _result;

  final landmarks = [
    PoseLandmarkType.nose,
    PoseLandmarkType.leftEye,
    PoseLandmarkType.rightEye,
    PoseLandmarkType.leftEar,
    PoseLandmarkType.rightEar,
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.leftElbow,
    PoseLandmarkType.rightElbow,
    PoseLandmarkType.leftWrist,
    PoseLandmarkType.rightWrist,
    PoseLandmarkType.leftHip,
    PoseLandmarkType.rightHip,
    PoseLandmarkType.leftKnee,
    PoseLandmarkType.rightKnee,
    PoseLandmarkType.leftAnkle,
    PoseLandmarkType.rightAnkle,
  ];

  int _reps = 0;
  final totalFrames = 442;

  @override
  void initState() {
    exercise = Exercise(
      displayName: 'squats',
      image: '',
      gif: '',
      descriptionTexts: [],
      handler: SquatsHandler(),
    );
    exercise.handler.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  pickFile(ImageSource.gallery);
                },
                child: const Text('load video'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      "${_poses.length.toString()} / $totalFrames Frames loaded"),
                  if (_poses.length < totalFrames)
                    const CircularProgressIndicator()
                ],
              ),
            ),
            const Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  List<PoseResult> picture = _poses[index];
                  return Column(
                    children: picture
                        .map<Widget>(
                          (e) => Column(
                            children: [
                              ListTile(
                                leading: const Text('Name'),
                                title: Text(e.name),
                              ),
                              ListTile(
                                leading: const Text('X'),
                                title: Text(e.x.toString()),
                              ),
                              ListTile(
                                leading: const Text('Y'),
                                title: Text(e.y.toString()),
                              ),
                              ListTile(
                                leading: const Text('Likelihood'),
                                title: Text(e.likelihood.toString()),
                              ),
                            ],
                          ),
                        )
                        .toList()
                      ..insert(
                        0,
                        ListTile(
                          leading: Text(
                            "Picture",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          title: Text(
                            (index + 1).toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                  );
                },
                itemCount: _poses.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Reps: ${_reps.toString()}",
                style: Theme.of(context).textTheme.headline2,
              ),
            )
          ],
        ),
      ),
    );
  }

  void runModel(
      int index, Exercise exercise, List<InferenceResult> inferenceResults) {
    exercise.handler.checkLimbs(inferenceResults);
    final result = exercise.handler.doReps(inferenceResults);
    print("RESULT $index: " + result.toString());
    if (result.repDone) {
      setState(() {
        _reps++;
      });
    }
  }

  void pickFile(ImageSource source) async {
    setState(() {
      _poses.clear();
      _reps = 0;
    });
    IsolateHandler isolates = IsolateHandler();
    final file = await ImagePicker().pickVideo(source: source);
    int i = 0;

    ExportVideoFrame.exportImagesFromFile(
      File(file!.path),
      const Duration(milliseconds: 50),
      0,
    ).listen((file) {
      String path = file.path;
      isolates.spawn<List<Map<String, dynamic>>>(
        entryPoint,
        name: "ml_kit_$path",
        // Executed every time data is received from the spawned isolate.
        onReceive: (value) {
          List<InferenceResult> inferenceResults = [];
          List<PoseResult> poseResults = [];
          for (var map in value) {
            PoseResult poseResult = PoseResult(
              name: map['type'],
              likelihood: map['likelihood'],
              x: map['x'],
              y: map['y'],
              z: map['z'],
            );
            poseResults.add(poseResult);
          }
          for (var landmarkType in landmarks) {
            final landmark = poseResults.firstWhere(
              (element) => element.name == landmarkType.name,
              orElse: () => PoseResult(
                name: '-',
                likelihood: 0.0,
                x: 0,
                y: 0,
                z: 0,
              ),
            );
            inferenceResults.add(
              InferenceResult(
                point: Point(
                  landmark.x.toInt(),
                  landmark.y.toInt(),
                ),
                score: landmark.likelihood,
              ),
            );
          }
          runModel(
            i++,
            exercise,
            inferenceResults,
          );
          setState(() {
            _poses.add(poseResults);
          });
          isolates.kill("ml_kit_$path");
        },
        // Executed once when spawned isolate is ready for communication.
        onInitialized: () => isolates.send(path, to: "ml_kit_$path"),
      );
    });
  }

  static void entryPoint(Map<String, dynamic> context) {
    // Calling initialize from the entry point with the context is
    // required if communication is desired. It returns a messenger which
    // allows listening and sending information to the main isolate.
    final messenger = HandledIsolate.initialize(context);

    final PoseDetector poseDetector =
        PoseDetector(options: PoseDetectorOptions());

    // Triggered every time data is received from the main isolate.
    messenger.listen((path) async {
      InputImage inputImage = InputImage.fromFilePath(path);
      final poses = await poseDetector.processImage(inputImage);
      final List<Map<String, dynamic>> result = [];
      if (poses.isEmpty) {
        result.add(
          {
            'type': '-',
            'likelihood': 0.0,
            'x': 0.0,
            'y': 0.0,
            'z': 0.0,
          },
        );
      } else {
        for (PoseLandmark landmark in poses.first.landmarks.values) {
          Map<String, dynamic> json = {};
          json.putIfAbsent('type', () => landmark.type.name);
          json.putIfAbsent('likelihood', () => landmark.likelihood);
          json.putIfAbsent('x', () => landmark.x);
          json.putIfAbsent('y', () => landmark.y);
          json.putIfAbsent('z', () => landmark.z);
          result.add(json);
        }
      }
      messenger.send(result);
    });
  }
}

class PoseResult {
  String name;
  double likelihood, x, y, z;
  PoseResult({
    required this.name,
    required this.likelihood,
    required this.x,
    required this.y,
    required this.z,
  });
}
