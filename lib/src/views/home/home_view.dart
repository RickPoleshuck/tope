import 'package:flutter/material.dart';
import 'package:tope/src/views/home/home_accel_list_view.dart';
import 'package:tope/src/views/home/home_up_view.dart';

import '../../settings/settings_view.dart';

/// Displays a list of SampleItems.
class HomeView extends StatefulWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tope'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeAccelListView(),
            HomeUpView(),
          ],
        ));
  }
}
