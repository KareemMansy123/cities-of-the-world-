import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_bloc.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_state.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_event.dart';

import '../../../common/models/city_adapter.dart';

class CityListView extends StatefulWidget {
  const CityListView({Key? key}) : super(key: key);

  @override
  _CityListViewState createState() => _CityListViewState();
}

class _CityListViewState extends State<CityListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      context.read<CityBloc>().add(LoadMoreCitiesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        if (state is CityLoadedState) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.cities.length,
            itemBuilder: (context, index) {
              City city = state.cities[index];
              return ListTile(
                title: Text(city.name),
                subtitle: Text(city.name),
                onTap: () {
                  // Navigate to CityDetailsScreen with city data
                },
              );
            },
          );
        } else if (state is CityLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CityErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
