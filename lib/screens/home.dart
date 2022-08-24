import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:guided_camera/screens/camera.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic imagePath;
  dynamic faceDetect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              (faceDetect != null) ? 'Face Detected' : 'No Face Detected',
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 30,
              ),
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: (imagePath != null)
                  ? Image.network(imagePath)
                  : const SizedBox(),
            ),
            ElevatedButton(
              onPressed: () async {
                imagePath = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const CameraScreen()));
                faceDetect = await FaceDetector(options: FaceDetectorOptions())
                    .processImage(InputImage.fromFilePath(imagePath));
                setState(() {
                  imagePath;
                });
              },
              child: const Text('Take a picture'),
            ),
          ],
        ),
      ),
    );
  }
}
