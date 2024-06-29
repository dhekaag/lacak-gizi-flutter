import 'package:flutter/material.dart';

class FoodScannerScreen extends StatelessWidget {
  const FoodScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Food Scanner'),
        ),
        body: const Center(
          child: Text('Food Scanner Screen'),
        ));
  }
}
