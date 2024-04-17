import 'package:flutter/material.dart';
import 'package:tope/src/services/accelerometer_service.dart';
import 'package:tope/src/utils/vector.dart';

class HomeGyroView extends StatefulWidget {
  const HomeGyroView({super.key});

  @override
  State<HomeGyroView> createState() => _HomeGyroViewState();
}

class _HomeGyroViewState extends State<HomeGyroView> {
  Vector? up;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Vector>(
      stream: AccelerometerService().listenGyro().stream,
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
            case ConnectionState.waiting:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            case ConnectionState.active:
              return Flexible(
                flex: 1,
                child: Text(
                  'Gyro ${snapshot.data!.display()}',
                  style: const TextStyle(fontSize: 20),
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
