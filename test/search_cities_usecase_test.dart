import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cities_of_the_world/common/models/city.dart';
import 'package:cities_of_the_world/common/repository/city_repository.dart';
import 'package:cities_of_the_world/common/user_case/search.dart';

import 'search_cities_usecase_test.mocks.dart';

@GenerateMocks([CityRepository])
void main() {
  late SearchCitiesUseCase searchCitiesUseCase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    searchCitiesUseCase = SearchCitiesUseCase(mockCityRepository);
  });

  test('searchCitiesUseCase should call searchCitiesByName on repository', () async {
    const query = "Test City";
    // Arrange: Set up a stub with a default return value for `searchCitiesByName`
    when(mockCityRepository.searchCitiesByName(query)).thenAnswer((_) async => <City>[]);

    // Act: Call the use case
    await searchCitiesUseCase.call(query);

    // Assert: Verify that the repository method was called with the correct query
    verify(mockCityRepository.searchCitiesByName(query)).called(1);
  });
}
