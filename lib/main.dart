import 'package:flutter/material.dart';
import 'package:local_db/local_db.dart';
import 'package:tenup_project/app_routes.dart';
import 'package:tenup_project/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10up Restauran Tour',
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.setUpRoutes(context),
      onGenerateRoute: (setting) => AppRoutes.setUpGenerateRoutes(setting),
      debugShowCheckedModeBanner: false,
    );
  }
}
