import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cities_of_the_world/blocs/search_bloc/search_bloc.dart';
import 'package:cities_of_the_world/common/base_state.dart';
import '../../blocs/search_bloc/search_event.dart';
import '../../common/models/city_adapter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Cities")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter city name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchCitiesEvent(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, BaseState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessState<List<City>>) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      City city = state.data[index];
                      return ListTile(
                        title: Text(city.name),
                        subtitle: Text(city.name),
                      );
                    },
                  );
                } else if (state is FailureState) {
                  return Center(child: Text(state.error));
                } else {
                  return const Center(child: Text("Enter a city name to search."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
