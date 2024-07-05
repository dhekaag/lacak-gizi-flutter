import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacak_gizi/app/features/food_scanner/bloc/food_scanner_bloc.dart';
import 'package:lacak_gizi/app/features/food_scanner/widgets/scanner_animation_widget.dart';
import 'package:lacak_gizi/app/utils/adaptive_font.dart';
import 'package:lacak_gizi/app/utils/logger.dart';

class FoodScannerPage extends StatelessWidget {
  const FoodScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodScannerBloc()..add(InitializeCameraEvent()),
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
              controller: state.cameraController,
            );
          } else if (state is FoodScannerImagePicked) {
            return FoodScannerContainer(
              image: state.image,
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

class FoodScannerContainer extends StatelessWidget {
  final CameraController? controller;
  final File? image;
  const FoodScannerContainer({
    super.key,
    this.controller,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Container(
            width: size.width,
            decoration: const BoxDecoration(color: Colors.black),
            child: image == null
                ? CameraPreview(controller!)
                : Center(
                    child: Image.file(
                    image!,
                    width: size.width,
                  )),
          ),
          if (image == null) const ScannerAnimationWidget(),
          Positioned(
            left: 20,
            top: 30,
            child: SafeArea(
              child: Container(
                width: size.width / 10,
                height: size.width / 10,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 30,
            child: SafeArea(
              child: Container(
                width: size.width / 10,
                height: size.width / 10,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.image_search),
                    onPressed: () {
                      context.read<FoodScannerBloc>().add(PickImageEvent());
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 100,
            right: 100,
            child: SafeArea(
              child: Container(
                width: size.width * 0.5,
                height: size.height / 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    image != null ? 'Your Food' : 'Scan Your Food',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AdaptiveFontSize.getFontSize(context, 20),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image != null
                      ? ElevatedButton(
                          onPressed: () {
                            context
                                .read<FoodScannerBloc>()
                                .add(InitializeCameraEvent());
                          },
                          child: const Text('Change With Camera'))
                      : ElevatedButton.icon(
                          onPressed: () {
                            final Future<XFile>? file =
                                controller?.takePicture();
                            file?.then((value) {
                              context
                                  .read<FoodScannerBloc>()
                                  .add(TakePictureEvent(value));
                            });
                          },
                          label: const Icon(Icons.camera_alt),
                        ),
                  SizedBox(
                    height: size.height * 0.18,
                    width: size.width,
                    child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Food Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      AdaptiveFontSize.getFontSize(context, 18),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Cal: 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AdaptiveFontSize.getFontSize(
                                          context, 16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Prot: 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AdaptiveFontSize.getFontSize(
                                          context, 16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Fat: 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AdaptiveFontSize.getFontSize(
                                          context, 16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Carbo: 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AdaptiveFontSize.getFontSize(
                                          context, 16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
