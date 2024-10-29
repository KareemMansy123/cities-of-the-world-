import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class City {
  final int id;
  final String name;
  final String localName;
  final double? lat;
  final double? lng;
  final String createdAt;
  final String updatedAt;
  final int countryId;

  City({
    required this.id,
    required this.name,
    required this.localName,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
    required this.countryId,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
