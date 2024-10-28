import 'package:untitled11/app/di.dart';
import 'package:untitled11/presentation/home/pages/home_page.dart';
import 'package:untitled11/presentation/home/widget/nav_bar.dart';
import 'package:untitled11/presentation/resources/strings_manager.dart';

import 'package:flutter/material.dart';
import 'package:untitled11/presentation/stroy/page/story_page.dart';
class Routes {
  static const String home = "/home";
  static const String navBar = "/navBar";
  static const String story = "/story";

}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>      HomePage());
      case Routes.navBar:
        initPostModule();
        initStoryModule();
        return MaterialPageRoute(builder: (_) =>      NavPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                    StringsManager.noRouteFound), // string to strings manager
              ),
              body: const Center(
                  child: Text(
                      StringsManager.noRouteFound)), //string to strings manager
            ));
  }
}

