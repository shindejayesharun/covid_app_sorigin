import 'package:covid_task_sorigin/feature/presentation/page/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Covid App',
          theme: ThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: DashboardPage(),
        );
      },
    );
  }
}
