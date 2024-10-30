import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/common/utils.dart';
import '../../../blocs/city_bloc/city_bloc.dart';
import '../../../blocs/city_bloc/city_state.dart';

class CityMapView extends StatelessWidget {
  const CityMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        if (state is CityLoadedState) {
          return ListView.builder(
            itemCount: state.cities.length,
            itemBuilder: (context, index) {
              final city = state.cities[index];
              return ListTile(
                title: Text(city.name ?? ""),
                subtitle: Text(city.localName ?? ""),
                onTap: () {
                  if (city.lat != null && city.lng != null) {
                    openMap(city.lat!, city.lng!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Location not available')),
                    );
                  }
                },
              );
            },
          );
        } else if (state is CityErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
