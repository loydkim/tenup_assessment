import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenup_project/restaurant/view/restaurant_page.dart';
import 'package:tenup_project/main_app.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:tenup_project/dashboard/view_model/dashboard_model.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String detailView = "/detail_view";

  static setUpRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      initialRoute: (context) => mainAppPage(),
    };
  }

  static setUpGenerateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case detailView:
            final arg = settings.arguments as DetailViewArgument;
            return RestaurantPage(
                arg.favoriteModel, arg.restaurant, arg.heroTag);
          default:
            return mainAppPage();
        }
      },
    );
  }

  static mainAppPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardModel()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()),
      ],
      child: const MainApp(),
    );
  }
}
