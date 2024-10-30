import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/common/utils.dart';
import '../../../blocs/city_bloc/city_bloc.dart';
import '../../../blocs/city_bloc/city_event.dart';
import '../../../blocs/city_bloc/city_state.dart';

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

    // Trigger initial data load
    context.read<CityBloc>().add(LoadCitiesEvent());
  }

  void _onScroll() {
    final bloc = context.read<CityBloc>();
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        bloc.state is CityLoadedState &&
        (bloc.currentPage < (bloc.totalPages ?? 1))) {
      bloc.add(LoadMoreCitiesEvent(bloc.currentPage + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        if (state is CityLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CityLoadedState) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.cities.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.cities.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final city = state.cities[index];
              return ListTile(
                title: Text(city.name ?? ''),
                subtitle: Text(city.localName ?? ''),
                onTap: () {
                  // it always show snakbar coz your api always return null for lat and lng
                  if (city.lat != null && city.lng != null) {
                    openMap(city.lat!, city.lng!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Location not available')),
                    );
                  }
                }
              );
            },
          );
        } else {
          return const Center(child: Text("Failed to load cities"));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


