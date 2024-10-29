import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'my_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  // Open the box for storing cities
  final cityBox = await Hive.openBox('cityBox');

  // Pass cityBox to MyApp
  runApp(MyApp(cityBox: cityBox));
}