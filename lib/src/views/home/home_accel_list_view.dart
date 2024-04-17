import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tope/src/services/accelerometer_service.dart';
import 'package:tope/src/utils/vector.dart';
import 'package:tope/src/views/home/home_accel_list_item.dart';

class HomeAccelListView extends StatefulWidget {
  const HomeAccelListView({super.key});

  @override
  State<HomeAccelListView> createState() => _HomeAccelListViewState();
}

class _HomeAccelListViewState extends State<HomeAccelListView> {
  final ListQueue<Widget> _bumps = ListQueue(1000);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Vector>(
      stream: AccelerometerService().listenAccel().stream,
      builder: (BuildContext context, AsyncSnapshot<Vector> snapshot) {
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting accelerations...'),
                  ),
                ],
              );
            case ConnectionState.active:
              _bumps.addFirst(
                HomeAccelListItem(snapshot.data!),
              );
              return Flexible(
                flex: 2,
                child: ListView(
                  children: _bumps.toList(growable: false),

                ),
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
    );
  }
}
