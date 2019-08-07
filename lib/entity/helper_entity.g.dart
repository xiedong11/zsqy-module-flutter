// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelperEntity _$HelperEntityFromJson(Map<String, dynamic> json) {
  return HelperEntity()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..title = json['title'] as String
    ..detail = json['detail'] as String
    ..price = json['price'] as String
    ..where = json['where'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..start = json['start'] as String
    ..end = json['end'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HelperEntityToJson(HelperEntity instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'title': instance.title,
      'detail': instance.detail,
      'price': instance.price,
      'where': instance.where,
      'start': instance.start,
      'phoneNumber': instance.phoneNumber,
      'end': instance.end,
      'user': instance.user
    };
