import 'package:flutter/material.dart';

import '../../common/models/city_adapter.dart';

class CityDetailsScreen extends StatelessWidget {
  final City city;

  const CityDetailsScreen({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Country: ${city.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Location: ${city.lat}, ${city.lng}", style: const TextStyle(fontSize: 16)),
            // Add more detailed information as needed
          ],
        ),
      ),
    );
  }
}
