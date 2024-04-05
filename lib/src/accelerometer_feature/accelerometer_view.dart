import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class AccelerometerView extends StatelessWidget {
  const AccelerometerView({super.key});

  static const routeName = '/accelerometer_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
