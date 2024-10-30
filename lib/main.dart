import 'package:flutter/material.dart';
import 'app/di/injector.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}
