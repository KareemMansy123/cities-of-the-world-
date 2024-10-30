import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.name ?? 'Unknown City',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Local Name: ${city.localName ?? 'Not available'}'),
                const SizedBox(height: 8),
                Text('Country ID: ${city.countryId ?? 'Not available'}'),
              ],
            ),
          ),
          const Divider(),

          // Google Map
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(city.lat ?? 0.0, city.lng ?? 0.0),
                zoom: 10,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(city.id.toString()),
                  position: LatLng(city.lat ?? 0.0, city.lng ?? 0.0),
                  infoWindow: InfoWindow(title: city.name),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
