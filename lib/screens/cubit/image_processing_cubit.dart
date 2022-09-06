import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';

part 'image_processing_state.dart';

class ImageProcessingCubit extends Cubit<ImageProcessingState> {
  ImageProcessingCubit() : super(ImageProcessingInitial());
  String? imagePath;
  String? croppedPath;

  Future<void> processImage(String? path) async {
    imagePath = path;
    croppedPath = '${(await getTemporaryDirectory()).path}/cropped_img.jpg';
    var bytes = imagePath != null ? await File(imagePath!).readAsBytes() : null;
    imglib.Image? src = imglib.decodeImage(bytes!);
    imglib.Image destImage = imglib.copyCrop(src!, 0, 0, 100, 100);
    var jpg = imglib.encodeJpg(destImage);
    await File(croppedPath!).writeAsBytes(jpg);
    // faceDetect = await FaceDetector(options: FaceDetectorOptions())
    //     .processImage(InputImage.fromFilePath(imagePath));
    emit(ImageProcessingSuccess());
  }
}
