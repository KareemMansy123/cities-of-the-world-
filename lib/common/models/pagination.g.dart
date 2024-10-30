// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      perPage: (json['perPage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'perPage': instance.perPage,
      'total': instance.total,
    };
