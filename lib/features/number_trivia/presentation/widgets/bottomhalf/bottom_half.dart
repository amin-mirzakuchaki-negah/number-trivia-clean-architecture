import 'package:flutter/material.dart';

class BottomHalf extends StatelessWidget {
  const BottomHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //Text Field
        Placeholder(fallbackHeight: 40),
        SizedBox(height: 10),
        //Buttons
        Row(
          children: [
            Expanded(child: Placeholder(fallbackHeight: 30)),
            SizedBox(width: 10),
            Expanded(child: Placeholder(fallbackHeight: 30)),
          ],
        ),
      ],
    );
  }
}
