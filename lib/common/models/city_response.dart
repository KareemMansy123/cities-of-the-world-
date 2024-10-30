import 'package:json_annotation/json_annotation.dart';
import 'city.dart';
import 'pagination.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse {
  final List<City>? items;
  final Pagination? pagination;

  CityResponse({this.items, this.pagination});

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}
