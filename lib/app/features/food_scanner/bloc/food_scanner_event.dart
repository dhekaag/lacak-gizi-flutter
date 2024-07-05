part of 'food_scanner_bloc.dart';

sealed class FoodScannerEvent extends Equatable {
  const FoodScannerEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends FoodScannerEvent {}

class TakePictureEvent extends FoodScannerEvent {
  final XFile imagePath;

  const TakePictureEvent(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class PickImageEvent extends FoodScannerEvent {}
