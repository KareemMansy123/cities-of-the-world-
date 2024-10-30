import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/city_bloc/city_bloc.dart';
import '../../../blocs/city_bloc/city_event.dart';

class SearchBarWidget extends StatelessWidget {
  final CityBloc cityBloc;

  const SearchBarWidget({Key? key, required this.cityBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search cities...',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
      ),
      onChanged: (query) {
        cityBloc.add(SearchCitiesEvent(query));
      },
    );
  }
}