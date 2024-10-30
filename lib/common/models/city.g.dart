// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityAdapter extends TypeAdapter<City> {
  @override
  final int typeId = 0;

  @override
  City read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return City(
      id: fields[0] as int,
      name: fields[1] as String?,
      localName: fields[2] as String?,
      lat: fields[3] as double?,
      lng: fields[4] as double?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
      countryId: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.localName)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.lng)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.countryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      localName: json['localName'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      countryId: (json['countryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'localName': instance.localName,
      'lat': instance.lat,
      'lng': instance.lng,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'countryId': instance.countryId,
    };
