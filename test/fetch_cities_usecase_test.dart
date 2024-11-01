import 'package:cities_of_the_world/common/repository/city_repository.dart';
import 'package:cities_of_the_world/common/user_case/city.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_cities_usecase_test.mocks.dart';

@GenerateMocks([CityRepository])
void main() {
  late FetchCitiesUseCase fetchCitiesUseCase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    fetchCitiesUseCase = FetchCitiesUseCase(mockCityRepository);
  });

  test('fetchCitiesUseCase should call fetchCities on repository', () async {
    await fetchCitiesUseCase.call(page: 1);
    verify(mockCityRepository.fetchCities(page: 1)).called(1);
  });
}
