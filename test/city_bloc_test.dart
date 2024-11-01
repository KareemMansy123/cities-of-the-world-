import 'package:bloc_test/bloc_test.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_bloc.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_event.dart';
import 'package:cities_of_the_world/blocs/city_bloc/city_state.dart';
import 'package:cities_of_the_world/common/models/city.dart';
import 'package:cities_of_the_world/common/models/city_response.dart';
import 'package:cities_of_the_world/common/user_case/city.dart';
import 'package:cities_of_the_world/common/user_case/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'city_bloc_test.mocks.dart';

@GenerateMocks([FetchCitiesUseCase, SearchCitiesUseCase])
void main() {
  late MockFetchCitiesUseCase mockFetchCitiesUseCase;
  late MockSearchCitiesUseCase mockSearchCitiesUseCase;

  setUp(() {
    mockFetchCitiesUseCase = MockFetchCitiesUseCase();
    mockSearchCitiesUseCase = MockSearchCitiesUseCase();
  });

  blocTest<CityBloc, CityState>(
    'emits [CityLoadingState, CityLoadedState] when LoadCitiesEvent is added',
    build: () {
      when(mockFetchCitiesUseCase.call(page: 1))
          .thenAnswer((_) async => CityResponse(items: [City(id: 1, name: 'City 1')]));
      return CityBloc(
        fetchCitiesUseCase: mockFetchCitiesUseCase,
        searchCitiesUseCase: mockSearchCitiesUseCase,
      );
    },
    act: (bloc) => bloc.add(LoadCitiesEvent()),
    expect: () => [
      CityLoadingState(),
      isA<CityLoadedState>().having((state) => state.cities.length, 'city count', 1),
    ],
  );

  blocTest<CityBloc, CityState>(
    'emits [CityLoadingState, CityLoadedState] when SearchCitiesEvent is added',
    build: () {
      when(mockSearchCitiesUseCase.call("City"))
          .thenAnswer((_) async => [City(id: 1, name: 'City')]);
      return CityBloc(
        fetchCitiesUseCase: mockFetchCitiesUseCase,
        searchCitiesUseCase: mockSearchCitiesUseCase,
      );
    },
    act: (bloc) => bloc.add(SearchCitiesEvent("City")),
    expect: () => [
      CityLoadingState(),
      isA<CityLoadedState>().having((state) => state.cities.length, 'city count', 1),
    ],
  );
}
