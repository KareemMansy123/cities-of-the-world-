import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_bloc.dart';

import '../../../blocs/city_bloc/city_state.dart';

class CityMapView extends StatelessWidget {
  const CityMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        if (state is CityLoadedState) {
          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
            markers: state.cities
                .map((city) => Marker(
              markerId: MarkerId(city.id.toString()),
              position: LatLng(city.lat, city.lng),
              infoWindow: InfoWindow(title: city.name, snippet: city.name),
            ))
                .toSet(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
