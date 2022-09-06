import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guided_camera/screens/camera.dart';
import 'package:guided_camera/screens/cubit/image_processing_cubit.dart';
import 'package:image/image.dart' as imglib;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageProcessingCubit(),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends HookWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageProcessingCubit>();

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
            BlocBuilder<ImageProcessingCubit, ImageProcessingState>(
              builder: (context, state) {
                if (state is ImageProcessingSuccess) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.height * 0.5,
                        child: (cubit.imagePath != null)
                            ? Image.file(File(cubit.imagePath!))
                            : const SizedBox(),
                      ),
                      SizedBox(height: 50),
                      Container(
                        color: Colors.grey,
                        height: 100,
                        width: 100,
                        child: (cubit.croppedPath != null)
                            ? Image.file(File(cubit.croppedPath!))
                            : const SizedBox(),
                      ),
                      SizedBox(height: 50),
                    ],
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.height * 0.5,
                  child: Text(
                    'Please take a picture first',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),

            ElevatedButton(
              onPressed: () async {
                final path = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const CameraScreen()));
                cubit.processImage(path);
              },
              child: const Text('Take a picture'),
            ),
          ],
        ),
      ),
    );
  }
}
