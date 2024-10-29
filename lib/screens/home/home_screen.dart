import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_bloc.dart';
import '../../blocs/city_bloc/city_event.dart';
import '../../blocs/city_bloc/city_state.dart';
import 'widgets/city_list_view.dart';
import 'widgets/city_map_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities of the World"),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              // Toggle between List and Map view by dispatching ToggleViewEvent
              context.read<CityBloc>().add(ToggleViewEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CityLoadedState) {
            if (state is CityListViewState) {
              return const CityListView();
            } else if (state is CityMapViewState) {
              return const CityMapView();
            } else {
              return const Center(child: Text("Unexpected state"));
            }
          } else if (state is CityErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
}
