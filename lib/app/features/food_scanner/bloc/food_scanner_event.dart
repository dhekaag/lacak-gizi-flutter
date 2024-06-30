part of 'food_scanner_bloc.dart';

sealed class FoodScannerEvent extends Equatable {
  const FoodScannerEvent();

  @override
  List<Object> get props => [];
}

class InitializeCamera extends FoodScannerEvent {}
