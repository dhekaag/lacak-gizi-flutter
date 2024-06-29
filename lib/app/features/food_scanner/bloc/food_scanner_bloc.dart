import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'food_scanner_event.dart';
part 'food_scanner_state.dart';

class FoodScannerBloc extends Bloc<FoodScannerEvent, FoodScannerState> {
  FoodScannerBloc() : super(FoodScannerInitial()) {
    on<FoodScannerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
