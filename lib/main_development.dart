import 'package:flutter/material.dart';
import 'package:covid_task_sorigin/app.dart';
import 'package:covid_task_sorigin/config/base_url_config.dart';
import 'package:covid_task_sorigin/config/flavor_config.dart';
import 'package:covid_task_sorigin/injection_container.dart' as di;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  FlavorConfig(
    flavor: Flavor.DEVELOPMENT,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlDevelopment),
  );
  await di.init();
  runApp(App());
}