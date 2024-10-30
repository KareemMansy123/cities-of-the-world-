import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Country {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? code;

  Country({required this.id, this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
