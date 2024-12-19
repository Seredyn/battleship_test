import 'package:flutter/material.dart';

class ShipWidget extends StatelessWidget {
  final int length;

  const ShipWidget({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: length,
      feedback: Row(
        children: List.generate(
          length,
              (index) => Container(
            width: 20,
            height: 20,
            color: Colors.blue,
            margin: const EdgeInsets.all(2),
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          length,
              (index) => Container(
            width: 20,
            height: 20,
            color: Colors.blue,
            margin: const EdgeInsets.all(2),
          ),
        ),
      ),
    );
  }
}