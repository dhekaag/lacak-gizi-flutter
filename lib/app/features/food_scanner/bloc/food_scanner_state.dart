part of 'food_scanner_bloc.dart';

sealed class FoodScannerState extends Equatable {
  const FoodScannerState();

  @override
  List<Object> get props => [];
}

final class FoodScannerInitial extends FoodScannerState {}

class FoodScannerLoading extends FoodScannerState {}

class FoodScannerInitialized extends FoodScannerState {
  final CameraController controller;

  const FoodScannerInitialized(this.controller);

  @override
  List<Object> get props => [controller];
}

class FoodScannerError extends FoodScannerState {
  final String message;

  const FoodScannerError(this.message);

  @override
  List<Object> get props => [message];
}
