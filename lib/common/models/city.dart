import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'city.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class City {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? localName;

  @HiveField(3)
  final double? lat;

  @HiveField(4)
  final double? lng;

  @HiveField(5)
  final String? createdAt;

  @HiveField(6)
  final String? updatedAt;

  @HiveField(7)
  final int? countryId;

  City({
    required this.id,
    this.name,
    this.localName,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
    this.countryId,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
