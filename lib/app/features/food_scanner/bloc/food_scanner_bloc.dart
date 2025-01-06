import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'food_scanner_event.dart';
part 'food_scanner_state.dart';

class FoodScannerBloc extends Bloc<FoodScannerEvent, FoodScannerState> {
  FoodScannerBloc() : super(FoodScannerInitial()) {
    on<FoodScannerEvent>((event, emit) {});
    on<InitializeCameraEvent>((event, emit) async {
      try {
        emit(FoodScannerLoading());
        final controller = await initializeCamera();
        emit(FoodScannerInitialized(controller));
      } catch (e) {
        emit(FoodScannerError(e.toString()));
      }
    });

    on<TakePictureEvent>((event, emit) async {
      try {
        emit(FoodScannerLoading());
        emit(FoodScannerImagePicked(File(event.imagePath.path)));
      } catch (e) {
        emit(FoodScannerError(e.toString()));
      }
    });

    on<PickImageEvent>((event, emit) async {
      try {
        emit(FoodScannerLoading());
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          emit(FoodScannerImagePicked(File(image.path)));
        } else {
          final controller = await initializeCamera();
          emit(FoodScannerInitialized(controller));
        }
      } catch (e) {
        emit(FoodScannerError(e.toString()));
      }
    });
  }
  Future<CameraController> initializeCamera() async {
    final cameras = await availableCameras();
    final controller = CameraController(cameras.first, ResolutionPreset.high,
        enableAudio: false);
    await controller.initialize();
    return controller;
  }
}
