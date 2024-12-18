import 'dart:io';

import 'package:flutter/material.dart';
import 'ship_placement_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BATTLESHIP',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShipPlacementPage()),
                  );
                },
                child: const Text('Play'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => exit(0),
                child: const Text('Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
