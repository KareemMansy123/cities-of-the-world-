// Mocks generated by Mockito 5.4.4 from annotations
// in cities_of_the_world/test/city_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:cities_of_the_world/common/models/city_response.dart' as _i3;
import 'package:cities_of_the_world/common/repository/city_repository.dart'
    as _i2;
import 'package:cities_of_the_world/common/user_case/city.dart' as _i4;
import 'package:cities_of_the_world/common/user_case/search.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCityRepository_0 extends _i1.SmartFake
    implements _i2.CityRepository {
  _FakeCityRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCityResponse_1 extends _i1.SmartFake implements _i3.CityResponse {
  _FakeCityResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FetchCitiesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchCitiesUseCase extends _i1.Mock
    implements _i4.FetchCitiesUseCase {
  MockFetchCitiesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CityRepository get cityRepository => (super.noSuchMethod(
        Invocation.getter(#cityRepository),
        returnValue: _FakeCityRepository_0(
          this,
          Invocation.getter(#cityRepository),
        ),
      ) as _i2.CityRepository);

  @override
  _i5.Future<_i3.CityResponse> call({
    int? page = 1,
    String? filter,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #page: page,
            #filter: filter,
          },
        ),
        returnValue: _i5.Future<_i3.CityResponse>.value(_FakeCityResponse_1(
          this,
          Invocation.method(
            #call,
            [],
            {
              #page: page,
              #filter: filter,
            },
          ),
        )),
      ) as _i5.Future<_i3.CityResponse>);
}

/// A class which mocks [SearchCitiesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchCitiesUseCase extends _i1.Mock
    implements _i6.SearchCitiesUseCase {
  MockSearchCitiesUseCase() {
    _i1.throwOnMissingStub(this);
  }
}