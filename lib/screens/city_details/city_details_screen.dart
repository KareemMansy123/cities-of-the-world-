import 'package:cities_of_the_world/screens/city_details/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import '../../common/models/city.dart';

class CityDetailsScreen extends StatelessWidget {
  final City city;

  const CityDetailsScreen({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name ?? 'City Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // City details
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (city.name != null) ...[
                  Text(
                    city.name!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
                if (city.localName != null) ...[
                  Text('Local Name: ${city.localName}'),
                  const SizedBox(height: 8),
                ],
                if (city.countryId != null) ...[
                  Text('Country ID: ${city.countryId}'),
                ] else ...[
                  const Text('Country ID: Not available'),
                ],
              ],
            ),
          ),
          const Divider(),
          // City map
          Expanded(
            child: CityMapWidget(
              latitude: city.lat ?? 40.7128,
              longitude: city.lng ?? -74.0060,
            ),
          ),
        ],
      ),
    );
  }
}
