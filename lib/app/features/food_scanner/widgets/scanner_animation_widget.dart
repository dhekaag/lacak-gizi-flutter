// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScannerAnimationWidget extends StatelessWidget {
  const ScannerAnimationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 600,
        child: Lottie.asset("assets/animations/scanner3-animation.json",
            height: 500, repeat: true),
      ),
    );
  }
}
