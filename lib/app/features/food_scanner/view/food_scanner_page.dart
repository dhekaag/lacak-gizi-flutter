import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacak_gizi/app/features/food_scanner/bloc/food_scanner_bloc.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';

class FoodScannerPage extends StatelessWidget {
  const FoodScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodScannerBloc()..add(InitializeCamera()),
      child: const FoodScannerView(),
    );
  }
}

class FoodScannerView extends StatelessWidget {
  const FoodScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FoodScannerBloc, FoodScannerState>(
        builder: (context, state) {
          if (state is FoodScannerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FoodScannerInitialized) {
            return FoodScannerContainer(
              controller: state.controller,
            );
          } else if (state is FoodScannerError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
              child: Text('Something went wrong, please try again later.'));
        },
      ),
    );
  }
}

class FoodScannerContainer extends StatefulWidget {
  final CameraController controller;

  const FoodScannerContainer({
    super.key,
    required this.controller,
  });

  @override
  State<FoodScannerContainer> createState() => _FoodScannerContainerState();
}

class _FoodScannerContainerState extends State<FoodScannerContainer>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Durations.extralong1, vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(widget.controller),
          ),
          const SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Center(
                child: Text(
                  'Scan Your Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: 600,
              child: Lottie.asset(
                "assets/animations/scanner3-animation.json",
                controller: _animationController,
                height: 500,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: SizedBox(
              height: 100,
              width: size.width,
              child: const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ListTile(
                  title: Text("Nutrition Information"),
                  subtitle: Text("Calories: 0"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
