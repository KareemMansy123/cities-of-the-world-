import 'package:cities_of_the_world/common/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'city_adapter.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse {
  final List<City> items;
  final Pagination pagination;
  final int time;

  CityResponse({
    required this.items,
    required this.pagination,
    required this.time,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}
