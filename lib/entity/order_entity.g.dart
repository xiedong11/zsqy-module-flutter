// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) {
  return OrderEntity()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..title = json['title'] as String
    ..type = json['type'] as String
    ..detail = json['detail'] as String
    ..price = json['price'] as String
    ..from = json['from'] as String
    ..destination = json['destination'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'title': instance.title,
      'type': instance.type,
      'detail': instance.detail,
      'price': instance.price,
      'from': instance.from,
      'destination': instance.destination,
      'phoneNumber': instance.phoneNumber,
      'user': instance.user
    };
