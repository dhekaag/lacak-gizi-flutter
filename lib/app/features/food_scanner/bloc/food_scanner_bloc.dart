import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'food_scanner_event.dart';
part 'food_scanner_state.dart';

class FoodScannerBloc extends Bloc<FoodScannerEvent, FoodScannerState> {
  FoodScannerBloc() : super(FoodScannerInitial()) {
    on<FoodScannerEvent>((event, emit) {});
    on<InitializeCamera>((event, emit) async {
      try {
        emit(FoodScannerLoading());
        final cameras = await availableCameras();
        final controller = CameraController(
            cameras.first, ResolutionPreset.high,
            enableAudio: false);
        await controller.initialize();

        emit(FoodScannerInitialized(controller));
      } catch (e) {
        emit(FoodScannerError(e.toString()));
      }
    });
  }
}
