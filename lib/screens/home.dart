import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guided_camera/screens/camera.dart';
import 'package:image/image.dart' as imglib;
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic imagePath;
  // dynamic faceDetect;

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
            // Text(
            //   (faceDetect != null) ? 'Face Detected' : 'No Face Detected',
            //   style: const TextStyle(fontSize: 20),
            // ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 30,
              ),
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height * 0.5,
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
                var bytes = await File(imagePath).readAsBytes();
                imglib.Image? src = imglib.decodeImage(bytes);
                imglib.Image destImage = imglib.copyCrop(src!, 0, 0, 100, 100);
                var jpg = imglib.encodeJpg(destImage);
                await File(imagePath).writeAsBytes(jpg);
                // faceDetect = await FaceDetector(options: FaceDetectorOptions())
                //     .processImage(InputImage.fromFilePath(imagePath));
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
