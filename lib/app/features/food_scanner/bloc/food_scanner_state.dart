part of 'food_scanner_bloc.dart';

sealed class FoodScannerState extends Equatable {
  const FoodScannerState();

  @override
  List<Object> get props => [];
}

final class FoodScannerInitial extends FoodScannerState {}

class FoodScannerLoading extends FoodScannerState {}

class FoodScannerInitialized extends FoodScannerState {
  final CameraController cameraController;

  const FoodScannerInitialized(this.cameraController);

  @override
  List<Object> get props => [cameraController];
}

class FoodScannerImagePicked extends FoodScannerState {
  final File image;

  const FoodScannerImagePicked(this.image);

  @override
  List<Object> get props => [image];
}

class FoodScannerError extends FoodScannerState {
  final String message;

  const FoodScannerError(this.message);

  @override
  List<Object> get props => [message];
}
