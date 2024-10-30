import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app/services/api_service.dart';
import 'common/models/city.dart';
import 'common/repository/city_repository.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with the application directory
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  // Register the City adapter
  Hive.registerAdapter(CityAdapter());

  // Open the Hive box with a specific type
  final cityBox = await Hive.openBox<City>('cityBox');

  // Initialize ApiService and CityRepository
  final apiService = ApiService(Dio());
  final cityRepository = CityRepository(apiService: apiService, cityBox: cityBox);

  runApp(MyApp(cityRepository: cityRepository));
}
