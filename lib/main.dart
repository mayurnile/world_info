import 'package:get/get.dart';
import 'package:flutter/material.dart';

import './core/core.dart';
import './di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(WorldInfo());
}

class WorldInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'World Info',
      theme: WorldInfoTheme.worldInfoThemeData,
      debugShowCheckedModeBanner: false,
      navigatorKey: di.locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
    );
  }
}
