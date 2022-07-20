// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request()
  ..id = json['id'] as String?
  ..product = Product.fromJson(json['product'] as Map<String, dynamic>)
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..title = json['title'] as String?
  ..body = json['body'] as String;

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'product': instance.product.toJson(),
      'user': instance.user.toJson(),
      'title': instance.title,
      'body': instance.body,
    };
