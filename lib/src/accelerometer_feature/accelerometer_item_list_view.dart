import 'package:flutter/material.dart';
import 'package:tope/src/services/accelerometer_service.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class AccelerometerListView extends StatefulWidget {
  static const routeName = '/';

  const AccelerometerListView({super.key});

  @override
  State<AccelerometerListView> createState() => _AccelerometerListViewState();
}

class _AccelerometerListViewState extends State<AccelerometerListView> {
  final List<Widget> _bumps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder<double>(
        stream: AccelerometerService().listen().stream,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Stack trace: ${snapshot.stackTrace}'),
                ),
              ],
            );
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Select a lot'),
                    ),
                  ],
                );
              case ConnectionState.waiting:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting bids...'),
                    ),
                  ],
                );
              case ConnectionState.active:
                _bumps.add(
                  ListTile(
                    title: Text(
                      'Acceleration: ${snapshot.data!.toStringAsFixed(3)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
                return ListView(
                  children: _bumps,
                );
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Acceleration: ${snapshot.data} (closed)'),
                    ),
                  ],
                );
            }
          }
        },
      ),
    );
  }
}
