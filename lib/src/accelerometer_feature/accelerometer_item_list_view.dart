import 'package:flutter/material.dart';
import 'package:tope/src/services/accelerometer_service.dart';

import '../settings/settings_view.dart';
import 'accelerometer_item.dart';

/// Displays a list of SampleItems.
class AccelerometerListView extends StatelessWidget {
  const AccelerometerListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/';

  final List<SampleItem> items;

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
          List<Widget> children = [];
          if (snapshot.hasError) {
            children = <Widget>[
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
            ];
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                children = const [
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Select a lot'),
                  ),
                ];
              case ConnectionState.waiting:
                children = const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting bids...'),
                  ),
                ];
              case ConnectionState.active:
                children!.add(
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Acceleration: ${snapshot.data}'),
                  ),
                );
              case ConnectionState.done:
                children = [
                  const Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Acceleration: ${snapshot.data} (closed)'),
                  ),
                ];
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
        },
      ),
    );
  }
}
