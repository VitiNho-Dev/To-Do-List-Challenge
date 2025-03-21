import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'config/dependencies.dart';
import 'routing/routes.dart';
import 'ui/core/themes/app_theme.dart';
import 'ui/details/ui/details_screen.dart';
import 'ui/details/view_models/detail_viewmodel.dart';
import 'ui/home/view_models/home_viewmodel.dart';
import 'ui/home/ui/home_screen.dart';

void main() {
  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) {
          return HomeScreen(viewmodel: GetIt.instance<HomeViewmodel>());
        },
        Routes.details: (context) {
          return DetailScreen(viewmodel: GetIt.instance<DetailViewmodel>());
        },
      },
    );
  }
}
