import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tope/src/globals.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  WidgetsFlutterBinding.ensureInitialized();
  Globals.prefs = await SharedPreferences.getInstance();
  runApp(MyApp(settingsController: settingsController));
}
