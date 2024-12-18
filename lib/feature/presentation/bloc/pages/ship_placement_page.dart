import 'package:flutter/material.dart';

class ShipPlacementPage extends StatefulWidget {
  const ShipPlacementPage({super.key});

  @override
  State<ShipPlacementPage> createState() => _ShipPlacementPageState();
}

class _ShipPlacementPageState extends State<ShipPlacementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShipPlacementPage'),),
    );
  }
}
