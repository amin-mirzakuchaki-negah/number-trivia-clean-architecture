import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}